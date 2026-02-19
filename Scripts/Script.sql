-- Aplicaciones IEU (Master)

SELECT * FROM SISTEMAIEU.MASTERIEU.DBO.PLANTELES P

SELECT * FROM SISTEMAIEU.MASTERIEU.DBO.alumnos a

SELECT r.acuerdo, r.creditos, r.plan_master, r.fecha FROM SISTEMAIEU.MASTERIEU.DBO.rvoe r Order BY fecha DESC

SELECT
	COUNT(*)
FROM
    SISTEMAIEU.MASTERIEU.DBO.alumnos AS alumnos /* Nombre completo y alias */
INNER JOIN
    SISTEMAIEU.MASTERIEU.DBO.grupos AS grupos /* Nombre completo y alias */
    ON (alumnos.grupo = grupos.grupo) AND (alumnos.plantel = grupos.plantel)
WHERE
    alumnos.grad_tit_baja NOT IN ('BD', 'BO')
    AND FORMAT (DATEADD(month, grupos.pagos, grupos.primer_mensualidad), 'yyyy') = '2025'
    AND FORMAT (DATEADD(month, grupos.pagos, grupos.primer_mensualidad), 'MM') = '09';

SELECT
    alumnos.id,
    CONCAT(alumnos.nombre2, ' ', alumnos.apellidop, ' ', alumnos.apellidom) AS NombreCompletoAlumno,
    alumnos.plantel,
    alumnos.grupo,
    FORMAT (alumnos.fec_ingreso, 'yyyy-MM-dd') AS fec_ingreso_alumno,
    alumnos.telefono,
    alumnos.tel_oficina,
    alumnos.celular,
    alumnos.mail,
    alumnos.nivel,
    alumnos.sep,
    alumnos.grad_tit_baja,
    grupos.pagos, /* Referenciado como grupos.pagos */
    FORMAT (grupos.primer_mensualidad, 'yyyy-MM-dd') as primer_mensualidad,
    FORMAT (grupos.fec_ini, 'yyyy-MM-dd') as fec_ini,
    FORMAT (DATEADD(month, grupos.pagos, grupos.primer_mensualidad), 'yyyy-MM-dd') AS FechaT, /* Corregido DATEADD y usando grupos.pagos/grupos.primer_mensualidad */
    FORMAT (DATEADD(month, grupos.pagos, grupos.primer_mensualidad), 'yyyy')  as anio,
    FORMAT (DATEADD(month, grupos.pagos, grupos.primer_mensualidad), 'MM')  as mes
FROM
    SISTEMAIEU.MASTERIEU.DBO.alumnos AS alumnos /* Nombre completo y alias */
INNER JOIN
    SISTEMAIEU.MASTERIEU.DBO.grupos AS grupos /* Nombre completo y alias */
    ON (alumnos.grupo = grupos.grupo) AND (alumnos.plantel = grupos.plantel)
WHERE
    alumnos.grad_tit_baja NOT IN ('BD', 'BO')
    AND FORMAT (DATEADD(month, grupos.pagos, grupos.primer_mensualidad), 'yyyy') = '2025'
    AND FORMAT (DATEADD(month, grupos.pagos, grupos.primer_mensualidad), 'MM') = '12';

EXEC sp_tables_ex
    @table_server = 'SISTEMAIEU',
    @table_catalog = 'MASTERIEU',   
    @table_schema = 'dbo',       
    @table_type = '''TABLE''';  

SELECT *
FROM OPENQUERY([SISTEMAIEU], '
    SELECT TABLE_NAME
    FROM MASTERIEU.INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = ''dbo''
      AND TABLE_TYPE = ''BASE TABLE''
');


SELECT consecutivo, plantel, maestria, cct, acuerdo, fecha, creditos, materias, tipo, nivel, vigente   FROM SISTEMAIEU.MASTERIEU.DBO.rvoe ORDER BY fecha DESC, maestria 

SELECT * FROM SISTEMAIEU.MASTERIEU.DBO.maestrias m

SELECT * FROM SISTEMAIEU.MASTERIEU.DBO.calificaciones c ORDER By fecha DESC

SELECT
    NombreTabla,
    Orden,
    NombreColumna,
    TipoDato,
    LongitudMaxima,
    EsNulo
FROM OPENQUERY([SISTEMAIEU], '
    SELECT
        TABLE_NAME              AS NombreTabla,
        ORDINAL_POSITION        AS Orden,
        COLUMN_NAME             AS NombreColumna,
        DATA_TYPE               AS TipoDato,
        CHARACTER_MAXIMUM_LENGTH AS LongitudMaxima,
        IS_NULLABLE             AS EsNulo
    FROM MASTERIEU.INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = ''dbo''
    ORDER BY TABLE_NAME, ORDINAL_POSITION
');

SELECT
    m.nombre AS ProgramaEducativo,
    r.acuerdo AS Numero_RVOE,
    r.fecha AS Fecha_Otorgamiento,
    r.dgp AS Clave_DGP,
    r.tipo_semestre,
    r.tipo_SEP,
    r.vigente             
FROM SISTEMAIEU.MasterIEU.dbo.maestrias m
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.rvoe r ON m.clave = r.maestria
ORDER BY r.fecha DESC;

SELECT
    p.razon_social AS Plantel,
    p.ciudad AS Campus,
    n.nivel AS Nivel_Educativo,
    m.nombre AS Programa_Educativo,
    r.tipo AS Modalidad,         -- Campo inferido como Modalidad
    r.acuerdo AS Numero_RVOE,
    r.fecha AS Fecha_RVOE
FROM SISTEMAIEU.MasterIEU.dbo.maestrias m
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.rvoe r ON m.clave = r.maestria
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.planteles p ON r.plantel = p.clave
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.niveles n ON r.nivel = n.clave
ORDER BY
    p.razon_social,
    n.orden,
    m.nombre;

SELECT
    a.id AS Matricula,
    CONCAT(a.nombre, ' ', a.apellidop, ' ', a.apellidom) AS Nombre_Completo,
    m.nombre AS Programa_Educativo,
    r.acuerdo AS RVOE_Asignado,
    r.fecha AS Fecha_RVOE,
    p.ciudad AS Campus
FROM SISTEMAIEU.MasterIEU.dbo.alumnos a
    -- 1. Primero identificamos el nombre del programa
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.maestrias m ON a.maestria = m.clave
    -- 2. Luego buscamos el RVOE específico para ese programa EN ESE plantel
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.rvoe r ON a.maestria = r.maestria AND a.plantel = r.plantel
    -- 3. (Opcional) Traemos el nombre del plantel para validar
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.planteles p ON a.plantel = p.clave
-- Filtro opcional: solo activos o un alumno específico
WHERE a.id = '161552'
ORDER BY
    a.apellidop, a.apellidom, r.fecha DESC

SELECT
    m.nombres AS Materia,
    c.calificacion AS Nota_Final,
    c.calif_alfa AS Nota_Letra, -- Por si usan "NA", "A", etc.
    c.fecha AS Fecha_Evaluacion,
    c.grupo AS Grupo,
    -- Opcional: Tipo de examen (Ordinario, Extraordinario, etc.)
    -- Dependiendo de tu catálogo de tipos, podrías necesitar un CASE aquí
    c.tipo AS Tipo_Examen_ID
FROM SISTEMAIEU.MasterIEU.dbo.calificaciones c
INNER JOIN SISTEMAIEU.MasterIEU.dbo.materias m ON c.materia = m.clave
WHERE c.alumno = '161552' -- Reemplaza con el ID real
ORDER BY c.fecha DESC;

SELECT
    m.nombres AS Materia_Actual,
    i.programa AS Programa_ID
FROM SISTEMAIEU.MasterIEU.dbo.inscripcion i
INNER JOIN SISTEMAIEU.MasterIEU.dbo.materias m ON i.materia = m.clave
WHERE i.alumno = '86418';


SELECT
    p.razon_social AS Plantel,
    p.ciudad AS Campus,
    n.nivel AS Nivel_Educativo,
    m.nombre AS Programa_Educativo,
    -- 1. Regla de Modalidad Operativa (Basada en ID de Plantel)
    CASE 
        WHEN r.plantel = 65 THEN 'Online'
        WHEN r.plantel = 96 THEN 'Ejecutiva'
        ELSE 'Presencial'
    END AS Modalidad_Operativa,
    -- 2. Regla de Modalidad SEP (Basada en Código de RVOE)
    CASE r.tipo
        WHEN 'E' THEN 'Escolarizado'
        WHEN 'N' THEN 'No Escolarizado'
        WHEN 'F' THEN 'No Escolarizada Flexible Por Créditos'
        WHEN 'S' THEN 'SemiEscolarizado'
        WHEN 'T' THEN 'No Escolarizada por Créditos'
        WHEN 'X' THEN 'Mixta'
        ELSE 'Escolarizado' -- Cubre NULL y cualquier otro caso no listado
    END AS Modalidad_SEP,
    r.acuerdo AS Numero_RVOE,
    r.fecha AS Fecha_RVOE
FROM SISTEMAIEU.MasterIEU.dbo.maestrias m
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.rvoe r ON m.clave = r.maestria
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.planteles p ON r.plantel = p.clave
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.niveles n ON r.nivel = n.clave
ORDER BY
    p.razon_social,
    n.orden,
    m.nombre;


SELECT
    a.id AS Matricula,
    CONCAT(a.nombre, ' ', a.apellidop, ' ', a.apellidom) AS Alumno,
    m.nombre AS Programa_Educativo,
    COUNT(DISTINCT c.materia) AS Total_Materias_Aprobadas,
    MAX(c.fecha) AS Ultima_Fecha_Captura,
    MAX(c.fecha_r) AS Ultima_Fecha_Boleta
FROM SISTEMAIEU.MasterIEU.dbo.alumnos a
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.niveles n ON a.nivel = n.clave
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.calificaciones c ON a.id = c.alumno
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.maestrias m ON a.maestria = m.clave
WHERE
    a.grad_tit_baja NOT IN ('BD', 'BO')
    --AND n.nivel LIKE '%licenciatura%'
    AND (c.calificacion >= 1 OR c.calificacion_extra >= 1)
GROUP BY
    a.id,
    a.nombre,
    a.apellidop,
    a.apellidom,
    m.nombre
HAVING
    COUNT(DISTINCT c.materia) = 35
    -- FILTRO: Solo alumnos cuya última calificación fue registrada este año
    -- AND DATEDIFF(day, MAX(c.fecha), GETDATE()) <= 30
    -- AND YEAR(MAX(c.fecha)) = YEAR(GETDATE())
    AND YEAR(MAX(c.fecha)) = 2025
	-- AND MONTH(MAX(c.fecha)) = MONTH(GETDATE())
    -- AND MONTH(MAX(c.fecha)) = 12

SELECT
    -- 1. Contexto Institucional
    p.razon_social AS Plantel,
    p.ciudad AS Campus,
    n.nivel AS Nivel_Educativo,
    m.nombre AS Programa_Educativo,
    -- 2. Reglas de Negocio: Modalidades
    CASE 
        WHEN r.plantel = 65 THEN 'Online'
        WHEN r.plantel = 96 THEN 'Ejecutiva'
        ELSE 'Presencial'
    END AS Modalidad_Operativa,
    CASE r.tipo
        WHEN 'E' THEN 'Escolarizado'
        WHEN 'N' THEN 'No Escolarizado'
        WHEN 'F' THEN 'No Escolarizada Flexible Por Créditos'
        WHEN 'S' THEN 'SemiEscolarizado'
        WHEN 'T' THEN 'No Escolarizada por Créditos'
        WHEN 'X' THEN 'Mixta'
        ELSE 'Escolarizado' 
    END AS Modalidad_SEP,
    -- 3. Detalles del RVOE
    r.acuerdo AS Numero_RVOE,
    r.fecha AS Fecha_RVOE, -- Aquí está el dato clave
    r.materias AS Cantidad_Materias_RVOE, 
    -- 4. Clasificaciones Técnicas
    r.tipo_semestre AS Tipo_Ciclo_ID, 
    r.tipo AS Codigo_Tipo,
    r.tipo_SEP AS Descripcion_Tipo_SEP,
    -- 5. Estatus
    CASE 
        WHEN r.vigente = 1 THEN 'Vigente' 
        ELSE 'No Vigente' 
    END AS Estatus_Vigencia
FROM SISTEMAIEU.MasterIEU.dbo.rvoe r
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.maestrias m ON r.maestria = m.clave
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.planteles p ON r.plantel = p.clave
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.niveles n ON r.nivel = n.clave
ORDER BY
    r.fecha DESC,  -- Prioridad 1: Los más recientes primero
    p.razon_social ASC, -- Prioridad 2: Alfabético por plantel (para desempatar fechas iguales)
    m.nombre ASC;       -- Prioridad 3: Alfabético por programa
    
    
SELECT
    a.id AS Matricula,
    CONCAT(a.nombre, ' ', a.apellidop, ' ', a.apellidom) AS Alumno,
    m.nombres AS Materia,
    c.calificacion AS Calificacion_Final,
    c.fecha AS Fecha_Captura -- Esta es la fecha real de registro en sistema
FROM SISTEMAIEU.MasterIEU.dbo.alumnos a
    -- Unimos con la tabla transaccional de calificaciones
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.calificaciones c ON a.id = c.alumno
    -- Unimos con el catálogo para obtener el nombre de la materia
    INNER JOIN SISTEMAIEU.MasterIEU.dbo.materias m ON c.materia = m.clave
WHERE 
    a.id = '175534'
ORDER BY 
    c.fecha DESC; -- Ordenamos cronológicamente (lo más reciente arriba)
    
    


SELECT
	Alumno.id AS matricula,
	Alumno.nombre2 AS nombre,
	Alumno.apellidop AS apellido_paterno,
	Alumno.apellidom AS apellido_materno,
	Alumno.grupo,
	Alumno.grad_tit_baja AS estatus_master,
	FORMAT (Alumno.fec_ingreso,
	'yyyy-MM-dd') AS fecha_ingreso_alumno,
	Alumno.plantel AS plantel_id,
	Plantel.razon_social AS plantel_nombre,
	Alumno.nivel AS nivel_id,
	Nivel.nivel AS nivel_nombre,
	Alumno.maestria AS programa_id,
	Programa.nombre AS programa_nombre,
    Grupo.pagos AS cantidad_pagos,
    FORMAT (Grupo.primer_mensualidad, 'yyyy-MM-dd') AS primer_mensualidad,
    FORMAT (Grupo.fec_ini, 'yyyy-MM-dd') AS fecha_inicio_grupo,
    FORMAT (DATEADD(month, Grupo.pagos, Grupo.primer_mensualidad), 'yyyy-MM-dd') AS fecha_egreso, /* Corregido DATEADD y usando grupos.pagos/grupos.primer_mensualidad */
    FORMAT (DATEADD(month, Grupo.pagos, Grupo.primer_mensualidad), 'yyyy')  AS anio_egreso,
    FORMAT (DATEADD(month, Grupo.pagos, Grupo.primer_mensualidad), 'MM')  AS mes_egreso
FROM
	SISTEMAIEU.MASTERIEU.DBO.ALUMNOS Alumno
JOIN SISTEMAIEU.MASTERIEU.DBO.PLANTELES Plantel on
	Alumno.plantel = Plantel.clave
JOIN SISTEMAIEU.MASTERIEU.DBO.NIVELES Nivel on
	Alumno.nivel = Nivel.clave
JOIN SISTEMAIEU.MASTERIEU.DBO.MAESTRIAS Programa on
	Alumno.maestria = Programa.clave
JOIN SISTEMAIEU.MASTERIEU.DBO.GRUPOS Grupo on
	(Alumno.grupo = Grupo.grupo)
	AND (Alumno.plantel = Grupo.plantel)
WHERE
	Alumno.grad_tit_baja NOT IN ('BD', 'BO')
	AND FORMAT (DATEADD(month, Grupo.pagos, Grupo.primer_mensualidad), 'yyyy') = '2026'
	AND FORMAT (DATEADD(month, Grupo.pagos, Grupo.primer_mensualidad), 'MM') = '08';


WITH RvoePorAlumno AS (
    SELECT
        Alumno.id AS matricula,
        Nivel.clave AS nivel_id,
        Nivel.nivel,
        Programa.clave AS programa_id,
       	Programa.nombre AS programa_educativo,
        RVOE.tipo,
        RVOE.tipo_semestre AS periodicidad,
        RVOE.materias AS cantidad_materias,
        RVOE.fecha, -- Necesitamos la fecha pura para ordenar
        -- Asignamos un número de fila por Alumno, ordenando por fecha descendente
        ROW_NUMBER() OVER(
            PARTITION BY Alumno.id 
            ORDER BY RVOE.fecha DESC
        ) as rn
    FROM
        SISTEMAIEU.MASTERIEU.DBO.ALUMNOS Alumno
    JOIN SISTEMAIEU.MASTERIEU.DBO.PLANTELES Plantel ON
        Alumno.plantel = Plantel.clave
    JOIN SISTEMAIEU.MASTERIEU.DBO.NIVELES Nivel ON
        Alumno.nivel = Nivel.clave
    JOIN SISTEMAIEU.MASTERIEU.DBO.MAESTRIAS Programa ON
        Alumno.maestria = Programa.clave
    JOIN SISTEMAIEU.MASTERIEU.DBO.RVOE RVOE ON
        Programa.clave = RVOE.maestria
        AND Nivel.clave = RVOE.nivel
    WHERE 
        Alumno.id IN ('198155', '199079')
)
SELECT
    matricula,
    nivel_id,
    nivel,
    programa_id,
    programa_educativo,
    tipo,
    periodicidad,
    cantidad_materias,
    FORMAT(fecha, 'yyyy/MM/dd') AS fecha_acuerdo
FROM 
    RvoePorAlumno
WHERE 
    rn = 1 -- Nos quedamos solo con el #1 (el más reciente)
ORDER BY 
    matricula;

SELECT DISTINCT
    R.nivel,
    M.clave,
    M.nombre AS Nombre_Maestria,
    R.acuerdo AS RVOE,
    R.fecha AS Fecha_RVOE,
    R.cct AS CCT,
    R.vigente
FROM SISTEMAIEU.MASTERIEU.DBO.maestrias AS M
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.rvoe AS R 
    ON M.clave = R.maestria
ORDER BY 
    R.nivel ASC, 
    M.nombre ASC, 
    R.fecha DESC;
            

SELECT * FROM SISTEMAIEU.MASTERIEU.DBO.niveles

SELECT * FROM SISTEMAIEU.MASTERIEU.DBO.planteles WHERE clave = 65

SELECT * FROM SISTEMAIEU.MASTERIEU.DBO.maestrias WHERE clave = 1

SELECT * FROM SISTEMAIEU.MASTERIEU.DBO.rvoe

SELECT * FROM SISTEMAIEU.MASTERIEU.DBO.grupos


SELECT 
    plantel, 
    maestria, 
    COUNT(*) AS total_registros
FROM 
    SISTEMAIEU.MASTERIEU.DBO.rvoe
GROUP BY 
    plantel, 
    maestria
ORDER BY 
    total_registros DESC;

SELECT 
    p.razon_social AS NombrePlantel,
    m.nombre AS NombreMaestria,
    r.plantel AS ID_Plantel,
    r.maestria AS ID_Maestria,
    COUNT(*) AS total_registros
FROM 
    SISTEMAIEU.MASTERIEU.DBO.rvoe r
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.planteles p ON r.plantel = p.clave
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.maestrias m ON r.maestria = m.clave
WHERE 
    r.acuerdo IS NOT NULL 
    AND r.acuerdo <> 'SIN RVOE'
GROUP BY 
    p.razon_social,
    m.nombre,
    r.plantel, 
    r.maestria
ORDER BY 
    total_registros DESC;

SELECT 
    r.consecutivo,
    p.razon_social AS NombrePlantel,  -- Agregado para identificar el plantel
    m.nombre AS NombreMaestria,       -- Agregado para identificar la maestría 
    r.cct, 
    r.acuerdo,  
    r.creditos, 
    r.materias, 
    r.tipo, 
    r.nivel, 
    r.vigente,
    r.plantel, 
    r.maestria,
    r.fecha
FROM 
    SISTEMAIEU.MASTERIEU.DBO.rvoe r
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.planteles p ON r.plantel = p.clave
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.maestrias m ON r.maestria = m.clave
WHERE r.plantel = 65 and r.maestria = 1
ORDER BY 
    r.fecha DESC, 
    r.maestria;

SELECT 
    a.id AS Matrícula,
    a.nombre AS NombreAlumno,
    a.fec_ingreso AS FechaIngresoAlumno,
    r.acuerdo AS AcuerdoRVOE,
    r.fecha AS FechaRVOE,
    r.consecutivo AS ID_RVOE,
    p.razon_social AS Plantel,
    m.nombre AS Maestria
FROM 
    SISTEMAIEU.MASTERIEU.DBO.alumnos a
-- 1. Unimos con los catálogos para tener los nombres legibles
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.planteles p ON a.plantel = p.clave
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.maestrias m ON a.maestria = m.clave
-- 2. Unimos con la tabla RVOE usando la LLAVE COMPUESTA EXACTA
INNER JOIN 
    SISTEMAIEU.MASTERIEU.DBO.rvoe r ON 
        a.plantel = r.plantel AND
        a.maestria = r.maestria AND
        a.plan_master = r.plan_master AND
        a.planv = r.planv
WHERE 
    a.id = '100161' -- Filtra aquí por un alumno específico si gustas
ORDER BY 
    a.fec_ingreso DESC;


WITH RvoeCandidatos AS (
    SELECT 
        a.id AS Matrícula,
        r.consecutivo AS ID_RVOE,
        r.acuerdo,
        r.fecha,
        -- Calculamos un puntaje de "Calidad de Coincidencia"
        CASE 
            -- Si coincide TODO (Plan y Versión), le damos 100 puntos
            WHEN ISNULL(a.plan_master, '') = ISNULL(r.plan_master, '') 
                 AND ISNULL(a.planv, '') = ISNULL(r.planv, '') THEN 100 
            -- Si solo coincide Plantel y Maestría, le damos 50 puntos
            ELSE 50 
        END AS PuntajeMatch
    FROM 
        SISTEMAIEU.MASTERIEU.DBO.alumnos a
    -- Usamos JOIN normal solo por Plantel y Maestría (lo mínimo necesario)
    INNER JOIN 
        SISTEMAIEU.MASTERIEU.DBO.rvoe r ON a.plantel = r.plantel AND a.maestria = r.maestria
    WHERE 
        -- Filtra por tus alumnos de interés
        a.id IN ('100161', '101017', '170082', '176583') 
        -- REGLA DE TIEMPO: El RVOE debe ser anterior o igual al ingreso
        AND r.fecha <= a.fec_ingreso
),
BestRvoe AS (
    SELECT 
        Matrícula,
        ID_RVOE,
        acuerdo,
        fecha,
        -- Ranking: 
        -- 1. Priorizamos el Puntaje más alto (Exacto > Genérico)
        -- 2. Si hay empate, priorizamos la fecha más reciente (El RVOE más nuevo válido)
        ROW_NUMBER() OVER (
            PARTITION BY Matrícula 
            ORDER BY PuntajeMatch DESC, fecha DESC
        ) AS ranking
    FROM 
        RvoeCandidatos
)
SELECT 
    a.id AS Matrícula,
    a.nombre AS NombreAlumno,
    a.fec_ingreso AS FechaIngresoAlumno,
    br.acuerdo AS AcuerdoRVOE,
    br.fecha AS FechaRVOE,
    p.razon_social AS Plantel,
    m.nombre AS Maestria
FROM 
    SISTEMAIEU.MASTERIEU.DBO.alumnos a
-- Unimos con el mejor candidato encontrado (Ranking 1)
LEFT JOIN 
    BestRvoe br ON a.id = br.Matrícula AND br.ranking = 1
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.planteles p ON a.plantel = p.clave
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.maestrias m ON a.maestria = m.clave
WHERE 
    a.id IN ('100161', '101017', '170082', '176583')
ORDER BY 
    a.fec_ingreso DESC;

SELECT 
    a.id AS Matrícula,
    a.nombre AS NombreAlumno,
    a.fec_ingreso AS FechaIngreso,
    -- Datos Crudos del Alumno (Lo que buscamos)
    a.plan_master AS Alumno_Plan,
    a.planv AS Alumno_Version,
    a.plantel AS ID_Plantel,
    a.maestria AS ID_Maestria,
    --------------------------------------------------
    -- Datos Crudos del RVOE (Lo que encontramos)
    r.consecutivo AS RVOE_ID,
    r.acuerdo AS RVOE_Acuerdo,
    r.fecha AS RVOE_Fecha,
    r.plan_master AS RVOE_Plan,
    r.planv AS RVOE_Version,
    --------------------------------------------------
    -- Análisis Automático del Fallo
    CASE 
        WHEN r.consecutivo IS NULL THEN '❌ NO HAY MATCH DE PLANTEL/MAESTRÍA'
        WHEN r.fecha > a.fec_ingreso THEN '⚠️ RVOE FUTURO (El alumno entró antes de la fecha del acuerdo)'
        ELSE '✅ FECHA VÁLIDA'
    END AS Diagnostico_Fecha,
    CASE 
        WHEN ISNULL(a.plan_master,'') <> ISNULL(r.plan_master,'') THEN '⚠️ PLAN DIFERENTE'
        WHEN ISNULL(a.planv,'') <> ISNULL(r.planv,'') THEN '⚠️ VERSIÓN DIFERENTE'
        ELSE '✅ PLAN EXACTO'
    END AS Diagnostico_Plan
FROM 
    SISTEMAIEU.MASTERIEU.DBO.alumnos a
-- Usamos LEFT JOIN sin restricciones de fecha/plan para ver TODO lo que existe
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.rvoe r ON a.plantel = r.plantel AND a.maestria = r.maestria
WHERE 
    a.id IN ('176583', '170082', '101017', '100161') -- Tus casos nulos
ORDER BY 
    a.id, 
    r.fecha DESC;

WITH RvoeCandidatos AS (
    SELECT 
        a.id AS Matrícula,
        r.consecutivo AS ID_RVOE,
        r.acuerdo,
        r.fecha,
        -- SISTEMA DE PUNTAJE (Prioridad)
        CASE 
            -- 100 Puntos: Coincidencia Exacta de Plan y Versión (Ideal)
            WHEN ISNULL(a.plan_master, '') = ISNULL(r.plan_master, '') 
                 AND ISNULL(a.planv, '') = ISNULL(r.planv, '') THEN 100 
            ELSE 50 
        END AS PuntajeMatch
    FROM 
        SISTEMAIEU.MASTERIEU.DBO.alumnos a
    INNER JOIN 
        SISTEMAIEU.MASTERIEU.DBO.rvoe r ON a.plantel = r.plantel AND a.maestria = r.maestria
    WHERE 
        -- IMPORTANTE: Aquí NO filtramos por ID de alumno para no limitar la consulta.
        -- Solo aplicamos la regla de negocio temporal:
        r.fecha <= a.fec_ingreso
),
BestRvoe AS (
    SELECT 
        Matrícula,
        ID_RVOE,
        acuerdo,
        fecha,
        -- RANKING FINAL
        ROW_NUMBER() OVER (
            PARTITION BY Matrícula 
            ORDER BY 
                PuntajeMatch DESC, -- 1. Preferimos el mismo Plan
                fecha DESC         -- 2. Preferimos el RVOE más reciente
        ) AS ranking
    FROM 
        RvoeCandidatos
)
SELECT 
    a.id AS matrícula,
    br.acuerdo AS rvoe_acuerdo,
    br.fecha AS rvoe_fecha,
    p.razon_social AS plantel,
    m.nombre AS maestria
FROM 
    SISTEMAIEU.MASTERIEU.DBO.alumnos a
-- Hacemos MATCH con el Ganador del Ranking (Posición 1)
LEFT JOIN 
    BestRvoe br ON a.id = br.Matrícula AND br.ranking = 1
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.planteles p ON a.plantel = p.clave
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.maestrias m ON a.maestria = m.clave
WHERE 
    -- AHORA SÍ: Filtra aquí los alumnos que quieras revisar
    a.id IN (151524, 167541, 167561, 175504, 175509, 175511, 175514, 175515, 175615, 175800, 136267, 174253)
ORDER BY 
    a.fec_ingreso DESC;


WITH AcuerdosCompartidos AS (
    SELECT 
        acuerdo
    FROM 
        SISTEMAIEU.MASTERIEU.DBO.rvoe
    WHERE 
        acuerdo IS NOT NULL 
        AND acuerdo NOT LIKE '%SIN RVOE%' -- Ignoramos los genéricos
    GROUP BY 
        acuerdo
    -- El truco: Contamos combinaciones únicas de Plantel + Maestría
    -- Si un acuerdo tiene más de 1 combinación distinta, es compartido.
    HAVING 
        COUNT(DISTINCT CAST(plantel AS VARCHAR) + '-' + CAST(maestria AS VARCHAR)) > 1
)
SELECT 
    r.acuerdo AS Acuerdo_Compartido,
    r.consecutivo AS ID_Registro,
    p.razon_social AS Plantel,
    m.nombre AS Maestria,
    r.fecha AS Fecha_RVOE,
    r.tipo
FROM 
    SISTEMAIEU.MASTERIEU.DBO.rvoe r
-- Filtramos solo los acuerdos que detectamos como compartidos
INNER JOIN 
    AcuerdosCompartidos ac ON r.acuerdo = ac.acuerdo
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.planteles p ON r.plantel = p.clave
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.maestrias m ON r.maestria = m.clave
ORDER BY 
    r.acuerdo, 
    p.razon_social, 
    m.nombre;


WITH RvoeCandidatos AS (
            SELECT
                a.id AS Matricula,
                r.consecutivo AS ID_RVOE,
                r.acuerdo,
                r.fecha,
                CASE
                    WHEN ISNULL(a.plan_master, '') = ISNULL(r.plan_master, '')
                         AND ISNULL(a.planv, '') = ISNULL(r.planv, '') THEN 100
                    ELSE 50
                END AS PuntajeMatch
            FROM
                SISTEMAIEU.MASTERIEU.DBO.alumnos a
            INNER JOIN
                SISTEMAIEU.MASTERIEU.DBO.rvoe r ON a.plantel = r.plantel AND a.maestria = r.maestria
            WHERE
                a.id IN (151524, 167541, 167561, 175504, 175509, 175511, 175514, 175515, 175615, 175800, 136267, 174253)
                AND r.fecha <= a.fec_ingreso
        ),
        BestRvoe AS (
            SELECT
                Matricula,
                ID_RVOE,
                acuerdo,
                fecha,
                ROW_NUMBER() OVER (
                    PARTITION BY Matricula
                    ORDER BY
                        PuntajeMatch DESC,
                        fecha DESC
                ) AS ranking
            FROM
                RvoeCandidatos
        )
        SELECT
            a.id AS matricula,
            br.acuerdo AS rvoe_acuerdo,
            FORMAT(br.fecha, 'yyyy-MM-dd') AS rvoe_fecha,
            r.tipo AS rvoe_tipo,
            r.tipo_semestre AS rvoe_periodicidad,
            r.materias AS rvoe_cantidad_materias,
            p.razon_social AS plantel,
            m.nombre AS maestria
        FROM
            SISTEMAIEU.MASTERIEU.DBO.alumnos a
        LEFT JOIN
            BestRvoe br ON a.id = br.Matricula AND br.ranking = 1
        LEFT JOIN
            SISTEMAIEU.MASTERIEU.DBO.rvoe r ON br.acuerdo = r.acuerdo
        LEFT JOIN
            SISTEMAIEU.MASTERIEU.DBO.planteles p ON a.plantel = p.clave
        LEFT JOIN
            SISTEMAIEU.MASTERIEU.DBO.maestrias m ON a.maestria = m.clave
        WHERE
            a.id IN (151524, 167541, 167561, 175504, 175509, 175511, 175514, 175515, 175615, 175800, 136267, 174253)
        ORDER BY
            a.fec_ingreso DESC
            
WITH RvoeAsignado AS (
    -- 1. Encontramos el RVOE correcto para cada alumno (Lógica Robust)
    SELECT 
        a.id AS Matrícula,
        r.nivel AS ID_Nivel,
        r.tipo_semestre,
        ROW_NUMBER() OVER (
            PARTITION BY a.id 
            ORDER BY 
                CASE WHEN ISNULL(a.plan_master, '') = ISNULL(r.plan_master, '') AND ISNULL(a.planv, '') = ISNULL(r.planv, '') THEN 100 ELSE 50 END DESC, 
                r.fecha DESC
        ) AS ranking
    FROM 
        SISTEMAIEU.MASTERIEU.DBO.alumnos a
    INNER JOIN 
        SISTEMAIEU.MASTERIEU.DBO.rvoe r ON a.plantel = r.plantel AND a.maestria = r.maestria
    WHERE 
        r.fecha <= a.fec_ingreso
),
ConteoMaterias AS (
    -- 2. Contamos cuántas materias únicas tienen calificación registrada
    SELECT 
        alumno,
        COUNT(DISTINCT materia) AS TotalMaterias
    FROM 
        SISTEMAIEU.MASTERIEU.DBO.calificaciones
    -- Opcional: Si 'calificacion' puede ser NULL, descomenta la siguiente línea:
    -- WHERE calificacion IS NOT NULL
    GROUP BY 
        alumno
)
SELECT 
    a.id AS Matrícula,
    a.nombre AS NombreAlumno,
    n.nivel AS NivelAcademico,
    cm.TotalMaterias,
    a.grad_tit_baja AS Status
FROM 
    SISTEMAIEU.MASTERIEU.DBO.alumnos a
-- Unimos con su RVOE ideal
INNER JOIN 
    RvoeAsignado ra ON a.id = ra.Matrícula AND ra.ranking = 1
-- Unimos para obtener el nombre del Nivel (Lic, Mtr, Doc)
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.niveles n ON ra.ID_Nivel = n.clave
-- Unimos con el conteo de materias
INNER JOIN 
    ConteoMaterias cm ON a.id = cm.alumno
WHERE 
    -- REGLA 1: Solo Semestrales
    ra.tipo_semestre = 6 
    
    -- REGLA 2: Alumnos Activos (Excluyendo Bajas Definitivas/Otras)
    AND (a.grad_tit_baja NOT IN ('BD', 'BO') OR a.grad_tit_baja IS NULL)
    
    -- REGLA 3: Conteo específico por Nivel
    AND (
        (n.nivel LIKE '%LICENCIATURA%' AND cm.TotalMaterias = 35) OR
        (n.nivel LIKE '%MAESTR%A%'    AND cm.TotalMaterias = 11) OR -- El %A% cubre acento o sin acento
        (n.nivel LIKE '%DOCTORADO%'    AND cm.TotalMaterias = 9)
    )
ORDER BY 
    n.nivel, 
    a.nombre;
    
WITH RvoePosibles AS (
    -- PASO 1: Traer TODOS los RVOEs válidos por fecha (Sin Ranking)
    -- Un alumno puede aparecer varias veces aquí si tiene varios RVOEs históricos
    SELECT 
        a.id AS Matrícula,
        a.grad_tit_baja, 
        r.nivel AS ID_Nivel,
        r.tipo_semestre
    FROM 
        SISTEMAIEU.MASTERIEU.DBO.alumnos a
    INNER JOIN 
        SISTEMAIEU.MASTERIEU.DBO.rvoe r ON a.plantel = r.plantel AND a.maestria = r.maestria
    WHERE 
        r.fecha <= a.fec_ingreso
),
PoblacionObjetivo AS (
    -- PASO 2: Filtrar los candidatos (Semestrales y Activos)
    -- Usamos DISTINCT porque si Juan tiene 3 RVOEs semestrales, solo nos importa 1 vez.
    SELECT DISTINCT 
        Matrícula,
        ID_Nivel
    FROM 
        RvoePosibles
    WHERE 
        tipo_semestre = 6               
        AND (grad_tit_baja NOT IN ('BD', 'BO') OR grad_tit_baja IS NULL)
),
ConteoMaterias AS (
    -- PASO 3: Contar materias calificadas
    SELECT 
        po.Matrícula,
        po.ID_Nivel,
        COUNT(DISTINCT c.materia) AS TotalMaterias 
    FROM 
        PoblacionObjetivo po
    INNER JOIN 
        SISTEMAIEU.MASTERIEU.DBO.calificaciones c ON po.Matrícula = c.alumno
    GROUP BY 
        po.Matrícula, po.ID_Nivel
)
-- PASO 4: Reglas Finales y Conteo Único
SELECT 
    COUNT(DISTINCT Matrícula) AS Gran_Total_Alumnos
FROM 
    ConteoMaterias cm
LEFT JOIN 
    SISTEMAIEU.MASTERIEU.DBO.niveles n ON cm.ID_Nivel = n.clave
WHERE 
    (n.nivel LIKE '%LICENCIATURA%' AND cm.TotalMaterias >= 35) OR
    (n.nivel LIKE '%MAESTR%A%'    AND cm.TotalMaterias >= 11) OR
    (n.nivel LIKE '%DOCTORADO%'    AND cm.TotalMaterias >= 9);


SELECT 
    A.id, 
    A.nombre, 
    A.apellidop, 
    A.apellidom, 
    N.nivel AS NivelEducativo, 
    M.nombre AS ProgramaEducativo,
    A.grad_tit_baja AS Estatus
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos A
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.niveles N 
    ON A.nivel = N.clave
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.maestrias M 
    ON A.maestria = M.clave
WHERE (A.grad_tit_baja NOT IN ('BD', 'BO') OR A.grad_tit_baja IS NULL)
  AND N.nivel LIKE '%Licenciatura%';

SELECT A.id
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos A
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.niveles N 
    ON A.nivel = N.clave
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.maestrias M 
    ON A.maestria = M.clave
WHERE (A.grad_tit_baja NOT IN ('BD', 'BO') OR A.grad_tit_baja IS NULL)
  AND N.nivel LIKE '%Licenciatura%';


SELECT 
    A.id, 
    A.nombre, 
    A.apellidop, 
    A.apellidom, 
    N.nivel AS NivelEducativo, 
    M.nombre AS ProgramaEducativo,
    CASE R.tipo_semestre 
        WHEN 4 THEN 'Cuatrimestre'
        WHEN 6 THEN 'Semestre'
        ELSE 'Otra' 
    END AS Temporalidad,
    A.grad_tit_baja AS Estatus
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos A
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.niveles N 
    ON A.nivel = N.clave
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.maestrias M 
    ON A.maestria = M.clave
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.rvoe R
    ON A.maestria = R.maestria 
    AND A.plantel = R.plantel -- Se agrega plantel para asegurar el RVOE correcto
WHERE (A.grad_tit_baja NOT IN ('BD', 'BO') OR A.grad_tit_baja IS NULL)
  AND N.nivel LIKE '%Licenciatura%';


SELECT 
    A.id AS Matricula,
    A.nombre AS NombreAlumno,
    A.apellidop AS ApellidoPaterno,
    M.nombres AS NombreMateria,
    C.calificacion AS Calificacion,
    C.fecha AS FechaCalificacion,
    CASE R.tipo_semestre 
        WHEN 4 THEN 'Cuatrimestre'
        WHEN 6 THEN 'Semestre'
        ELSE 'Otra' 
    END AS Temporalidad
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos A
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.niveles N 
    ON A.nivel = N.clave
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.calificaciones C 
    ON A.id = C.alumno
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.materias M 
    ON C.materia = M.clave 
    AND A.maestria = M.maestria -- Corregido: Usamos la columna de la tabla alumnos
    AND A.plantel = M.plantel   -- Corregido: Usamos la columna de la tabla alumnos
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.rvoe R
    ON A.maestria = R.maestria 
    AND A.plantel = R.plantel
WHERE (A.grad_tit_baja NOT IN ('BD', 'BO') OR A.grad_tit_baja IS NULL)
  AND N.nivel LIKE '%Licenciatura%'
ORDER BY A.id, M.nombres;


WITH ConteoMaterias AS (
    -- Calculamos el total de materias por alumno (filtrando >= 30)
    SELECT 
        alumno, 
        COUNT(materia) AS TotalMaterias
    FROM SISTEMAIEU.MASTERIEU.DBO.calificaciones
    GROUP BY alumno
    HAVING COUNT(materia) >= 30
)
SELECT 
    A.id AS Matricula,
    A.nombre AS NombreAlumno,
    A.apellidop AS ApellidoPaterno,
    A.apellidom AS ApellidoMaterno,
    N.nivel AS NivelEducativo,
    M.nombre AS ProgramaEducativo,
    --'Semestre' AS Temporalidad, -- Ya sabemos que todos serán Semestrales
    CM.TotalMaterias
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos A
INNER JOIN ConteoMaterias CM 
    ON A.id = CM.alumno
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.niveles N 
    ON A.nivel = N.clave
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.maestrias M 
    ON A.maestria = M.clave
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.rvoe R
    ON A.maestria = R.maestria 
    AND A.plantel = R.plantel
WHERE (A.grad_tit_baja NOT IN ('BD', 'BO') OR A.grad_tit_baja IS NULL)
  AND N.nivel LIKE '%Licenciatura%'
  AND R.tipo_semestre = 4; -- Filtro específico para Semestral

  
  
WITH ConteoMaterias AS (
    -- Calculamos el total de materias por alumno (filtrando >= 30)
    SELECT 
        alumno, 
        COUNT(materia) AS TotalMaterias
    FROM SISTEMAIEU.MASTERIEU.DBO.calificaciones
    GROUP BY alumno
    HAVING COUNT(materia) >= 40
)
SELECT
	DISTINCT 
 	A.id AS Matricula,
    A.nombre AS NombreAlumno,
    A.apellidop AS ApellidoPaterno,
    A.apellidom AS ApellidoMaterno,
    N.nivel,
    R.tipo_semestre,
    CM.TotalMaterias
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos A
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.niveles N 
    ON A.nivel = N.clave
INNER JOIN ConteoMaterias CM 
    ON A.id = CM.alumno
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.rvoe R
    ON A.maestria = R.maestria 
    AND A.plantel = R.plantel
WHERE A.grad_tit_baja NOT IN ('BD', 'BO')
	AND N.nivel LIKE '%Licenciatura%'
	AND R.tipo_semestre IN (6, 4)
ORDER BY CM.TotalMaterias DESC
    
    
SELECT * FROM SISTEMAIEU.MASTERIEU.DBO.calificaciones WHERE alumno = 83385 ORDER BY fecha desc

SELECT DISTINCT grad_tit_baja  FROM SISTEMAIEU.MASTERIEU.DBO.alumnos


WITH ConteoMaterias AS (
    -- Calculamos el total de materias por alumno (filtrando >= 30)
    SELECT 
        alumno, 
        COUNT(materia) AS TotalMaterias
    FROM SISTEMAIEU.MASTERIEU.DBO.calificaciones
    GROUP BY alumno
    HAVING COUNT(materia) >= 42
)
SELECT DISTINCT
    COUNT(*)
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos A
INNER JOIN ConteoMaterias CM 
    ON A.id = CM.alumno
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.niveles N 
    ON A.nivel = N.clave
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.maestrias M 
    ON A.maestria = M.clave
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.rvoe R
    ON A.maestria = R.maestria 
    AND A.plantel = R.plantel
-- WHERE A.grad_tit_baja IN ('AN','BA', 'ST', 'AR', 'EN', 'ED')
WHERE A.grad_tit_baja NOT IN ('BD', 'BO')
  AND N.nivel LIKE '%Licenciatura%'
  AND R.tipo_semestre IN (4)
  AND R.vigente = 1
--ORDER BY CM.TotalMaterias DESC


WITH ConteoMaterias AS (
    SELECT 
        alumno, 
        COUNT(materia) AS TotalMaterias
    FROM SISTEMAIEU.MASTERIEU.DBO.calificaciones
    GROUP BY alumno
    HAVING COUNT(materia) >= 40
)
SELECT 
    A.id AS Matricula,
    A.nombre AS NombreAlumno,
    A.apellidop AS ApellidoPaterno,
    A.apellidom AS ApellidoMaterno,
    N.nivel AS NivelEducativo,
    M.nombre AS ProgramaEducativo,
    R.tipo_semestre,
    CM.TotalMaterias
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos A
INNER JOIN ConteoMaterias CM 
    ON A.id = CM.alumno
INNER JOIN SISTEMAIEU.MASTERIEU.DBO.niveles N 
    ON A.nivel = N.clave
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.maestrias M 
    ON A.maestria = M.clave
LEFT JOIN SISTEMAIEU.MASTERIEU.DBO.rvoe R
    ON A.maestria = R.maestria 
    AND A.plantel = R.plantel
    AND R.vigente = 1  -- <-- AGREGADO: Solo traer RVOEs activos
WHERE (A.grad_tit_baja NOT IN ('BD', 'BO') OR A.grad_tit_baja IS NULL)
  AND N.nivel LIKE '%Licenciatura%'
  AND R.tipo_semestre = 4
ORDER BY CM.TotalMaterias DESC;


SELECT DISTINCT
--c.alumno, a.nombre, c.materia, m.nombres, m.orden, c.calificacion, c.fecha, c.repetido, c.catedratico, c.tipo, c.grupo, asu.concepto
c.alumno,a.nombre,m.nombres,m.orden,c.calificacion,c.fecha,c.repetido
FROM SISTEMAIEU.MASTERIEU.DBO.calificaciones c
JOIN SISTEMAIEU.MASTERIEU.DBO.alumnos a ON a.id = c.alumno
JOIN SISTEMAIEU.MASTERIEU.DBO.materias m ON m.clave = c.materia
--JOIN asuntos asu ON asu.id = c.tipo
WHERE c.repetido = 0 AND a.id IN ('83385')
ORDER BY c.alumno,m.orden

SELECT 
    -- Campos de Alumno
    alumnos.id AS Matricula,
    alumnos.nombre AS Nombre,
    alumnos.apellidop AS ApellidoPaterno,
    alumnos.apellidom AS ApellidoMaterno,
    -- Campos de Materia
    materias.clave AS ClaveMateria,
    materias.nombres AS NombreMateria,
    materias.semestre AS Semestre,
    -- Campos de Calificación
    calificaciones.calificacion AS Calificacion,
    calificaciones.fecha AS FechaExamen,
    calificaciones.tipo AS TipoExamen
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos AS alumnos
JOIN SISTEMAIEU.MASTERIEU.DBO.materias AS materias ON 
    (alumnos.plan_master = materias.plan_master) 
    AND (alumnos.maestria = materias.maestria) 
    AND (alumnos.plantel = materias.plantel)
JOIN SISTEMAIEU.MASTERIEU.DBO.calificaciones AS calificaciones ON 
    calificaciones.alumno = alumnos.id 
    AND calificaciones.materia = materias.clave 
    AND calificaciones.repetido = 0
JOIN (
    SELECT 
        alumno, 
        materia, 
        MAX(tipo) AS tipo 
    FROM SISTEMAIEU.MASTERIEU.DBO.calificaciones 
    WHERE calificacion > 0 
    GROUP BY alumno, materia
) maxtypes ON 
    calificaciones.tipo = maxtypes.tipo 
    AND calificaciones.alumno = maxtypes.alumno 
    AND calificaciones.materia = maxtypes.materia
WHERE alumnos.id IN ('83385')
ORDER BY 
    alumnos.apellidop, 
    alumnos.apellidom, 
    alumnos.nombre, 
    materias.semestre;


SELECT DISTINCT
    a.id AS matricula,
    m.clave AS asignaturaid,
    m.nombres AS asignatura,
    m.clave_r,
    m.plantel AS plantelid,
    m.plan_master,
    p.razon_social AS plantel,
    m.maestria AS programaid,
    ma.nombre AS programa
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos AS a
JOIN SISTEMAIEU.MASTERIEU.DBO.materias AS m 
    ON a.plan_master = m.plan_master 
    AND a.maestria = m.maestria 
    AND a.plantel = m.plantel
JOIN SISTEMAIEU.MASTERIEU.DBO.maestrias AS ma 
    ON m.maestria = ma.clave
JOIN SISTEMAIEU.MASTERIEU.DBO.planteles AS p 
    ON m.plantel = p.clave
WHERE a.id IN ('190106');


SELECT TOP 1
    a.id AS Matricula,
    a.nombre AS Nombre,
    m.semestre AS SemestreActual
FROM SISTEMAIEU.MASTERIEU.DBO.alumnos AS a
JOIN SISTEMAIEU.MASTERIEU.DBO.calificaciones AS c 
    ON a.id = c.alumno
JOIN SISTEMAIEU.MASTERIEU.DBO.materias AS m 
    ON c.materia = m.clave 
    -- Aseguramos que la materia corresponda al plan del alumno
    AND a.plan_master = m.plan_master 
    AND a.maestria = m.maestria 
    AND a.plantel = m.plantel
WHERE a.id IN ('83385') -- Tu lista de matrículas
ORDER BY m.semestre DESC;



WITH ConteoMaterias AS (
    SELECT 
        ALUMNOS.id AS alumno,
        COUNT(DISTINCT MATERIAS.clave) AS materias_cursadas 
    FROM SISTEMAIEU.MASTERIEU.DBO.RVOE AS RVOE
    INNER JOIN SISTEMAIEU.MASTERIEU.DBO.PLANTELES AS PLANTELES 
        ON RVOE.PLANTEL = PLANTELES.CLAVE
    INNER JOIN SISTEMAIEU.MASTERIEU.DBO.NIVELES AS NIVELES 
        ON RVOE.NIVEL = NIVELES.CLAVE
    INNER JOIN SISTEMAIEU.MASTERIEU.DBO.MAESTRIAS AS MAESTRIAS 
        ON RVOE.MAESTRIA = MAESTRIAS.CLAVE
    INNER JOIN SISTEMAIEU.MASTERIEU.DBO.GRUPOS AS GRUPOS 
        ON RVOE.PLAN_MASTER = GRUPOS.PLAN_MASTER 
        AND RVOE.MAESTRIA = GRUPOS.MAESTRIA 
        AND RVOE.PLANTEL = GRUPOS.PLANTEL
    INNER JOIN SISTEMAIEU.MASTERIEU.DBO.ALUMNOS AS ALUMNOS 
        ON GRUPOS.GRUPO = ALUMNOS.GRUPO 
        AND GRUPOS.PLANTEL = ALUMNOS.PLANTEL
    INNER JOIN SISTEMAIEU.MASTERIEU.DBO.materias AS MATERIAS 
        ON ALUMNOS.plan_master = MATERIAS.plan_master 
        AND ALUMNOS.maestria = MATERIAS.maestria 
        AND ALUMNOS.plantel = MATERIAS.plantel 
    -- Lógica de Calificaciones (Validación de avance real)
    INNER JOIN SISTEMAIEU.MASTERIEU.DBO.calificaciones AS CALIFICACIONES 
        ON CALIFICACIONES.alumno = ALUMNOS.id 
        AND CALIFICACIONES.materia = MATERIAS.clave
        AND CALIFICACIONES.repetido = 0
    WHERE RVOE.TIPO_SEP = 'F'
        AND PLANTELES.clave IN (65, 96)
    GROUP BY ALUMNOS.id
    HAVING COUNT(DISTINCT MATERIAS.clave) > 0
)
SELECT DISTINCT
    ALUMNOS.id AS matricula,
    ALUMNOS.nombre2 AS nombre,             
    ALUMNOS.apellidop AS apellido_paterno,
    ALUMNOS.apellidom AS apellido_materno,
    -- Métricas de Avance
    RVOE.materias AS total_materias_plan,
    CM.materias_cursadas AS materias_aprobadas,
    (RVOE.materias - CM.materias_cursadas) AS materias_faltantes,
    ALUMNOS.grupo AS grupo,
    ALUMNOS.grad_tit_baja AS estatus_master,
    FORMAT(ALUMNOS.fec_ingreso, 'yyyy-MM-dd') AS fecha_ingreso_alumno,
    -- Información del Plantel
    ALUMNOS.plantel AS plantel_id,
    PLANTELES.razon_social AS plantel_nombre,
    -- Información del Nivel y Programa
    ALUMNOS.nivel AS nivel_id,
    NIVELES.nivel AS nivel_nombre,
    ALUMNOS.maestria AS programa_id,
    MAESTRIAS.nombre AS programa_nombre,
    -- Información del Grupo y Pagos
    GRUPOS.pagos AS cantidad_pagos,
    GRUPOS.grupo AS grupo_detalle,         
    FORMAT(DATEADD(MONTH, GRUPOS.pagos, GRUPOS.primer_mensualidad), 'yyyy-MM-dd') AS fecha_egreso,
    -- Información RVOE
    RVOE.tipo_sep
FROM SISTEMAIEU.MASTERIEU.dbo.RVOE RVOE
    INNER JOIN SISTEMAIEU.MASTERIEU.dbo.PLANTELES PLANTELES 
        ON RVOE.PLANTEL = PLANTELES.CLAVE
    INNER JOIN SISTEMAIEU.MASTERIEU.dbo.NIVELES NIVELES 
        ON RVOE.NIVEL = NIVELES.CLAVE
    INNER JOIN SISTEMAIEU.MASTERIEU.dbo.MAESTRIAS MAESTRIAS 
        ON RVOE.MAESTRIA = MAESTRIAS.CLAVE
    INNER JOIN SISTEMAIEU.MASTERIEU.dbo.GRUPOS GRUPOS 
        ON RVOE.PLAN_MASTER = GRUPOS.PLAN_MASTER 
        AND RVOE.MAESTRIA = GRUPOS.MAESTRIA 
        AND RVOE.PLANTEL = GRUPOS.PLANTEL
    INNER JOIN SISTEMAIEU.MASTERIEU.dbo.ALUMNOS ALUMNOS 
        ON GRUPOS.GRUPO = ALUMNOS.GRUPO 
        AND GRUPOS.PLANTEL = ALUMNOS.PLANTEL
    -- Join con CTE para obtener el conteo calculado
    INNER JOIN ConteoMaterias AS CM 
        ON ALUMNOS.id = CM.alumno
WHERE (ALUMNOS.grad_tit_baja IN ('AN','BA','ST', 'AR', 'EN', 'ED') OR ALUMNOS.grad_tit_baja IS NULL)
  AND NIVELES.clave = 4
  AND RVOE.tipo_sep = 'F'
  -- Filtro diferencial: Materias del Plan - Materias Aprobadas = 5
  AND (RVOE.materias - CM.materias_cursadas) = 5
ORDER BY ALUMNOS.apellidop, ALUMNOS.apellidom, ALUMNOS.nombre2;



