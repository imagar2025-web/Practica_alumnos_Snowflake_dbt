# Guía del alumno · Reconstruye el pipeline (30 min)

## Objetivo

No vas a escribir SQL desde cero. El proyecto contiene todas las piezas: **tres CSV, tres staging, un modelo intermedio y un mart**. Algunas referencias enlazan modelos equivocados; también hay una regla de facturación incorrecta. Debes localizarlo, corregirlo y comprobarlo.

### 0–5 min · Preparar tu propia cuenta Snowflake

**No utilizas ninguna base de datos del profesor.** Cada alumno trabaja en su propia cuenta trial de Snowflake, con su propio warehouse, base de datos y esquema.

1. Inicia sesión en **tu cuenta trial** y abre un **SQL Worksheet**.
2. Abre [`setup/01_crear_entorno.sql`](../setup/01_crear_entorno.sql), copia su contenido y ejecútalo. Crea `RIDERS_LAB_WH` (X-Small con suspensión automática), `RIDERS_LAB_DB` y el esquema `PUZZLE`.
3. Comprueba que el último `SELECT` devuelve esos nombres. Si `USE ROLE ACCOUNTADMIN` falla, utiliza un rol autorizado para crear bases de datos y warehouses; si tu trial está restringida, consulta al profesor.
4. Descarga/clona este repositorio y luego subelo añadiendolo al workspace de SnowFlake importandolo y ábrelo en un entorno dbt compatible con Snowflake. Si utilizas **Snowflake Workspaces**, comprueba que el proyecto y sus comandos `seed`, `run` y `build` estén disponibles; el modo de configurar la conexión puede variar respecto a dbt Core.
5. Si utilizas **dbt Core**, configura `profiles.yml` local con `database: RIDERS_LAB_DB`, `schema: PUZZLE`, `warehouse: RIDERS_LAB_WH` y `role: ACCOUNTADMIN`, además de la autenticación Snowflake de tu equipo. **No publiques credenciales ni tokens.** En Workspaces utiliza la conexión/perfil administrado por Snowflake según tu interfaz.

**Importante:** las cuentas trial son independientes. No hace falta que el profesor te conceda acceso a sus datos. GitHub solo distribuye los archivos; no necesitas hacer commits ni push para resolver el puzzle.

### 5–10 min · Cargar datos

Revisa `seeds/orders.csv`, `customers.csv` y `products.csv` (4 pedidos, 2 clientes y 2 productos). En el panel de comandos de dbt, ejecuta:

```bash
dbt seed
```

Debe cargar tres tablas en tu esquema. `dbt seed` no reconstruye los modelos: esa será la siguiente parte.

### 10–20 min · Localizar el problema de dependencias

1. Abre `models/staging/`: los tres modelos están correctos y usan `ref()` sobre las seeds.
2. Abre `models/intermediate/int_sales_enriched.sql` y busca los dos comentarios **PIEZA 1** y **PIEZA 2**. ¿Qué referencia debe aportar columnas de clientes? ¿Cuál columnas de productos?
3. Abre `models/marts/fct_sales.sql`. **PIEZA 3** necesita referirse al modelo del que realmente procede el mart.
4. Guarda los cambios y ejecuta `dbt run` o `dbt build`. Si un JOIN falla, comprueba el nombre de las columnas y la `ref()` utilizada.
5. Abre el **DAG** y contrasta las conexiones con el diagrama objetivo del README.

**Pista:** el `ref()` debe contener el **nombre del modelo**, no el de la tabla física que Snowflake genere.

### 20–25 min · Ajustar la lógica de negocio

El cuarto error está en la condición `WHERE` de `models/marts/fct_sales.sql`. **SHIPPED y DELIVERED son facturables; PENDING y CANCELLED no lo son.** Corrige esa condición, guarda y vuelve a ejecutar:

```bash
dbt build
```

Cuando termine, deberían pasar las pruebas de calidad. En particular `tests/assert_no_cancelled_sales.sql` devuelve filas si el mart incluye pedidos que no deberían facturarse.

### 25–30 min · Mostrar resultados

En el panel de dbt, ejecuta (si está disponible):

```bash
dbt show --select fct_sales
```

O ejecuta [`setup/02_verificar_resultado.sql`](../setup/02_verificar_resultado.sql) en Snowflake, que contiene:

```sql
select order_id, status, total_amount
from RIDERS_LAB_DB.PUZZLE.FCT_SALES
order by order_id;
```

Resultado esperado:

| Pedido | Estado | Total (€) |
|---|---|---:|
| 1001 | DELIVERED | 100,00 |
| 1002 | SHIPPED | 30,00 |
| 1003 | DELIVERED | 90,00 |

**Total: 3 pedidos, 220,00 €.** Enseña también el DAG final al profesor.

## Qué deberías poder explicar

- `ref()` crea una dependencia entre recursos dbt y ayuda a ordenar el DAG.
- Una seed es un CSV cargado por `dbt seed` como tabla.
- El staging es una vista y el mart es una tabla porque así se configura en `dbt_project.yml`.
- Las pruebas revisan propiedades del dato, no solo errores de sintaxis SQL.

Si te bloqueas, consulta [Pistas](02_PISTAS.md), no busques otra instalación de dbt.
