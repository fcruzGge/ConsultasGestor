SELECT
	alumnos.id,
	alumnos.plantel,
	alumnos.grupo,
	FORMAT (alumnos.fec_ingreso, 'yyyy-MM-dd'),
    alumnos.nivel,
    alumnos.sep,
    alumnos.grad_tit_baja,
    grupos.pagos,
    FORMAT (grupos.primer_mensualidad, 'yyyy-MM-dd') as primer_mensualidad,
    FORMAT (grupos.fec_ini, 'yyyy-MM-dd') as fec_ini,
    FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy-MM-dd') AS FechaT,
    FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy')  as anio,
    FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'MM')  as mes
    FROM alumnos
    	INNER JOIN grupos
        	ON (alumnos.grupo = grupos.grupo)
        	AND (alumnos.plantel = grupos.plantel)
   WHERE alumnos.id in (
97444,
116524,
144421,
113064,
147270,
88070,
117824,
81068,
127473,
149651,
112367,
131282,
141567,
93530,
160778,
100135,
148423,
113102,
146599
   )
   
SELECT alumnos.id, CONCAT(alumnos.nombre2, ' ', alumnos.apellidop, ' ', alumnos.apellidom), 
        alumnos.plantel, alumnos.grupo, FORMAT (alumnos.fec_ingreso, 'yyyy-MM-dd'), alumnos.telefono, alumnos.tel_oficina,
        alumnos.celular, alumnos.mail, alumnos.nivel, alumnos.sep, alumnos.grad_tit_baja,
        grupos.pagos, 
        FORMAT (grupos.primer_mensualidad, 'yyyy-MM-dd') as primer_mensualidad,
        FORMAT (grupos.fec_ini, 'yyyy-MM-dd') as fec_ini,
        FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy-MM-dd') AS FechaT, 
        FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy')  as anio,
        FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'MM')  as mes
        FROM alumnos INNER JOIN grupos ON (alumnos.grupo = grupos.grupo) AND (alumnos.plantel = grupos.plantel)
        WHERE FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy') = 2024
        AND FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'MM') = 11
        AND grad_tit_baja NOT IN ('BD', 'BO');

SELECT COUNT(*) 
        FROM alumnos INNER JOIN grupos ON (alumnos.grupo = grupos.grupo) AND (alumnos.plantel = grupos.plantel)
        WHERE FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy') = 2024
        and FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'MM') = 11;

SELECT 
    alumnos.id AS matricula, 
    CONCAT(alumnos.nombre2, ' ', alumnos.apellidop, ' ', alumnos.apellidom) AS nombre, 
    alumnos.plantel, 
    alumnos.grupo, 
    FORMAT (alumnos.fec_ingreso, 'yyyy-MM-dd') AS fec_ingreso, 
    alumnos.telefono, 
    alumnos.tel_oficina,
    alumnos.celular, 
    alumnos.mail, 
    alumnos.nivel, 
    alumnos.sep, 
    alumnos.grad_tit_baja,
    grupos.pagos, 
    FORMAT (grupos.primer_mensualidad, 'yyyy-MM-dd') AS primer_mensualidad,
    FORMAT (grupos.fec_ini, 'yyyy-MM-dd') AS fec_ini,
    FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy-MM-dd') AS FechaT, 
    FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy')  AS anio,
    FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'MM')  AS mes
    FROM alumnos INNER JOIN grupos ON (alumnos.grupo = grupos.grupo) AND (alumnos.plantel = grupos.plantel)
    WHERE alumnos.id IN (
    	147233
    )
    
   
SELECT 
            A.id, 
            R.materias AS total_rvoe,         
            R.tipo_SEP, 
            M.clave, 
            M.nombres, 
            CAST(C.calificacion AS int) AS calificacion,
            M.maestria,
            C.tipo,
            A.nivel
        FROM 
            masterieu.dbo.Alumnos A     
        INNER JOIN  
            masterieu.dbo.materias M 
            ON M.plantel = A.plantel 
            AND M.plan_master = A.plan_master 
            AND M.maestria = A.maestria  
        INNER JOIN 
            masterieu.dbo.calificaciones C 
            ON M.clave = C.materia 
            AND C.alumno = A.id
        INNER JOIN  
            masterieu.dbo.rvoe R 
            ON R.plantel = A.plantel 
            AND R.maestria = A.maestria 
            AND R.plan_master = A.plan_master
        WHERE 
            C.Repetido = 0 
            AND A.id = 147233
        GROUP BY 
            A.id, 
            R.materias, 
            R.tipo_SEP, 
            M.clave, 
            M.nombres, 
            C.calificacion, 
            M.maestria, 
            C.tipo, 
            A.nivel
        ORDER BY 
            A.id;
   

SELECT 
	id AS matricula, 
	nombre, 
	grad_tit_baja AS letraEstatusAcademico, 
	s.descripcion AS DescripcionEstatusAcademico, 
	sep_ciclo, 
	CONVERT(varchar, fec_ingreso, 23) AS fec_ingreso,
	-- fec_ingreso,
	p.razon_social AS plantel 
FROM masterieu.dbo.alumnos AS a 
	INNER JOIN masterieu.dbo.status AS s ON a.grad_tit_baja = s.letra 
	INNER JOIN masterieu.dbo.planteles AS p ON a.plantel = p.clave 
WHERE id = 116371;



SELECT COUNT(*) 
FROM alumnos 
INNER JOIN grupos ON (alumnos.grupo = grupos.grupo) AND (alumnos.plantel = grupos.plantel)
WHERE grad_tit_baja NOT IN ('BD', 'BO')
	AND FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy') = 2025
	AND FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'MM') = 01;
        
       