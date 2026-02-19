SELECT
            alumnos.id,
            CONCAT(alumnos.nombre2, ' ', alumnos.apellidop, ' ', alumnos.apellidom),
            alumnos.plantel, 
            alumnos.grupo, 
            FORMAT (alumnos.fec_ingreso, 'yyyy-MM-dd'), 
            alumnos.telefono, 
            alumnos.tel_oficina,
            alumnos.celular,
            alumnos.mail,
            alumnos.nivel, 
            alumnos.sep, 
            alumnos.grad_tit_baja,
            grupos.pagos,
            FORMAT (grupos.primer_mensualidad, 'yyyy-MM-dd') as primer_mensualidad,
            FORMAT (grupos.fec_ini, 'yyyy-MM-dd') as fec_ini,
            FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy-MM-dd') AS FechaT,
            FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'yyyy')  as anio,
            FORMAT (DateAdd("m",[grupos].[pagos],[grupos].[primer_mensualidad]), 'MM')  as mes
        FROM alumnos INNER JOIN grupos ON (alumnos.grupo = grupos.grupo) AND (alumnos.plantel = grupos.plantel)
        WHERE alumnos.id IN (10000, 20000);

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
    AND A.id = 10000 
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

                    
                   
                   
                   
                   