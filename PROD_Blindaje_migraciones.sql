-- ============================================
-- Migraciones consolidadas 03 a 09
-- Para aplicar en producción
-- Fecha: 2026-02-20
-- ============================================

-- 03: Agregar campo password_hash a usuarios_sistema
SET @col_exists = (SELECT COUNT(*) 
                   FROM information_schema.columns 
                   WHERE table_schema = DATABASE() 
                   AND table_name = 'usuarios_sistema' 
                   AND column_name = 'password_hash');

SET @has_password = (SELECT COUNT(*) 
                     FROM information_schema.columns 
                     WHERE table_schema = DATABASE() 
                     AND table_name = 'usuarios_sistema' 
                     AND column_name = 'password');

SET @sql = IF(@col_exists = 0,
    IF(@has_password > 0,
        'ALTER TABLE usuarios_sistema ADD COLUMN password_hash VARCHAR(255) NULL AFTER password',
        'ALTER TABLE usuarios_sistema ADD COLUMN password_hash VARCHAR(255) NULL AFTER usuario'),
    'SELECT "Columna password_hash ya existe" AS mensaje');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 04: Índice único en folio + timestamps en oportunidades
SET @index_exists = (SELECT COUNT(*) 
                     FROM information_schema.statistics 
                     WHERE table_schema = DATABASE() 
                     AND table_name = 'oportunidades' 
                     AND index_name = 'idx_folio_unique');

SET @sql = IF(@index_exists = 0,
    'ALTER TABLE oportunidades ADD UNIQUE INDEX idx_folio_unique (folio)',
    'SELECT "Índice idx_folio_unique ya existe" AS mensaje');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @col_creacion_exists = (SELECT COUNT(*) 
                            FROM information_schema.columns 
                            WHERE table_schema = DATABASE() 
                            AND table_name = 'oportunidades' 
                            AND column_name = 'fecha_creacion');

SET @col_actualizacion_exists = (SELECT COUNT(*) 
                                 FROM information_schema.columns 
                                 WHERE table_schema = DATABASE() 
                                 AND table_name = 'oportunidades' 
                                 AND column_name = 'fecha_actualizacion');

SET @sql = IF(@col_creacion_exists = 0 AND @col_actualizacion_exists = 0,
    'ALTER TABLE oportunidades ADD COLUMN fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP AFTER estatus, ADD COLUMN fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP AFTER fecha_creacion',
    'SELECT "Columnas de timestamp ya existen" AS mensaje');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 05: ON DELETE CASCADE en domicilios
ALTER TABLE domicilios DROP FOREIGN KEY domicilios_ibfk_4;

ALTER TABLE domicilios 
ADD CONSTRAINT domicilios_ibfk_4 
FOREIGN KEY (id_oportunidad) 
REFERENCES oportunidades(id_oportunidades) 
ON DELETE CASCADE 
ON UPDATE CASCADE;

-- 06: Tabla jobs
CREATE TABLE IF NOT EXISTS jobs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    handler VARCHAR(100) NOT NULL COMMENT 'Nombre del handler registrado en job_handlers.php',
    payload JSON NOT NULL COMMENT 'Argumentos serializados del job',
    result JSON DEFAULT NULL COMMENT 'Resultado exitoso del handler',
    error TEXT DEFAULT NULL COMMENT 'Último mensaje de error',
    status ENUM('pending', 'processing', 'completed', 'failed') DEFAULT 'pending',
    attempts TINYINT UNSIGNED DEFAULT 0 COMMENT 'Intentos realizados',
    max_attempts TINYINT UNSIGNED DEFAULT 3 COMMENT 'Máximo de reintentos',
    locked_at DATETIME DEFAULT NULL COMMENT 'Timestamp de lock para evitar doble procesamiento',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    executed_at DATETIME DEFAULT NULL COMMENT 'Timestamp de finalización',
    INDEX idx_pending (status, locked_at),
    INDEX idx_cleanup (status, executed_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Cola de trabajos para procesamiento en background';

-- 07: Stacktrace en jobs
SET @column_exists = (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'jobs' AND COLUMN_NAME = 'stacktrace'
);

SET @sql = IF(@column_exists = 0,
    'ALTER TABLE jobs ADD COLUMN stacktrace TEXT DEFAULT NULL COMMENT ''Stack trace del último error'' AFTER error',
    'SELECT ''Columna stacktrace ya existe'' as mensaje'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 08: Tabla agente_contacto
CREATE TABLE IF NOT EXISTS `agente_contacto` (
    `id_agente_contacto` INT NOT NULL AUTO_INCREMENT,
    `id_agente` INT NOT NULL,
    `smtp_email` VARCHAR(200) NOT NULL,
    `smtp_password` VARBINARY(512) NOT NULL,
    `whatsapp` VARCHAR(255) DEFAULT NULL,
    `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_agente_contacto`),
    UNIQUE KEY `uk_agente` (`id_agente`),
    CONSTRAINT `fk_agente_contacto_agente` FOREIGN KEY (`id_agente`) REFERENCES `cat_agentes` (`id_agente`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 09: firma_path en agente_contacto
SET @col_exists = (SELECT COUNT(*)
                   FROM information_schema.columns
                   WHERE table_schema = DATABASE()
                   AND table_name = 'agente_contacto'
                   AND column_name = 'firma_path');

SET @sql = IF(@col_exists = 0,
    'ALTER TABLE agente_contacto ADD COLUMN firma_path VARCHAR(255) DEFAULT NULL AFTER whatsapp',
    'SELECT "Columna firma_path ya existe" AS mensaje');

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
