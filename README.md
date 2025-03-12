# DataProject: Logica. Consultas SQL

## Introducción
Este proyecto tiene como objetivo la creación y análisis de **64 consultas SQL** para visualizar diferentes peticiones sobre una base de datos específica. Se trabajó con diferentes tipos de consultas, con el fin de extraer información relevante y evaluar el rendimiento de las consultas en distintos escenarios.

## Herramientas Utilizadas
- **Sistema de Gestión de Bases de Datos (SGBD):** PostgreSQL
- **Lenguaje de consulta:** SQL
- **Entorno de desarrollo:** DBeaver
- **Sistema Operativo:** Windows

## Instalación y Configuración
Para ejecutar las consultas, se siguio estos pasos:

1. **Instalar el SGBD** correspondiente.
2. **Cargar la base de datos:**
3. **Importar los datos** si es necesario:
4. **Verificar que las tablas se han cargado correctamente:**

## Descripción de las Consultas SQL
Se diseñaron y ejecutaron **64 consultas SQL** agrupadas en las siguientes categorías:

### Consultas Básicas
- Selección de datos con `SELECT`, `WHERE`, `ORDER BY`.
- Filtrado de datos con operadores lógicos y de comparación.

### Consultas Intermedias
- Uso de `JOIN` para combinar datos de múltiples tablas.
- Agregaciones con `GROUP BY` y `HAVING`.
- Subconsultas anidadas.

## Pasos Seguidos en el Proyecto
1. **Definición del alcance**: Determinar qué información se necesita extraer.
2. **Exploración de la base de datos**: Identificación de tablas, relaciones y estructura.
3. **Desarrollo de consultas**: Creación y prueba de las consultas en distintos escenarios.

## Análisis de Resultados
Se evaluaron las consultas en función de:
- **Eficiencia**: Comparación del tiempo de ejecución entre diferentes enfoques.
- **Precisión**: Verificación de los resultados obtenidos.
- **Optimización**: Uso de índices, reducción de subconsultas innecesarias, etc.

### Observaciones
- Se detectaron oportunidades de mejora en ciertas consultas mediante **indexación de columnas clave**.
- Se evidenció que el uso de `JOIN` en lugar de subconsultas **reduce significativamente el tiempo de ejecución** en consultas con grandes volúmenes de datos.
- Las funciones de ventana facilitaron la manipulación de datos sin necesidad de subconsultas adicionales.

