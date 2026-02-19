-- SELECT * FROM asignaciones_seguimiento_egresados WHERE Matricula = '131402';
-- SELECT * FROM asignaciones_seguimiento_sspp WHERE Matricula = '131402';
-- SELECT * FROM prospectos_seguimiento_ss_pp WHERE Matricula = "131402";
-- SELECT * FROM lista_prospectos WHERE matricula = '131402';
-- SELECT * FROM lista_prospectos_captacion WHERE matricula = '131402';
SELECT * FROM lista_prospectos_master WHERE matricula = '124020';
-- SELECT * FROM lista_prospectos_master_ok WHERE matricula = '124020';

SELECT *
	FROM asignaciones_seguimiento_egresados
		WHERE Documentacion_Faltante = '--'
		AND Nivel = 'Maestría' 
        -- and (Documentacion_Faltante = '' or Documentacion_Faltante is null)
        -- Matricula = '178127'
        -- AND Documentacion_Faltante = '--'
        ORDER BY id_seguimiento DESC;


SELECT DISTINCT rvoe 
	FROM trackingcase.lista_prospectos_master lpm
	ORDER BY rvoe DESC 
	

SELECT *
FROM trackingcase.lista_prospectos_master lpm
WHERE estatus NOT IN ("BD", "BO")
ORDER BY fecha_carga DESC, anio_egreso DESC, mes_egreso DESC
LIMIT 50;

SELECT COUNT(*)
	FROM trackingcase.lista_prospectos_master lpm 
	WHERE estatus NOT IN ("BD", "BO", "BR")
	AND asignado = '1'
	AND matricula IN (
	102460,
)
	
SELECT Matricula, Nivel, Documentacion_Faltante 
FROM asignaciones_seguimiento_egresados
	WHERE Documentacion_Faltante != '--' 
	AND Nivel = "Licenciatura"
    AND F_Ingreso IS NOT NULL
ORDER BY id_seguimiento DESC;

SELECT Matricula, Nivel, Documentacion_Faltante 
FROM asignaciones_seguimiento_egresados
	WHERE Matricula = 178293
ORDER BY id_seguimiento DESC;

SELECT * FROM asignaciones_seguimiento_egresados
        WHERE Matricula IN ("178293")

SELECT DISTINCT tipo_usuario FROM usuarios_sistema us;

SELECT DISTINCT rvoe FROM lista_prospectos_master lpm 
	   ORDER BY rvoe ASC

SELECT 
	id_seguimiento, Matricula, Responsable, anio_egreso, mes_egreso
	FROM asignaciones_seguimiento_egresados 
	WHERE matricula != ''
	-- AND Nivel = 'Maestría'
	-- AND area_regla4 LIKE '%%'
    -- AND carrera LIKE '%%'
    -- AND Responsable LIKE '%%'
    -- AND Estatus LIKE '%%'
    -- AND Momento LIKE '%%'
    -- AND rvoe LIKE '%%'
    -- AND anio_egreso LIKE '%2024%'
    -- AND mes_egreso LIKE '%10%'
    ORDER BY id_seguimiento DESC

SELECT id_seguimiento, Matricula, area_regla4, Carrera, plantel, Nivel, Responsable, Estatus, Momento, RVOE, Documentacion_Faltante, anio_egreso, mes_egreso 
	FROM asignaciones_seguimiento_egresados 
	WHERE matricula != ''
    AND anio_egreso = '2024'
    AND mes_egreso = '10'

SELECT COUNT(*)
	FROM lista_prospectos_master lpm 
	WHERE matricula != ''
    AND anio_egreso LIKE CONCAT('%2024%')
    AND mes_egreso LIKE CONCAT('%10%')

SELECT * 
	FROM asignaciones_seguimiento_egresados
			WHERE matricula != ''
            AND area_regla4 LIKE CONCAT('%', '', '%')
            AND carrera LIKE CONCAT('%', '', '%')
            AND Responsable LIKE CONCAT('%', '', '%')
            AND Estatus LIKE CONCAT('%', '', '%')
            AND Momento LIKE CONCAT('%', '', '%')
            AND rvoe LIKE CONCAT('%', '', '%')
			AND anio_egreso LIKE CONCAT('%', '', '%')
            AND mes_egreso LIKE CONCAT('%', '', '%')
            AND Documentacion_Faltante LIKE CONCAT('', '', '%')
            ORDER BY id_seguimiento DESC
            LIMIT 1, 3000;
	
SELECT *
	FROM asignaciones_seguimiento_egresados
			WHERE matricula != ''
			-- AND area_regla4 LIKE CONCAT('%', '', '%')
            -- AND carrera LIKE CONCAT('%', '', '%')
            -- AND Responsable LIKE CONCAT('%', '', '%')
            -- AND Estatus LIKE CONCAT('%', '', '%')
            -- AND Momento LIKE CONCAT('%', '', '%')
            -- AND RVOE LIKE CONCAT('%', '', '%')
			AND anio_egreso = '2024'
            AND mes_egreso = '10'
            -- AND Documentacion_Faltante LIKE CONCAT('', '', '%')
			ORDER BY id_seguimiento DESC
            -- LIMIT 1, 3000;

CALL strUpdateAreasSegLic();

CALL strUpdateAreasSegMaestria();

SELECT *
	FROM asignaciones_seguimiento_egresados
			WHERE matricula IN (164940, 181011)
			ORDER BY id_seguimiento DESC

SELECT * 
	FROM lista_prospectos_master lpm
	WHERE matricula IN (164940, 181011)

SELECT * 
	FROM lista_prospectos_master 
	WHERE estatus NOT IN ('BD', 'BO')
	ORDER BY idlista_prospectos_maestria DESC 
			
			
			
SELECT *
	FROM asignaciones_seguimiento_egresados
			WHERE matricula != ''
			-- AND (RVOE != '' OR RVOE IS NOT NULL)
			AND RVOE != ''
			AND anio_egreso = 2024
			ORDER BY id_seguimiento DESC
	
FROM lista_prospectos_master
	WHERE (estatus != 'BD' and estatus != 'BO')
		AND nivel != 'Bachillerato'
		AND asignado = 0
        AND area LIKE CONCAT('%', _AREA, '%')
		AND carrera LIKE CONCAT('%', _PROGRAMA, '%')
    	AND plantel LIKE CONCAT('%', _PLANTEL, '%')
        AND nivel LIKE CONCAT('%', _NIVEL, '%')
		AND rvoe LIKE CONCAT('%', _RVOE, '%')
        AND anio_egreso LIKE CONCAT('%', _ANIO, '%')
        AND mes_egreso LIKE CONCAT('%', _MES, '%')
       
       
SELECT DISTINCT Estatus FROM asignaciones_seguimiento_egresados ase
	ORDER BY id_seguimiento DESC, Estatus ASC;
       
       
DESC lista_prospectos_ss_y_pp 

SELECT id_seguimiento, Matricula, Nombre_completo, FechaDocDrive, Documentacion FROM asignaciones_seguimiento_egresados ase 
WHERE Matricula = 110022

SELECT DISTINCT(tipo_usuario) FROM trackingcase.usuarios_sistema us; 
DESC trackingcase.subnotas_seguimiento;


SELECT
Documentacion,
Documentacion_Faltante,
FechaDocDrive
FROM trackingcase.asignaciones_seguimiento_egresados ORDER BY id_seguimiento DESC 




	