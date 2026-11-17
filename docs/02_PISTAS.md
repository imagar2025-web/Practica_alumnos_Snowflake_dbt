# Pistas progresivas (sin solución literal)

**Pista 1 · El error está en la relación, no en el SELECT.** Las dos tablas a la derecha de `JOIN` deben aportar las columnas que utilizan sus alias: `c.customer_name` y `p.product_name`.

**Pista 2 · Sigue el DAG desde las seeds.** El modelo final no debería saltarse el modelo que calcula `total_amount`.

**Pista 3 · Pregunta de negocio.** `status != 'PENDING'` también admite un estado que no cuenta como venta. Piensa en una lista positiva de estados facturables.

**Pista 4 · Los tests son una alarma.** El test singular `assert_no_cancelled_sales.sql` detecta pedidos que no cumplen la regla aunque el SQL sea técnicamente válido.
