# Problemas frecuentes

| Síntoma | Causa probable | Comprobación |
|---|---|---|
| No aparece ningún comando dbt | Workspace no reconoce el proyecto | Selecciona carpeta con `dbt_project.yml` y perfil correcto; requiere función habilitada |
| Error de warehouse o role | Campos `REEMPLAZAR_...` aún en `profiles.yml` | Introduce nombres asignados, sin contraseñas |
| Insufficient privileges | No tienes permisos de uso o creación de objetos | Pide esquema propio y permisos al profesor; no cambies de rol a uno administrativo |
| `dbt seed` no carga | Perfil incorrecto o CSV no encontrado | Ejecuta desde la raíz del proyecto; revisa `seed-paths` y esquema |
| Invalid identifier `CUSTOMER_ID` | JOIN a staging de productos donde esperabas clientes | Revisa **PIEZA 1** y **PIEZA 2** |
| Invalid identifier `CUSTOMER_NAME` | El mart no lee del intermedio | Revisa **PIEZA 3** |
| El mart tiene 4 filas | Se está incluyendo un pedido cancelado | Revisa **PIEZA 4** |
| No ves un DAG correcto | Faltan correcciones o no has guardado/compilado | Guarda archivos, compila y vuelve a abrir DAG |
| `git push` no disponible | Se abrió el repositorio público en modo lectura | No hace falta hacer push para el puzzle |

No ejecutes `DROP SCHEMA` ni `CREATE OR REPLACE` fuera de un esquema de pruebas asignado.
