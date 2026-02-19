select * from planteles order by id


CREATE TABLE IF NOT EXISTS "levels" (
	"id" SERIAL PRIMARY KEY,
   	"id_master" INT UNIQUE,
    "name" VARCHAR(50) UNIQUE,
    "order" INT NULL DEFAULT NULL,
    "is_active" BOOLEAN DEFAULT true,
    "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    "deleted_at" TIMESTAMP NULL DEFAULT NULL
);
