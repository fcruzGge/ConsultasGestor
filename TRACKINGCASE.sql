-- TrackingCase

CALL trackingcase.strUpdateAreasProspMaestria;

CALL trackingcase.strUpdateAreasProspLic;




SELECT CONCAT(lpm.matricula, ',') FROM trackingcase.lista_prospectos_master lpm
WHERE YEAR(lpm.fecha_carga) = 2025
AND MONTH(lpm.fecha_carga) = 5
AND lpm.carrera IS NULL
ORDER BY lpm.idlista_prospectos_maestria DESC
LIMIT 300

SELECT COUNT(*)  FROM trackingcase.lista_prospectos_master lpm
#SELECT lpm.matricula  FROM trackingcase.lista_prospectos_master lpm
WHERE YEAR(lpm.fecha_carga) = 2025
AND MONTH(lpm.fecha_carga) = 8
#AND lpm.carrera IS NULL
#ORDER BY lpm.idlista_prospectos_maestria DESC

SELECT *  FROM trackingcase.lista_prospectos_master lpm
#SELECT lpm.matricula  FROM trackingcase.lista_prospectos_master lpm
WHERE YEAR(lpm.fecha_carga) = 2025
AND MONTH(lpm.fecha_carga) = 10
#AND lpm.carrera IS NULL
#ORDER BY lpm.idlista_prospectos_maestria DESC

SELECT GROUP_CONCAT(lpm.matricula SEPARATOR ', ')
FROM trackingcase.lista_prospectos_master lpm
WHERE lpm.fecha_carga >= '2025-08-01' AND lpm.fecha_carga < '2025-09-01';

SELECT DISTINCT lpm.responsable 
FROM trackingcase.lista_prospectos_master lpm;


SELECT lpm.nivel  FROM trackingcase.lista_prospectos_master lpm 
WHERE lpm.matricula = 83822


