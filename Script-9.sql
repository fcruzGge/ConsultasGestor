select * from IEU_ENCUESTAS.PREGUNTA_RESPUESTA pr 
order by ID_PREGUNTA_RESPUESTA ASC 
LIMIT 100
CALL strGetOportunidadesTodasPrincipal(1,1)
DESC IEU_BLINDAJE.oportunidades 

SELECT * FROM IEU_BLINDAJE.oportunidades o 
WHERE o.folio = 2643708


SELECT DISTINCT programa FROM IEU_BLINDAJE.oportunidades o 
WHERE o.programa LIKE "%der%"

SELECT folio, COUNT(*) as cantidad FROM oportunidades GROUP BY folio HAVING COUNT(*) > 1 ORDER BY cantidad DESC LIMIT 20;

DELETE FROM domicilios
WHERE id_oportunidad IN (
    SELECT id_oportunidades FROM (
        SELECT o1.id_oportunidades
        FROM oportunidades o1
        INNER JOIN (
            SELECT folio, MAX(id_oportunidades) as max_id
            FROM oportunidades
            GROUP BY folio
            HAVING COUNT(*) > 1
        ) o2 ON o1.folio = o2.folio
        WHERE o1.id_oportunidades < o2.max_id
    ) as duplicados
);

DELETE FROM oportunidades
WHERE id_oportunidades IN (
    SELECT id_oportunidades FROM (
        SELECT o1.id_oportunidades
        FROM oportunidades o1
        INNER JOIN (
            SELECT folio, MAX(id_oportunidades) as max_id
            FROM oportunidades
            GROUP BY folio
            HAVING COUNT(*) > 1
        ) o2 ON o1.folio = o2.folio
        WHERE o1.id_oportunidades < o2.max_id
    ) as duplicados
);

