SELECT * 
	FROM IEU_BLINDAJE.usuarios_sistema us 
	INNER JOIN IEU_BLINDAJE.cat_tipo_usuario ctu ON us.id_cat_tipo_usuario = ctu.id_cat_tipo_usuario 
	INNER JOIN IEU_BLINDAJE.cat_plantel cp ON us.id_cat_plantel = cp.id_cat_plantel 
	

SELECT o.id_oportunidades, o.folio, o.correo_electronico, ca.nombre, ca.correo
	FROM oportunidades o, cat_agentes ca
    	WHERE o.correo_enero = 'no enviado'
		AND o.agente = ca.id_agente AND o.agente = 7
		AND (fecha_inicio_clases LIKE '%Agosto%' OR fecha_inicio_clases LIKE '%Septiembre%')
		#AND o.plantel = 'PUEBLA'
		AND o.periodo LIKE '%24';
		
SELECT COUNT(*) 
	FROM oportunidades o, cat_agentes ca
    	WHERE o.correo_enero = 'no enviado'
		AND o.agente = ca.id_agente AND o.agente = 1
		AND (fecha_inicio_clases LIKE '%Agosto%' OR fecha_inicio_clases LIKE '%Septiembre%')
		AND o.plantel = 'VERACRUZ'
		AND o.periodo LIKE '%24';
		
SELECT o.id_oportunidades, o.folio, o.correo_electronico, ca.nombre, ca.correo
	FROM oportunidades o
	INNER JOIN cat_agentes ca ON o.agente = ca.id_agente
	WHERE o.correo_enero = 'no enviado'
	AND (fecha_inicio_clases LIKE '%Agosto%' OR fecha_inicio_clases LIKE '%Septiembre%')
	AND o.periodo LIKE '%24'
	ORDER BY o.agente;
	
SELECT ca.id_agente, ca.nombre, COUNT(*) AS total_correos_a_enviar
	FROM oportunidades o
	INNER JOIN cat_agentes ca ON o.agente = ca.id_agente
	WHERE (
		o.correo_enero = 'no enviado'
		OR o.correo_febrero = 'no enviado'
		OR o.correo_marzo  = 'no enviado'
		OR o.correo_abril = 'no enviado'
		OR o.correo_mayo = 'no enviado'
	)
		AND (fecha_inicio_clases LIKE '%Agosto%' OR fecha_inicio_clases LIKE '%Septiembre%')
		AND o.periodo LIKE '%24'
	GROUP BY ca.id_agente, ca.nombre
	ORDER BY ca.id_agente;


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
#    o.correo_febrero = 'no enviado'
#    o.correo_marzo  = 'no enviado'
#    o.correo_abril = 'no enviado'
#    o.correo_mayo = 'no enviado'
#    o.correo_junio = 'no enviado'
#    o.correo_julio = 'no enviado'
#    o.correo_agosto = 'no enviado'
)
AND (fecha_inicio_clases LIKE '%Agosto%' OR fecha_inicio_clases LIKE '%Septiembre%')
AND o.periodo LIKE '%26'
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


SELECT *
	FROM oportunidades o
	WHERE o.correo_enero = 'enviado'
	AND o.agente = 3
	AND (o.fecha_inicio_clases LIKE '%Agosto%' OR o.fecha_inicio_clases LIKE '%Septiembre%')
	AND o.periodo LIKE '%24';


SELECT ca.id_agente, ca.nombre, o.plantel, COUNT(*) AS total_correos_a_enviar
	FROM oportunidades o
	INNER JOIN cat_agentes ca ON o.agente = ca.id_agente
	WHERE (
		o.correo_enero = 'no enviado'
		OR o.correo_febrero = 'no enviado'
		OR o.correo_marzo  = 'no enviado'
		OR o.correo_abril = 'no enviado'
		OR o.correo_mayo = 'no enviado'
	)
		AND (fecha_inicio_clases LIKE '%Agosto%' OR fecha_inicio_clases LIKE '%Septiembre%')
		AND o.periodo LIKE '%24'
	GROUP BY 
        ca.id_agente, 
        ca.nombre,
        o.plantel,
        o.correo_enero,
        o.correo_febrero,
        o.correo_marzo,
        o.correo_abril,
        o.correo_mayo,
        o.correo_junio,
        o.correo_julio,
        o.correo_agosto,
        o.correo_septiembre
	ORDER BY ca.id_agente

SELECT us.id_usuarios_sistema, us.id_cat_tipo_usuario, us.nombre_completo,
                ctu.tipo_usuario, ca.id_agente
                FROM usuarios_sistema us, cat_tipo_usuario ctu, cat_agentes ca
                WHERE usuario = '".$userName."'
                AND us.id_cat_tipo_usuario = ctu.id_cat_tipo_usuario
                AND us.correo_electronico = ca.correo;


SELECT 
	us.id_usuarios_sistema, 
	us.id_cat_tipo_usuario, 
	us.nombre_completo, 
	ctu.tipo_usuario, 
	ca.id_agente
	FROM 
		usuarios_sistema us, 
		cat_tipo_usuario ctu, 
		cat_agentes ca
	WHERE usuario = 'carlos.rosas'
		AND us.id_cat_tipo_usuario = ctu.id_cat_tipo_usuario
		AND us.correo_electronico = ca.correo;            

	
	
CALL strGetOportunidadesTodasPrincipal(2, 1) 

SELECT 
	o.*, 
    ceo.estatus_oportunidades, 
    ca.nombre as agente_nombre, 
    cr.riesgo, 
    cr.tipo_riesgo
FROM oportunidades o
	JOIN cat_estatus_oportunidades ceo ON o.estatus = ceo.id_cat_estatus_oportunidades
	JOIN cat_agentes ca ON o.agente = ca.id_agente
	JOIN cat_riesgos cr ON IF(o.riesgo_junio IS NULL OR o.riesgo_junio = "", 10000, o.riesgo_junio) = cr.id_cat_riesgos
WHERE o.agente = 4
	AND o.folio = 2339441
	AND o.periodo LIKE "%24%"
    AND (o.fecha_inicio_clases LIKE "%Agosto%" OR o.fecha_inicio_clases LIKE "%Septiembre%");


   SELECT o.id_oportunidades, folio, nombre, ap_paterno, ap_materno, etapa, fecha_descarga, agente FROM IEU_BLINDAJE.oportunidades o
   WHERE o.agente = 3 AND YEAR(o.fecha_descarga) = 2026; 
   

SELECT DISTINCT o.programa FROM oportunidades o WHERE o.programa LIKE '%estra%'


DESC oportunidades o 



