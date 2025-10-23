-- Datos iniciales para pruebas
-- Este script se ejecutará manualmente después

-- Insertar categorías de transacciones básicas
INSERT INTO transaction_categories (name, type, color) VALUES 
('Salario', 'income', '#22c55e'),
('Comida', 'expense', '#ef4444'),
('Transporte', 'expense', '#f59e0b'),
('Entretenimiento', 'expense', '#8b5cf6'),
('Servicios', 'expense', '#06b6d4')
ON CONFLICT DO NOTHING;

-- Insertar tipos de rachas
INSERT INTO streak_types (name, description, required_count) VALUES 
('daily_login', 'Login diario consecutivo', 1),
('lesson_completion', 'Lecciones completadas consecutivas', 1),
('financial_tracking', 'Días consecutivos registrando transacciones', 1)
ON CONFLICT DO NOTHING;

-- Mensaje de confirmación
DO $$ 
BEGIN
    RAISE NOTICE '✅ Datos de prueba insertados correctamente';
END $$;
