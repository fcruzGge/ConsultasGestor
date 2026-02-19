SELECT
    #e.name as "Nombre del evento", 
    e2.name as Nombre, 
    e2.email as Email, 
    e2.ies as IES, 
    e2.`position` as Puesto, 
    e2.lead_name as "Nombre de mi líder directo", 
    e2.human_talent_specialist as "Especialista de Talento Humano", 
    ee.entry_datetime as "Fecha y hora de entrada",
    CASE 
        WHEN ee.entry_datetime IS NOT NULL THEN 'SÍ'
        ELSE 'NO'
    END AS "Asistió"
    -- ee.invitation_sent_on as "Fecha de envío del pase"  -- Uncomment this if needed
FROM 
    ingreso_qr.event_employees ee 
JOIN 
    ingreso_qr.events e ON ee.event_id = e.id 
JOIN 
    ingreso_qr.employees e2 ON ee.employee_id = e2.id 
ORDER BY 
    e2.name;

SELECT COUNT(*) FROM ingreso_qr.event_employees ee 
WHERE event_id = 1
	AND entry_datetime IS NOT NULL 

SELECT  
#e.name as event, 
e2.name as Nombre, 
e2.email as Email, 
e2.ies as IES, 
e2.`position` as Puesto, 
e2.lead_name as "Nombre de mi líder directo", 
e2.human_talent_specialist as "Especialista de Talento Humano", 
#ee.entry_datetime as "Fecha y hora de entrada",
ee.invitation_sent_on as "Fecha de envío del pase"
FROM ingreso_qr.event_employees ee 
JOIN ingreso_qr.events e on ee.event_id = e.id 
JOIN ingreso_qr.employees e2 on ee.employee_id = e2.id 
WHERE ee.invitation_sent_on IS NOT NULL

SELECT
		id, name
FROM
		ingreso_qr.employees e
WHERE
		name IN (
"Feldinkeiragt Rosaura Yanez Flores",
"Diana Guanumen Molina",
"Yasmin Guadalupe García",
"Alejandra Oliva Cortés Rodríguez",
"Abraham Vicente Sánchez Leyva",
"Cinthya Iliana Martínez victoria",
"Omar Hernandez Flores",
"José Ángel Santamaría Esparragoza",
"Luisana Rivera Reifetshammer",
"Ana Karen Torres Sánchez",
"Salomón Martínez Durán",
"Sandra Itzel Sanchez Ramírez",
"Yoshua Gallardo De Diego"
)

SELECT
	*
FROM
	ingreso_qr.event_employees ee
WHERE
	event_id = 1
	AND employee_id IN (
	SELECT
		id
	FROM
		ingreso_qr.employees e
	WHERE
		name IN (
"Feldinkeiragt Rosaura Yanez Flores",
"Diana Guanumen Molina",
"Yasmin Guadalupe García",
"Alejandra Oliva Cortés Rodríguez",
"Abraham Vicente Sánchez Leyva",
"Cinthya Iliana Martínez victoria",
"Omar Hernandez Flores",
"José Ángel Santamaría Esparragoza",
"Luisana Rivera Reifetshammer",
"Ana Karen Torres Sánchez",
"Salomón Martínez Durán",
"Sandra Itzel Sanchez Ramírez",
"Yoshua Gallardo De Diego"
			)
		)
		
		
ALTER TABLE ingreso_qr.employees ADD COLUMN csuite VARCHAR(100);
ALTER TABLE ingreso_qr.employees ADD COLUMN working_center VARCHAR(50);

