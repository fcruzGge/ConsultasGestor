-- Certificado
SELECT * FROM IEU_CERT_DIG.xml_detalle xd 
	WHERE matricula = '153172'
		
SELECT * FROM IEU_CERT_DIG.xml_certificados xc 
WHERE id_xml_certificados = (
	SELECT `id_xml_file` FROM IEU_CERT_DIG.xml_detalle xd 
	WHERE matricula = '153172'
)

SELECT * FROM IEU_CERT_DIG.xml_certificados xc WHERE xc.id_xml_certificados = 23612

SELECT * FROM IEU_CERT_DIG.xml_detalle xd WHERE xd.id_xml_detalle = 22545

-- Titulo
SELECT  * FROM IEU_CERT_DIG.xml_detalle_titulo xdt 
WHERE matricula = '119312';

SELECT * FROM IEU_CERT_DIG.xml_titulos xt 
WHERE id_xml_titulos = (
	SELECT id_xml_file_titulo FROM xml_detalle_titulo xdt
	WHERE matricula = '119312'
);

-- Certificados
SELECT
	xd.id_xml_detalle,
	xt.id_xml_certificados,
	xd.matricula,
	concat(alumno_nombre, ' ', alumno_primer_ap, ' ', alumno_segundo_ap) as nombre,
	correo, 
	xt.archivo, xt.ruta , DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") as fecha_carga, 
	alumno_curp, 
	xd.estatus 
FROM IEU_CERT_DIG.xml_detalle xd
JOIN IEU_CERT_DIG.xml_certificados xt ON xd.id_xml_file = xt.id_xml_certificados
WHERE xd.estatus = 0
	#AND DATE_FORMAT(xt.fecha_carga, "%Y") = '2024'  
    #AND (xd.correo = '' OR xd.correo IS NULL
	#AND DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") = '". $loadDate ."'
	AND DATE_FORMAT(xt.fecha_carga, "%Y") = '2026'
	#AND DATE_FORMAT(xt.fecha_carga, "%m") = '01'
	#AND DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") = '2026-01-27'
    ORDER BY xt.id_xml_certificados DESC

-- Títulos 
SELECT
	xd.matricula,
	concat(profesionista_nombre, "", profesionista_primer_ap, "", profesionista_segundo_ap) as nombre,
	xd.correo, 
    xt.archivo, 
    xt.ruta, 
    DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") as fecha_carga, 
	xd.profesionista_curp,
	xt.estatus
FROM xml_detalle_titulo AS xd
	INNER JOIN xml_titulos AS xt ON xd.id_xml_file_titulo = xt.id_xml_titulos 
WHERE 
	xd.estatus = 0
	#AND xd.correo != ''
	#AND xd.correo IS NOT NULL
	AND DATE_FORMAT(xt.fecha_carga, "%Y") = '2026'
	#AND xd.profesionista_nombre LIKE '%SALOMON%' 
	#xd.matricula = 124678
	#AND DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") = '2025-01-15'

SELECT
	xd.matricula, 
    concat(profesionista_nombre, "", profesionista_primer_ap, "", profesionista_segundo_ap) as nombre,
    xd.correo,
    xt.archivo, 
    xt.ruta, 
    DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") as fecha_carga, 
	xd.profesionista_curp
FROM xml_detalle_titulo AS xd
	INNER JOIN xml_titulos AS xt ON xd.id_xml_file_titulo = xt.id_xml_titulos 
WHERE xd.estatus = 0
	#AND (xd.correo = '' OR xd.correo IS NULL)
	#AND xd.correo IS NOT NULL
	AND DATE_FORMAT(xt.fecha_carga, "%m") = '25'
	AND DATE_FORMAT(xt.fecha_carga, "%Y") = '2024'
	
	
SELECT
	xd.id_xml_detalle_titulo,
	xd.matricula, 
    concat(profesionista_nombre, "", profesionista_primer_ap, "", profesionista_segundo_ap) as nombre,
    xd.correo,
    DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") as fecha_carga,
    DATE(FROM_UNIXTIME(CAST(xd.fecha_envio_correo AS UNSIGNED))) AS formatted_date,
    xd.estatus,
    xt.ruta 
FROM xml_detalle_titulo AS xd
	INNER JOIN xml_titulos AS xt ON xt.id_xml_titulos = xd.id_xml_file_titulo
WHERE xd.estatus = 0
	#AND (xd.correo = '' OR xd.correo IS NULL)
	#AND xd.correo IS NOT NULL
	AND DATE_FORMAT(xt.fecha_carga, "%Y") IN ('2024')
	ORDER BY xd.id_xml_detalle_titulo DESC

SELECT
	xd.id_xml_detalle_titulo,
	xd.matricula, 
    concat(profesionista_nombre, "", profesionista_primer_ap, "", profesionista_segundo_ap) as nombre,
    xd.correo,
    DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") as fecha_carga,
    DATE(FROM_UNIXTIME(CAST(xd.fecha_envio_correo AS UNSIGNED))) AS formatted_date,
    xd.estatus,
    xt.ruta 
FROM xml_detalle_titulo AS xd
	INNER JOIN xml_titulos AS xt ON xt.id_xml_titulos = xd.id_xml_file_titulo
WHERE xd.estatus = 0
	#AND (xd.correo = '' OR xd.correo IS NULL)
	#AND xd.correo IS NOT NULL
	AND DATE_FORMAT(xt.fecha_carga, "%Y") IN ('2024')
	ORDER BY xd.id_xml_detalle_titulo DESC
	
	
SELECT
	xd.id_xml_detalle,
	xd.matricula, 
    concat(alumno_nombre, "", alumno_primer_ap, "", alumno_segundo_ap) as nombre,
    xd.correo,
    DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") as fecha_carga,
    DATE(FROM_UNIXTIME(CAST(xd.fecha_envio_correo AS UNSIGNED))) AS formatted_date,
    xd.estatus,
    xt.ruta 
FROM xml_detalle AS xd
	INNER JOIN xml_certificados AS xt ON xt.id_xml_certificados = xd.id_xml_file 
WHERE xd.estatus = 0
	#AND (xd.correo = '' OR xd.correo IS NULL)
	#AND xd.correo IS NOT NULL
	AND DATE_FORMAT(xt.fecha_carga, "%Y") IN ('2024')
	ORDER BY xd.id_xml_detalle DESC

SELECT
	xd.id_xml_detalle,
	xd.matricula, 
    concat(alumno_nombre, "", alumno_primer_ap, "", alumno_segundo_ap) as nombre,
    xd.correo,
    DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") as fecha_carga,
    DATE(FROM_UNIXTIME(CAST(xd.fecha_envio_correo AS UNSIGNED))) AS "fecha_de_envio",
    xd.estatus,
    xt.ruta 
FROM xml_detalle AS xd
	INNER JOIN xml_certificados AS xt ON xt.id_xml_certificados = xd.id_xml_file 
WHERE xd.matricula = 157785


SELECT xd.matricula , xd.alumno_nombre, xd.alumno_primer_ap, xd.alumno_segundo_ap  FROM IEU_CERT_DIG.xml_detalle xd
WHERE 
	xd.alumno_nombre LIKE '%Alberto%' 


SELECT * FROM xml_certificados 
WHERE ruta = 'Paq. 63' 
AND DATE(fecha_carga) = '2022-12-20';


SHOW CREATE TABLE IEU_CERT_DIG.xml_certificados;
SHOW CREATE TABLE IEU_CERT_DIG.xml_detalle;

-- Certificados
SELECT
	xd.id_xml_detalle,
	xt.id_xml_certificados,
	xd.matricula,
	concat(alumno_nombre, ' ', alumno_primer_ap, ' ', alumno_segundo_ap) as nombre,
	correo, 
	xt.archivo, xt.ruta , DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") as fecha_carga, 
	alumno_curp, 
	xd.estatus 
FROM IEU_CERT_DIG.xml_detalle xd
JOIN IEU_CERT_DIG.xml_certificados xt ON xd.id_xml_file = xt.id_xml_certificados
WHERE xd.estatus = 0
	AND ruta IN ('Paquete 2', 'Paquete 2.1')
	AND DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") = '2026-01-27'
    ORDER BY xt.id_xml_certificados DESC
    
UPDATE IEU_CERT_DIG.xml_detalle xd
JOIN IEU_CERT_DIG.xml_certificados xt ON xd.id_xml_file = xt.id_xml_certificados
SET xd.estatus = 0
WHERE xd.estatus = 1
	AND xt.ruta IN ('Paquete 2', 'Paquete 2.1')
	AND DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") = '2026-01-27';
