SELECT 
	correo, 
	concat(alumno_nombre, ' ', alumno_primer_ap, ' ', alumno_segundo_ap) as nombre, xt.archivo, xt.ruta , DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") as fecha_carga, 
	alumno_curp, 
	xd.estatus 
FROM xml_detalle xd
JOIN xml_certificados xt ON xd.id_xml_file = xt.id_xml_certificados
WHERE DATE_FORMAT(xt.fecha_carga, "%Y") = '2024' 
	AND xd.estatus = 0
    #AND (xd.correo != '' OR xd.correo IS NULL)
	#AND DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") = '". $loadDate ."'
	#AND DATE_FORMAT(xt.fecha_carga, "%Y") = '2024'
    ORDER BY xt.id_xml_certificados DESC
    
SELECT 
	correo,
	xt.archivo, 
	xt.ruta , 
	DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") as fecha_carga,  
	xdt.estatus 
FROM xml_detalle_titulo xdt
JOIN xml_titulos xt ON xdt.id_xml_file = xt.id_xml_titulos 
WHERE DATE_FORMAT(xt.fecha_carga, "%Y") = '2024' 
	AND xdt.estatus = 1
    #AND (xd.correo != '' OR xd.correo IS NULL)
	#AND DATE_FORMAT(xt.fecha_carga, "%Y-%m-%d") = '". $loadDate ."'
	#AND DATE_FORMAT(xt.fecha_carga, "%Y") = '2024'
    ORDER BY xt.id_xml_titulos DESC




 SELECT
	detalle.matricula,
	detalle.correo,
	detalle.alumno_nombre as nombre,
	detalle.alumno_primer_ap as apellido_paterno,
	detalle.alumno_segundo_ap as apellido_materno,
	certificado.archivo,
	certificado.ruta,
	certificado.fecha_carga,
	detalle.alumno_curp
FROM
	xml_detalle AS detalle
JOIN xml_certificados AS certificado
	ON detalle.id_xml_file = certificado.id_xml_certificados
WHERE detalle.estatus = 0
	AND YEAR(certificado.fecha_carga) = 2025
	AND MONTH(certificado.fecha_carga) = 4
	AND DAY(certificado.fecha_carga) = 24
	
SELECT * FROM xml_detalle xd 
	
SELECT * FROM xml_detalle xd 
	WHERE matricula = '130872'
		
SELECT * FROM xml_certificados xc 
WHERE id_xml_certificados = (
	SELECT `id_xml_file` FROM xml_detalle xd 
	WHERE matricula = '130872'
)

SELECT archivo, ruta, DATE(fecha_carga) as fecha_carga
FROM xml_certificados
WHERE archivo IN (
    '106989 ALEJANDRO CESAREO DURAN RODRIGUEZ.xml',
    '112888 EDWIN JONATHAN VAZQUEZ FLORES.xml',
    '118535 MARCELINO DIAZ CRUZ.xml',
    '122577 ULICES BUSTAMANTE RIOS.xml',
    '122588 LIZBETH REYNOSO SANTOS.xml',
    '123198 ELICZAMA HERNANDEZ MENDOZA.xml',
    '124151 MARIA JOSE MONTALVO CAAMAL.xml',
    '124843 RACHMAN MARTINEZ GUERRERO.xml',
    '125553 IVAN DIAZ MORALES.xml',
    '126153 MARIA DEL CARMEN HERNANDEZ GALLARDO.xml',
    '126950 GENNY NALLELI TUN KOYOC.xml',
    '128538 PEDRO ALBERTO MARQUEZ CAMPOS.xml',
    '128539 MARIO ALBERTO PINTO LIMON.xml',
    '128540 BLANCA GUADALUPE VAZQUEZ ESPINOSA.xml',
    '130041 MARIA TERESA PINEDA ZARAZUA.xml',
    '130456 MARIA ELENA ALAMILLA GALVAN.xml',
    '130872 GABRIEL ZACAULA GONZALEZ.xml',
    '131303 VICTOR RODRIGUEZ FUENTES.xml',
    '131680 NIRANDELLI PATRICIO MAYO.xml',
    '132674 LUIS JOSE MONTIEL ALVAREZ.xml',
    '133161 SALUSTIA CABRERA CARMONA.xml',
    '133162 ELVA EDUVIGES HERNANDEZ.xml',
    '133164 CELINA LUIS OJEDA.xml',
    '133167 MARTHA ARIANNA PEREZ DELOYA.xml',
    '133170 CARINA SALGADO ALONZO.xml',
    '133256 RUBEN ALI ENRIQUEZ MARTINEZ.xml',
    '133310 ELIA RIVERA CUEVAS.xml',
    '133311 MARIA CONCEPCION VENANCIO GONZALEZ.xml',
    '133329 FIDEL GARCIA RIVERA.xml',
    '133340 OVED SANDOVAL GUEVARA.xml',
    '133354 RAUL LOPEZ HERNANDEZ.xml',
    '135242 JOSE JESUS CORDERO ECHAVARRIA.xml',
    '135243 USSIEL BENJAMIN CRUZ MEZA.xml',
    '135258 ALICIA MUÑOZ HERNANDEZ.xml',
    '136736 MA. ELENA CABRERA ARMENTA.xml',
    '137311 DULCE MARIA CRUZ LAVADORES.xml',
    '137485 RAFAEL IVAN HERNANDEZ VILLAR.xml',
    '139288 FERNANDO REYES VARELA.xml',
    '139995 YAMILET GAMBOA GALLARDO.xml',
    '140001 LUIS RAFAEL RODRIGUEZ MARTINEZ.xml',
    '142819 KARINA MEX YAM.xml',
    '143451 PATRICIA CABRERA MORALES.xml',
    '143453 DAVID CAMPOS FLORES.xml',
    '143454 ANDREA DORIA DOMINGUEZ LARIOS.xml',
    '143465 KAREN JUNUE MIGUEL RAYON.xml',
    '143478 JOAQUIN SOTO SALAMANCA.xml',
    '143563 ALBERTO LUIS AGUILAR.xml',
    '145619 MARTHA ANGELICA VAZQUEZ HERRERA.xml',
    '145963 JESUS ENRIQUE LOPEZ CALDERON.xml',
    '146505 OSCAR SANCHEZ GARCIA.xml'
)
AND DATE(fecha_carga) != '2025-11-04';


