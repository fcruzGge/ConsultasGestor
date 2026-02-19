SELECT 
	ca.id_agente, 
	ca.nombre, 
	o.plantel,
	#o.correo_enero,
	#o.correo_febrero,
	#o.correo_marzo,
	#o.correo_abril,
	#o.correo_mayo,
	#o.correo_junio
	COUNT(*) AS total_correos_a_enviar
FROM oportunidades o
INNER JOIN cat_agentes ca ON o.agente = ca.id_agente
WHERE (
    o.correo_enero = 'no enviado'
    #o.correo_febrero = 'no enviado'
    #o.correo_marzo  = 'no enviado' 
    #o.correo_abril = 'no enviado'
    #o.correo_mayo = 'no enviado' 
    #o.correo_junio = 'no enviado'
    #o.correo_julio = 'no enviado'
    #o.correo_agosto = 'no enviado'
)
AND (fecha_inicio_clases LIKE '%Agosto%' OR fecha_inicio_clases LIKE '%Septiembre%')
AND o.periodo LIKE '%25'
GROUP BY ca.id_agente, 
		ca.nombre, 
		o.plantel
		#o.correo_enero
		#o.correo_febrero
		#o.correo_marzo
		#o.correo_abril
		#o.correo_mayo
		#o.correo_junio
ORDER BY ca.id_agente;

SELECT o.id_oportunidades, o.folio, o.correo_electronico, ca.nombre, ca.correo
                from oportunidades o, cat_agentes ca
                #WHERE o.correo_enero = 'no enviado'
                WHERE o.correo_febrero = 'no enviado'
                #AND o.agente = ca.id_agente AND o.agente = 1
                AND (fecha_inicio_clases LIKE '%Agosto%' OR fecha_inicio_clases LIKE '%Septiembre%')
                AND o.plantel = 'PUEBLA'
                AND o.periodo LIKE '%25'
                LIMIT 30;

SELECT id_oportunidades  FROM oportunidades o
ORDER BY id_oportunidades DESC 
LIMIT 10

               

SELECT * FROM oportunidades o 
ORDER BY id_oportunidades DESC
LIMIT 100

SELECT DISTINCT o.programa  FROM oportunidades o 


SELECT * FROM cat_agentes ca 


SELECT
	o.id_oportunidades,
	o.folio,
	o.agente
FROM oportunidades o 
WHERE DATE(fecha_descarga) = "2025-08-08"
AND o.agente = 1


SELECT 
    ca.nombre AS agente,
    COUNT(*) AS total_oportunidades
FROM oportunidades o
JOIN cat_agentes ca 
    ON o.agente = ca.id_agente
WHERE DATE(o.fecha_descarga) = '2025-08-08'
GROUP BY ca.nombre
ORDER BY total_oportunidades DESC;

SELECT o.id_oportunidades, o.folio, o.correo_electronico, 
	correo_enero, correo_febrero, correo_marzo, correo_abril, correo_mayo, correo_junio, correo_julio, correo_agosto
FROM oportunidades o
WHERE (fecha_inicio_clases LIKE '%Agosto%' OR fecha_inicio_clases LIKE '%Septiembre%')
AND o.periodo LIKE '%25'

SELECT 
    o.id_oportunidades, 
    o.folio,
    o.nombre,
    o.ap_paterno,
    o.ap_materno,
    o.correo_electronico, 
    o.programa,
    o.nivel,
    o.agente, 
    d.ciudad
FROM oportunidades o
LEFT JOIN domicilios d on d.id_oportunidad = o.id_oportunidades
WHERE o.folio  = 2648926

SELECT o.id_oportunidades, o.agente, ca.nombre  FROM oportunidades o
JOIN cat_agentes ca ON o.agente = ca.id_agente 
WHERE o.folio = 2643708

SELECT DISTINCT o.plantel FROM oportunidades o
WHERE o.plantel LIKE '%pue%'

SELECT DISTINCT o.programa FROM oportunidades o
WHERE o.programa LIKE '%arqu%'

SELECT * FROM oportunidades o 
WHERE o.id_oportunidades = 7386

SELECT * FROM domicilios d 
WHERE d.id_oportunidad = 7386

UPDATE oportunidades o 
SET o.programa = 'Arquitectura de Interiores'
WHERE o.folio = 2543668

UPDATE oportunidades o 
SET o.plantel = 'PUEBLA'
WHERE o.folio = 2638117


