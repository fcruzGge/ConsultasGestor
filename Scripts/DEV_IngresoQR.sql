SELECT 
	nombre_completo as name, 
	correo as email, 
	escuela as institution, 
	campus as campus, 
	area as department, 
	id_foto as profile_picture
FROM evento_gge_2023;

UPDATE employees
SET name = UPPER(name);

ALTER TABLE employees ADD COLUMN csuite VARCHAR(100);
ALTER TABLE employees ADD COLUMN working_center VARCHAR(50);


SELECT
	e.name as Nombre, 
	e.email as Email, 
	e.ies as IES, 
	e.`position` as "DireccionGerencia", 
	e.lead_name as "Nombre de mi líder directo", 
	e.human_talent_specialist as "Especialista de Talento Humano",
	e.csuite as "CSuite",
	CASE
		WHEN ee.entry_datetime IS NULL THEN "NO"
		ELSE "SÍ"
	END AS "Asistió"
FROM employees e 
JOIN event_employees ee ON ee.employee_id = e.id 
WHERE ee.event_id = 2