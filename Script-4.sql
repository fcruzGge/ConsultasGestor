SELECT * FROM cat_agentes

SELECT folio, COUNT(*) as cantidad FROM oportunidades GROUP BY folio HAVING COUNT(*) > 1 ORDER BY cantidad DESC LIMIT 20;

SELECT o.id_oportunidades, o.fecha_descarga, o.correo_electronico  FROM oportunidades o WHERE o.folio = 2126451

SELECT * FROM domicilios d WHERE d.id_oportunidad = (SELECT o.id_oportunidades FROM oportunidades o WHERE o.folio = 2126451)

UPDATE oportunidades
SET correo_electronico = 'fernando.carrillo@ieu.edu.mx'
WHERE YEAR(fecha_descarga) = 2026

SELECT * FROM cat_agentes ca 

DESC oportunidades

SELECT * FROM oportunidades WHERE YEAR(fecha_descarga) = 2026

SELECT DISTINCT plantel FROM oportunidades

SELECT * FROM banners_links

SELECT * FROM cat_tipo_usuario;

DESCRIBE cat_tipo_usuario;
DESCRIBE usuarios_sistema;