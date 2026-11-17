# Comprobación y entrega

Para esta charla **no se pide subir un repositorio nuevo**. Basta con mostrar al profesor o entregar **dos capturas**:

1. **DAG final de dbt** con las tres seeds, sus staging, el intermedio y el mart conectados (la visualización exacta puede variar).
2. **Resultado final** de `dbt show --select fct_sales` o consulta equivalente, con 3 pedidos y 220,00 €, y ejecución de tests en estado correcto.

La explicación oral debe responder: ¿por qué hay que construir staging antes de intermedio y mart? ¿Por qué no podemos contar `CANCELLED` como venta?

**Criterios**: relaciones `ref()` correctas; condición de facturación correcta; ejecución y pruebas; DAG comprensible.
