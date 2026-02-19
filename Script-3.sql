SELECT * 
	FROM trackingcase.lista_prospectos_master lpm 
		WHERE mes_egreso = 9 
		AND anio_egreso = 2024 
		AND estatus NOT IN ('BD', 'BO')

SELECT COUNT(*)  
	FROM trackingcase.lista_prospectos_master lpm 
		WHERE (carrera IS NULL OR carrera = '')
		AND mes_egreso = 9 
		AND anio_egreso = 2024 
		AND estatus NOT IN ('BD', 'BO')
		ORDER BY carrera DESC 

SELECT COUNT(*)  
	FROM trackingcase.lista_prospectos_master
    	WHERE matricula IS NOT NULL
        AND porcentaje IS NULL
        #AND anio_egreso = YEAR(NOW())
        AND anio_egreso = 2024
        #AND mes_egreso = LPAD(MONTH(NOW()) + 4, 2, '0')
        AND mes_egreso = 9
        AND estatus NOT IN ('BD', 'BO')
        ORDER BY matricula ASC
        LIMIT 1000;
                        
SELECT * 
	FROM trackingcase.lista_prospectos_master 
    	WHERE (carrera IS NULL OR carrera = '')
    	AND mes_egreso = LPAD(MONTH(NOW()) + 4, 2, '0')
    	#AND anio_egreso = 2024
    	AND anio_egreso = YEAR(NOW())
    	#AND estatus NOT IN ('BD', 'BO')
    	#AND mes_egreso = 9
    	LIMIT 2000;
    	
SELECT *
	FROM trackingcase.lista_prospectos_master
		WHERE (estatus != 'BD' and estatus != 'BO')
		AND asignado = 0
		AND nivel != 'Bachillerato'
		AND anio_egreso = 2025
		#AND mes_egreso = 9
		#AND nivel LIKE CONCAT('%', '', '%')
		#AND rvoe LIKE CONCAT('%', '', '%')
		#AND carrera LIKE CONCAT('%', '', '%')
		#AND area LIKE CONCAT('%', '', '%')
		#AND plantel LIKE CONCAT('%', '', '%')

CALL trackingcase.strUpdateAreasProspMaestria

CALL trackingcase.strUpdateAreasProspLic

SELECT COUNT(*) FROM trackingcase.lista_prospectos_master 
	WHERE (carrera IS NULL OR carrera = '') 
	AND mes_egreso = "01"
	AND anio_egreso = "2025"
	AND estatus NOT IN ('BD', 'BO') 
	ORDER BY CAST(matricula AS UNSIGNED) DESC LIMIT 300;

SELECT * FROM trackingcase.lista_prospectos_master
	    WHERE (estatus != 'BD' and estatus != 'BO')
		    AND nivel != 'Bachillerato'
		    AND asignado = 0
		
SELECT * FROM trackingcase.lista_prospectos_master 
	WHERE mes_egreso = "02"
	AND anio_egreso = "2025"
	AND estatus NOT IN ('BD', 'BO') 
		
		