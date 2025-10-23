-- Script de inicialización de la base de datos Cash Capital
-- Se ejecuta automáticamente cuando PostgreSQL inicia

-- Crear extensiones útiles
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Crear la base de datos si no existe (esto es redundante pero seguro)
SELECT 'CREATE DATABASE cashcapital'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'cashcapital')\gexec

-- Conectar a la base de datos cashcapital
\c cashcapital;

-- Mensaje de confirmación
DO $$ 
BEGIN
    RAISE NOTICE '✅ Base de datos Cash Capital inicializada correctamente en %', current_timestamp;
END $$;