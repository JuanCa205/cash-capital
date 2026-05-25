-- ============================================================
-- Cash Capital — Seed Data
-- Generado: 2026-05-25
-- Datos semilla para: challenges, lessons, achievements,
--                      streaks, quizzes, quiz_questions, quiz_answers
-- ============================================================
-- NOTA: Los UUIDs son determinísticos (no gen_random_uuid())
-- para garantizar consistencia entre entornos.
-- ============================================================

-- ============================================================
-- 1. CHALLENGES (12 retos)
-- ============================================================
-- Badge references:
--   Ahorrador: 0448e72a-d8c1-4597-b251-389176785683
--   Presupuestador: c75981e0-3760-4c19-bf5b-32e426818cf8
--   Meta de Ahorro: dd54a7c1-103e-4af7-846c-9c83f601cbb0
--   Sabio: 0b0d7e45-dead-407f-bab2-1e2ee4a4374e
--   Sin Deudas: 12960eef-232e-4ba6-9d1a-8564e6c5966c
-- ============================================================

INSERT INTO public.challenges (id, title, description, challenge_type, objective_type, target_value, points_reward, badge_reward_id, start_date, end_date, is_active)
VALUES
  ('a0000001-0000-0000-0000-000000000001',
   'Ahorrador novato',
   'Ahorra $50.000 durante esta semana. Cada peso cuenta para construir tu futuro financiero.',
   'weekly', 'save_money', 50000, 100,
   '0448e72a-d8c1-4597-b251-389176785683',
   NOW(), NOW() + INTERVAL '7 days', true),

  ('a0000002-0000-0000-0000-000000000002',
   'Presupuestador inicial',
   'Crea tu primer presupuesto mensual. Organiza tus ingresos y gastos para tomar control de tus finanzas.',
   'weekly', 'create_budget', 1, 75,
   'c75981e0-3760-4c19-bf5b-32e426818cf8',
   NOW(), NOW() + INTERVAL '7 days', true),

  ('a0000003-0000-0000-0000-000000000003',
   'Racha de aprendizaje',
   'Completa 3 lecciones hoy. El conocimiento financiero es la mejor inversión.',
   'daily', 'complete_lesson', 3, 50,
   NULL,
   NOW(), NOW() + INTERVAL '1 day', true),

  ('a0000004-0000-0000-0000-000000000004',
   'Control de gastos',
   'Registra al menos 10 gastos esta semana. Llevar un registro es el primer paso para ahorrar.',
   'weekly', 'register_expense', 10, 150,
   NULL,
   NOW(), NOW() + INTERVAL '7 days', true),

  ('a0000005-0000-0000-0000-000000000005',
   'Meta cumplida',
   'Alcanza una meta de ahorro de $200.000. Las metas grandes se logran con pequeños pasos.',
   'special', 'save_money', 200000, 200,
   'dd54a7c1-103e-4af7-846c-9c83f601cbb0',
   NOW(), NOW() + INTERVAL '30 days', true),

  ('a0000006-0000-0000-0000-000000000006',
   'Pagador de deudas',
   'Realiza al menos 1 pago a una deuda esta semana. Reduce tus deudas y aumenta tu libertad financiera.',
   'weekly', 'pay_debt', 1, 125,
   NULL,
   NOW(), NOW() + INTERVAL '7 days', true),

  ('a0000007-0000-0000-0000-000000000007',
   'Quiz master',
   'Completa 2 quizzes hoy. Demuestra lo que has aprendido sobre finanzas personales.',
   'daily', 'complete_quiz', 2, 60,
   NULL,
   NOW(), NOW() + INTERVAL '1 day', true),

  ('a0000008-0000-0000-0000-000000000008',
   'Ahorro semanal fuerte',
   'Ahorra $100.000 esta semana. Un esfuerzo mayor trae recompensas mayores.',
   'weekly', 'save_money', 100000, 175,
   NULL,
   NOW(), NOW() + INTERVAL '7 days', true),

  ('a0000009-0000-0000-0000-000000000009',
   'Inicio de sesión constante',
   'Inicia sesión 5 días consecutivos. La consistencia es la clave del éxito financiero.',
   'daily', 'login_streak', 5, 30,
   NULL,
   NOW(), NOW() + INTERVAL '5 days', true),

  ('a0000010-0000-0000-0000-000000000010',
   'Estudiante constante',
   'Completa 10 lecciones en total. El conocimiento financiero se acumula como el interés compuesto.',
   'special', 'complete_lesson', 10, 250,
   '0b0d7e45-dead-407f-bab2-1e2ee4a4374e',
   NOW(), NOW() + INTERVAL '30 days', true),

  ('a0000011-0000-0000-0000-000000000011',
   'Presupuesto semanal',
   'Crea y mantén un presupuesto durante una semana. El control financiero es poder.',
   'weekly', 'create_budget', 1, 80,
   NULL,
   NOW(), NOW() + INTERVAL '7 days', true),

  ('a0000012-0000-0000-0000-000000000012',
   'Desafío de deudas',
   'Paga 3 deudas diferentes. Libérate de las deudas y construye tu patrimonio.',
   'special', 'pay_debt', 3, 300,
   '12960eef-232e-4ba6-9d1a-8564e6c5966c',
   NOW(), NOW() + INTERVAL '30 days', true);

-- ============================================================
-- 2. LESSONS (24 lecciones educativas)
-- ============================================================
-- Module IDs:
--   Ahorro:    c4cde30f-5c9c-4727-8293-fd8f51dd1549
--   Presupuesto: 2037342b-9875-40ce-b525-72e4bd37a748
--   Deuda:     fdcc27f6-130e-4291-930a-9fdc0cd3a96b
--   Inversión: 8f4d378a-9830-46c3-83ad-def7a3e0ac29
--   Crédito:   d4655d09-abb1-41de-b04a-2673662b29fd
-- ============================================================

-- Módulo: Ahorro (6 lecciones)
INSERT INTO public.lessons (id, module_id, title, summary, content, estimated_minutes, order_index, points_reward, is_active)
VALUES

('b1000001-0000-0000-0000-000000000001',
 'c4cde30f-5c9c-4727-8293-fd8f51dd1549',
 '¿Qué es el ahorro y por qué es importante?',
 'Descubre el concepto de ahorro y por qué es la base de la salud financiera.',
 'El ahorro es la parte de tus ingresos que decides no gastar hoy para utilizarla en el futuro. Es el pilar fundamental de cualquier plan financiero saludable. Ahorrar no significa privarse de todo, sino tomar decisiones inteligentes sobre cómo y cuándo gastar tu dinero.

La importancia del ahorro radica en varios factores clave. Primero, te permite crear un fondo de emergencia para imprevistos como una reparación del coche, un problema de salud o la pérdida del empleo. Los expertos recomiendan tener entre 3 y 6 meses de gastos básicos ahorrados.

Segundo, el ahorro te ayuda a alcanzar metas a corto, mediano y largo plazo: desde unas vacaciones hasta la compra de una vivienda o la jubilación. Sin ahorro, estas metas dependen completamente de préstamos y créditos que generan intereses.

Tercero, ahorrar te da tranquilidad y libertad financiera. Saber que tienes un colchón financiero reduce el estrés y te permite tomar mejores decisiones sin la presión de la urgencia económica.

Para empezar a ahorrar, aplica la regla del 50/30/20: destina el 50% de tus ingresos a necesidades básicas, el 30% a deseos y el 20% al ahorro e inversión. Ajusta estos porcentajes según tu realidad, pero el hábito de ahorrar debe ser constante.',
 8, 1, 15, true),

('b1000002-0000-0000-0000-000000000002',
 'c4cde30f-5c9c-4727-8293-fd8f51dd1549',
 'Métodos de ahorro: 50/30/20, Kakebo y más',
 'Conoce diferentes métodos de ahorro y elige el que mejor se adapte a tu estilo de vida.',
 'Existen múltiples métodos de ahorro, cada uno con sus ventajas según tu personalidad y objetivos financieros. El método 50/30/20, popularizado por la senadora Elizabeth Warren, es uno de los más conocidos: divide tus ingresos en necesidades (50%), deseos (30%) y ahorro (20%). Es simple, flexible y fácil de implementar.

El método Kakebo viene de Japón y se basa en llevar un diario de gastos. Fue creado en 1904 por Hani Motoko, la primera mujer periodista de Japón. Consiste en registrar cada gasto diario y clasificarlo en cuatro categorías: supervivencia (necesidades básicas), ocio, cultura y extras. Al final del mes, analizas tus patrones de gasto.

El método de los sobres es ideal para quienes prefieren lo tangible. Retira tu presupuesto en efectivo y distribúyelo en sobres etiquetados (alimentación, transporte, ocio, etc.). Cuando un sobre se vacía, dejas de gastar en esa categoría. Es muy efectivo para controlar gastos variables.

El método de pagarse a uno mismo primero consiste en automatizar tu ahorro: en cuanto recibes tu ingreso, transfieres automáticamente un porcentaje a tu cuenta de ahorros. Lo que no ves, no lo gastas. Esta técnica aprovecha la psicología humana y elimina la tentación de gastar primero y ahorrar lo que sobra.

La clave del éxito no está en el método que elijas, sino en la consistencia. Empieza con un método, pruébalo durante 30 días y ajusta según tus resultados.',
 10, 2, 20, true),

('b1000003-0000-0000-0000-000000000003',
 'c4cde30f-5c9c-4727-8293-fd8f51dd1549',
 'Fondo de emergencia: tu colchón financiero',
 'Aprende a construir y mantener un fondo de emergencia que te proteja ante imprevistos.',
 'El fondo de emergencia es una cantidad de dinero reservada específicamente para situaciones inesperadas: pérdida de empleo, emergencias médicas, reparaciones urgentes del hogar o del vehículo. No es un fondo para vacaciones ni para compras impulsivas.

¿Cuánto necesitas? La regla general es tener entre 3 y 6 meses de tus gastos mensuales básicos. Si tus gastos esenciales son de $1.500.000 al mes, tu fondo debería estar entre $4.500.000 y $9.000.000. Para trabajadores independientes o con ingresos variables, se recomienda hasta 12 meses.

¿Dónde guardarlo? El fondo de emergencia debe estar en una cuenta separada de tu cuenta diaria, de fácil acceso pero no tan disponible como para usarlo en gastos cotidianos. Una cuenta de ahorros de alto rendimiento o un depósito a la vista son buenas opciones. Evita invertirlo en activos volátiles como acciones porque podrías necesitarlo cuando el mercado esté a la baja.

¿Cómo construirlo? Empieza con una meta pequeña: tu primer objetivo puede ser $500.000. Luego aumenta gradualmente. Automatiza transferencias quincenales o mensuales. Destina ingresos extraordinarios como aguinaldos, bonos o devoluciones de impuestos directamente a este fondo.

¿Cuándo usarlo? Solo para verdaderas emergencias. Define claramente qué califica: una emergencia médica sí, una oferta de zapatos no. Lleva un registro de los retiros y repón el fondo lo antes posible después de usarlo.',
 9, 3, 20, true),

('b1000004-0000-0000-0000-000000000004',
 'c4cde30f-5c9c-4727-8293-fd8f51dd1549',
 'Ahorro para metas a corto, mediano y largo plazo',
 'Aprende a diferenciar tus metas financieras por horizonte temporal y a crear planes de ahorro específicos.',
 'No todas las metas financieras son iguales. Clasificarlas por horizonte temporal te ayuda a elegir el vehículo de ahorro adecuado y a mantener la motivación.

Metas a corto plazo (menos de 1 año): Son objetivos inmediatos como unas vacaciones, un curso, un electrodoméstico o el fondo de emergencia. Para estas metas, utiliza cuentas de ahorro tradicionales o depósitos a plazo fijo corto. La liquidez es importante porque necesitarás el dinero pronto. Ejemplo: ahorra $200.000 al mes durante 6 meses para un viaje de $1.200.000.

Metas a mediano plazo (1 a 5 años): Incluyen la compra de un coche, la entrada de una vivienda, estudios universitarios o iniciar un negocio. Aquí puedes considerar instrumentos que generen algo más de rendimiento, como certificados de depósito a término (CDTs) o fondos de inversión de bajo riesgo. Ejemplo: ahorra $500.000 al mes durante 3 años para la entrada de un apartamento.

Metas a largo plazo (más de 5 años): La jubilación es el ejemplo clásico, pero también puede ser la educación universitaria de tus hijos o la compra de una propiedad. Para estas metas, el interés compuesto es tu mejor aliado. Puedes invertir en fondos de pensiones voluntarias, acciones o bienes raíces. Mientras más tiempo tengas, más riesgo puedes asumir.

La clave está en tener un plan específico para cada meta: define el monto total, el plazo, el ahorro mensual necesario y el instrumento financiero. Revisa tu progreso periódicamente y celebra los logros intermedios.',
 10, 4, 20, true),

('b1000005-0000-0000-0000-000000000005',
 'c4cde30f-5c9c-4727-8293-fd8f51dd1549',
 'Cómo reducir gastos sin sacrificar calidad de vida',
 'Estrategias prácticas para gastar menos sin sentir que te estás privando de lo que disfrutas.',
 'Reducir gastos no significa vivir con lo mínimo ni eliminar todo lo que te gusta. Se trata de gastar de manera más inteligente, identificando dónde se va tu dinero y eliminando fugas innecesarias sin sacrificar tu bienestar.

Identifica los gastos hormiga: esos pequeños gastos diarios que parecen insignificantes pero suman una fortuna al mes. Un café de $5.000 diario son $150.000 al mes. Una suscripción de $20.000 que no usas son $240.000 al año. Revisa tus extractos bancarios y encuentra estos pequeños drenajes.

Aplica la regla de las 24 horas: antes de hacer una compra no esencial, espera 24 horas. Esto elimina las compras impulsivas y te permite evaluar si realmente necesitas ese artículo. La mayoría de las veces descubrirás que no lo necesitas.

Optimiza tus servicios: revisa tus suscripciones (streaming, gimnasio, apps), planes de telefonía e internet, seguros. Compara precios cada 6 meses y negocia mejores tarifas. Muchas empresas ofrecen descuentos por fidelidad o por pagar al día.

Cocina más en casa: comer fuera o pedir delivery es 3 o 4 veces más caro que cocinar. Dedica un par de horas el fin de semana a planificar tus comidas. No solo ahorrarás dinero, sino que también comerás más saludable.

Ahorra en servicios públicos: apaga luces y electrodomésticos que no uses, aprovecha la luz natural, revisa el consumo de agua. Pequeños cambios como estos pueden reducir tu factura hasta en un 20%.

Recuerda: la meta no es gastar lo mínimo posible, sino gastar en lo que realmente te importa y reducir lo que no te aporta valor.',
 9, 5, 15, true),

('b1000006-0000-0000-0000-000000000006',
 'c4cde30f-5c9c-4727-8293-fd8f51dd1549',
 'Automatización del ahorro: gane sin esfuerzo',
 'Descubre cómo la automatización puede transformar tus finanzas sin que tengas que pensarlo cada mes.',
 'La automatización del ahorro es una de las estrategias más poderosas y subestimadas en finanzas personales. El principio es simple: haz que el ahorro ocurra automáticamente, antes de que tengas la oportunidad de gastar ese dinero.

¿Cómo funciona? Configura una transferencia automática desde tu cuenta principal a tu cuenta de ahorros el mismo día que recibes tu salario. Si el dinero nunca está disponible en tu cuenta de gastos, la tentación de gastarlo desaparece. Esto se conoce como "pagarse a uno mismo primero".

Las ventajas son enormes. Primero, eliminas la fuerza de voluntad de la ecuación: no tienes que decidir cada mes si vas a ahorrar o no, simplemente ocurre. Segundo, creas un hábito sin esfuerzo. Tercero, reduces el estrés financiero porque sabes que estás ahorrando consistentemente.

¿Cuánto automatizar? Empieza con un porcentaje pequeño que no sientas en tu día a día, como el 5% o 10% de tus ingresos. Cada 3 meses, aumenta ese porcentaje en 1 o 2 puntos porcentuales. Así tu cerebro se adapta gradualmente a vivir con menos.

Herramientas útiles: la mayoría de los bancos ofrecen transferencias programadas gratuitas. También puedes usar apps de finanzas que redondean tus compras al peso superior y guardan la diferencia, o que transfieren automáticamente según reglas que tú defines.

La automatización también aplica para inversiones, pagos de deudas y aportes a fondos de pensión. Cuanto más automatices tu vida financiera, más energía mental liberas para otras áreas importantes de tu vida.',
 7, 6, 15, true);

-- Módulo: Presupuesto (5 lecciones)
INSERT INTO public.lessons (id, module_id, title, summary, content, estimated_minutes, order_index, points_reward, is_active)
VALUES

('b1000007-0000-0000-0000-000000000007',
 '2037342b-9875-40ce-b525-72e4bd37a748',
 '¿Qué es un presupuesto y por qué necesitas uno?',
 'Entiende el concepto de presupuesto como herramienta fundamental de control financiero.',
 'Un presupuesto es un plan financiero que estima tus ingresos y gastos durante un período determinado, generalmente un mes. Es una hoja de ruta que te dice hacia dónde va tu dinero y te ayuda a decidir conscientemente cómo quieres gastarlo.

Muchas personas evitan hacer presupuestos porque lo ven como algo restrictivo o tedioso. La realidad es todo lo contrario: un presupuesto te da libertad financiera porque sabes exactamente cuánto puedes gastar en cada categoría sin culpa ni sorpresas a fin de mes.

¿Por qué necesitas uno? Sin presupuesto, gastas por inercia. El dinero se va en pequeñas cantidades que no percibes hasta que llega la cuenta de la tarjeta de crédito. Un presupuesto te da visibilidad, control y dirección.

Beneficios clave del presupuesto: (1) Sabes exactamente cuánto ganas y cuánto gastas. (2) Identificas áreas donde puedes reducir gastos. (3) Priorizas tus metas financieras. (4) Evitas deudas innecesarias. (5) Reduces el estrés financiero. (6) Te prepara para imprevistos.

El primer paso es registrar todos tus ingresos y gastos durante un mes. Sé honesto y no omitas nada: desde el café de la mañana hasta la prima del seguro. Después, clasifica tus gastos en categorías y compáralos con tus ingresos. El objetivo es que tus gastos no superen tus ingresos y que destines un porcentaje al ahorro.',
 10, 1, 20, true),

('b1000008-0000-0000-0000-000000000008',
 '2037342b-9875-40ce-b525-72e4bd37a748',
 'Tipos de presupuesto: fijo, flexible, basado en cero',
 'Conoce los diferentes enfoques de presupuestación y elige el que mejor funcione para ti.',
 'No existe un solo tipo de presupuesto que funcione para todos. Cada persona tiene una relación diferente con el dinero y necesita un enfoque que se adapte a su personalidad y circunstancias.

Presupuesto fijo o tradicional: Es el más simple. Listas tus ingresos, restas tus gastos fijos (arriendo, servicios, deudas) y lo que sobra lo distribuyes entre gastos variables y ahorro. Funciona bien para personas con ingresos estables y gastos predecibles. Su limitación es que no se adapta bien a cambios inesperados.

Presupuesto flexible: Similar al fijo pero con categorías ajustables. Si gastas menos en alimentación, puedes transferir ese excedente a entretenimiento o ahorro. Es más realista porque reconoce que los gastos varían mes a mes. Requiere disciplina para no flexibilizar demasiado y descuidar metas importantes.

Presupuesto basado en cero (zero-based budgeting): Cada peso de tus ingresos tiene una asignación específica. Ingresos menos gastos debe ser igual a cero. No se trata de gastar todo, sino de asignar cada peso a una categoría, incluyendo ahorro e inversión. Es el método más detallado y efectivo, pero también el que más tiempo requiere.

Presupuesto de sobres (envelope system): Ideal para controlar gastos variables. Asignas efectivo a sobres físicos o digitales por categoría: alimentación, transporte, ocio, etc. Cuando el sobre se vacía, dejas de gastar en esa categoría. Es muy efectivo para quienes tienden a sobregirarse en ciertas áreas.

La recomendación es empezar con el método más simple y evolucionar a medida que te sientas más cómodo. Lo importante es mantener la consistencia y ajustar tu presupuesto mensualmente según tu realidad.',
 11, 2, 20, true),

('b1000009-0000-0000-0000-000000000009',
 '2037342b-9875-40ce-b525-72e4bd37a748',
 'Herramientas digitales para controlar tu presupuesto',
 'Descubre apps y herramientas que facilitan el seguimiento de tu presupuesto diario.',
 'La tecnología ha simplificado enormemente la gestión del presupuesto. Ya no necesitas una libreta y una calculadora; existen herramientas digitales que hacen el trabajo por ti de manera automática y en tiempo real.

Hojas de cálculo: Google Sheets y Excel son herramientas gratuitas y flexibles. Puedes crear tu propio formato o usar plantillas prediseñadas. Ventajas: personalización total, sin límite de categorías, aprendizajes valiosos sobre tus finanzas. Desventajas: requieren ingreso manual de datos.

Apps de presupuesto: Aplicaciones como Fintonic, Money Manager, Mint o YNAB (You Need A Budget) se sincronizan con tus cuentas bancarias, categorizan gastos automáticamente y generan reportes visuales. Algunas ofrecen alertas cuando te acercas a tu límite en una categoría.

Apps bancarias: La mayoría de los bancos colombianos ofrecen herramientas básicas de presupuesto en sus apps: categorización de gastos, gráficos de consumo, alertas de sobregiro. Si bien son menos completas que las apps especializadas, tienen la ventaja de estar integradas con tu cuenta.

Características que buscar en una herramienta: (1) Sincronización automática con tus cuentas. (2) Categorización inteligente de gastos. (3) Alertas y notificaciones. (4) Reportes visuales (gráficos circulares, de barras). (5) Opción de presupuesto compartido si manejas finanzas en pareja. (6) Seguridad y encriptación de datos.

Consejo importante: la mejor herramienta es la que realmente usas. Prueba 2 o 3 opciones durante una semana cada una y quédate con la que te resulte más natural. No caigas en la trampa de pasar más tiempo ajustando la herramienta que manejando tus finanzas.',
 8, 3, 15, true),

('b1000010-0000-0000-0000-000000000010',
 '2037342b-9875-40ce-b525-72e4bd37a748',
 'Cómo ajustar tu presupuesto cuando cambian tus ingresos',
 'Aprende a adaptar tu presupuesto a cambios de ingresos: aumentos, reducciones o ingresos variables.',
 'La vida es cambiante y tus ingresos también pueden serlo. Un aumento de sueldo, una reducción de horas, un cambio de trabajo o una emergencia pueden alterar tu flujo de caja. Saber ajustar tu presupuesto a estas nuevas realidades es una habilidad financiera crucial.

Cuando tus ingresos aumentan: Es tentador aumentar tu nivel de vida proporcionalmente, pero este es un error común conocido como "inflación del estilo de vida". En lugar de gastar todo el aumento, aplica la regla del 50/50: destina el 50% del aumento a ahorro e inversión y el otro 50% a mejorar tu calidad de vida. Así disfrutas el presente sin sacrificar tu futuro.

Cuando tus ingresos disminuyen: Lo primero es no entrar en pánico. Revisa tu presupuesto actual y clasifica tus gastos en esenciales (vivienda, alimentación, salud) y no esenciales (entretenimiento, viajes, suscripciones). Reduce o elimina los no esenciales temporalmente. Si la reducción es permanente, considera ajustar también tus gastos fijos: renegocia el arriendo, cambia de plan de telefonía, busca opciones más económicas de seguros.

Para ingresos variables (freelancers, comisionistas): Tu presupuesto debe basarse en tu ingreso mínimo mensual, no en el promedio. Crea un "colchón de ingresos" equivalente a 2 o 3 meses de gastos para los meses bajos. En los meses altos, ahorra el excedente. Calcula tu ingreso promedio anual y úsalo como referencia, pero opera siempre con tu ingreso mínimo garantizado.

Herramienta útil: el presupuesto por porcentajes. En lugar de montos fijos, asigna porcentajes de tus ingresos a cada categoría. Así, si tus ingresos varían, los montos se ajustan automáticamente mientras mantienes tus prioridades.',
 10, 4, 20, true),

('b1000011-0000-0000-0000-000000000011',
 '2037342b-9875-40ce-b525-72e4bd37a748',
 'Errores comunes al hacer presupuestos y cómo evitarlos',
 'Identifica los errores más frecuentes en la presupuestación y aprende a evitarlos para lograr tus metas.',
 'Hacer un presupuesto es fácil, pero mantenerlo es el verdadero desafío. Muchas personas abandonan su presupuesto en las primeras semanas por errores evitables. Conocerlos te ayudará a crear un presupuesto sostenible.

Error 1: Ser demasiado restrictivo. Un presupuesto que no permite ningún gasto en entretenimiento o placer está destinado al fracaso. La clave es el equilibrio: incluye una categoría de "gustos" o "ocio" realista. Si eliminas todo lo divertido, terminarás abandonando el presupuesto por frustración.

Error 2: No incluir gastos irregulares. Gastos como el seguro del coche, la matrícula universitaria, los regalos de cumpleaños o el mantenimiento del hogar no ocurren todos los meses pero debes planificarlos. Divide estos gastos anuales entre 12 e incluye esa cantidad en tu presupuesto mensual.

Error 3: Olvidar el fondo de emergencia. Si tu presupuesto no incluye el ahorro para emergencias, cualquier imprevisto descarrilará tus finanzas. Trata el ahorro para emergencias como un gasto fijo mensual, no como "lo que sobra al final del mes".

Error 4: No revisar el presupuesto regularmente. Crear un presupuesto y olvidarlo es como hacer un mapa y no mirarlo durante el viaje. Revisa tu presupuesto semanalmente (10-15 minutos) y ajusta las categorías según sea necesario.

Error 5: No involucrar a la familia. Si vives con tu pareja o familia, el presupuesto debe ser un esfuerzo de equipo. Si una persona hace el presupuesto y la otra lo ignora, no funcionará. Establezcan juntos las prioridades y revisen el progreso mensualmente.

Error 6: Rendirse después de un mes malo. Todos tenemos meses donde gastamos de más. No significa que el presupuesto no funcione. Aprende de lo que pasó, ajusta y continúa. El éxito financiero no es la perfección, sino la consistencia.',
 9, 5, 20, true);

-- Módulo: Deuda (5 lecciones)
INSERT INTO public.lessons (id, module_id, title, summary, content, estimated_minutes, order_index, points_reward, is_active)
VALUES

('b1000012-0000-0000-0000-000000000012',
 'fdcc27f6-130e-4291-930a-9fdc0cd3a96b',
 'Tipos de deuda: buena vs mala',
 'Aprende a diferenciar entre deudas que te ayudan a crecer y deudas que te hunden financieramente.',
 'No todas las deudas son iguales. Existe una diferencia fundamental entre la deuda que te ayuda a construir patrimonio (deuda buena) y la que te consume financieramente (deuda mala). Saber diferenciarlas es esencial para tomar decisiones financieras inteligentes.

Deuda buena: Es aquella que utilizas para adquirir activos que aumentan de valor o que generan ingresos. Ejemplos: un crédito hipotecario para comprar una vivienda (el inmueble se revaloriza), un préstamo estudiantil para una carrera universitaria (aumenta tu potencial de ingresos), un crédito para iniciar un negocio (genera ganancias). Estas deudas tienen una tasa de retorno esperada mayor que el costo del interés.

Deuda mala: Es la que adquieres para comprar bienes que se deprecian o para financiar un estilo de vida que no puedes pagar. Ejemplos: una tarjeta de crédito al límite para ropa, viajes y restaurantes; un préstamo para un carro de lujo que supera tu capacidad de pago; créditos de consumo con tasas de interés del 20% o 30% para electrodomésticos. Estas deudas no generan valor y te mantienen atrapado en un ciclo de pagos.

La regla de oro: antes de adquirir cualquier deuda, pregúntate: ¿Este préstamo me ayudará a generar más ingresos o a construir patrimonio? ¿La tasa de interés es razonable? ¿Puedo pagarlo cómodamente sin afectar mis gastos básicos y mi ahorro?

El peligro de la deuda mala es el interés compuesto inverso: mientras el interés compuesto puede hacer crecer tu dinero, en las deudas trabaja en tu contra, multiplicando lo que debes. Una deuda de $1.000.000 al 24% anual puede convertirse en $2.000.000 en solo 3 años si solo pagas los intereses mínimos.',
 11, 1, 20, true),

('b1000013-0000-0000-0000-000000000013',
 'fdcc27f6-130e-4291-930a-9fdc0cd3a96b',
 'Estrategias para pagar deudas: bola de nieve vs avalancha',
 'Compara los dos métodos más efectivos para salir de deudas y elige el que mejor se adapte a tu personalidad.',
 'Si tienes múltiples deudas, saber por dónde empezar puede ser abrumador. Los dos métodos más populares para salir de deudas son la bola de nieve (snowball) y la avalancha (avalanche). Ambos son efectivos, pero funcionan mejor para diferentes tipos de personalidad.

Método bola de nieve (snowball): Popularizado por Dave Ramsey, consiste en listar todas tus deudas de menor a mayor saldo, sin importar la tasa de interés. Pagas el mínimo de todas excepto la más pequeña, a la que destinas todo el dinero extra que puedas. Cuando pagas esa deuda, tomas el dinero que destinabas a ella y lo aplicas a la siguiente deuda más pequeña, y así sucesivamente.

Ventajas: proporciona victorias rápidas y motivación psicológica. Cada deuda cancelada te da impulso emocional para continuar. Es ideal si necesitas motivación constante para mantener el hábito.

Desventajas: puede terminar costando más en intereses porque no priorizas las deudas con tasas más altas.

Método avalancha (avalanche): En este método, ordenas tus deudas de mayor a menor tasa de interés. Pagas el mínimo de todas y destinas el dinero extra a la deuda con el interés más alto. Una vez pagada, continúas con la siguiente deuda de mayor interés.

Ventajas: matemáticamente más eficiente. Ahorras más dinero en intereses a largo plazo. Es el método recomendado si eres disciplinado y racional con tus finanzas.

Desventajas: si la deuda de mayor interés tiene un saldo grande, puede tomar meses ver un progreso significativo, lo que puede desmotivar.

Recomendación: si eres una persona emocional que necesita motivación constante, usa el método bola de nieve. Si eres analítico y quieres optimizar cada peso, usa el método avalancha. Ambos son mejores que no tener ningún plan.',
 10, 2, 20, true),

('b1000014-0000-0000-0000-000000000014',
 'fdcc27f6-130e-4291-930a-9fdc0cd3a96b',
 'Consolidación de deudas: ¿conviene o no?',
 'Analiza cuándo la consolidación de deudas puede ser una solución y cuándo puede empeorar tu situación.',
 'La consolidación de deudas consiste en agrupar varias deudas en un solo préstamo, generalmente con una tasa de interés más baja y un plazo más largo. Suena atractivo, pero tiene ventajas y desventajas que debes conocer antes de decidir.

¿Cómo funciona? Si tienes 3 tarjetas de crédito con tasas del 28% al 36% y un préstamo personal al 20%, puedes solicitar un crédito de consolidación que pague todas esas deudas y te deje con una sola cuota mensual a una tasa más baja, por ejemplo del 18%.

Ventajas de consolidar: (1) Una sola cuota mensual más fácil de recordar y gestionar. (2) Posibilidad de obtener una tasa de interés más baja. (3) Reduce el estrés de manejar múltiples fechas de pago. (4) Puede mejorar tu historial crediticio si cumples puntualmente.

Desventajas: (1) Puede extender el plazo de pago, haciendo que pagues más intereses a largo plazo. (2) Riesgo de caer en el "efecto rebote": al liberar tus tarjetas de crédito, puedes sentir que tienes más capacidad de endeudamiento y acumular nuevas deudas. (3) Algunos préstamos de consolidación tienen costos de originación o penalizaciones por pago anticipado.

¿Cuándo conviene? Cuando: (1) realmente obtienes una tasa de interés significativamente más baja; (2) tienes la disciplina para no endeudarte nuevamente; (3) el plazo no se extiende excesivamente; (4) los costos de originación no superan el ahorro en intereses.

¿Cuándo no conviene? Cuando: (1) la raíz del problema es tu comportamiento de gasto, no las tasas de interés; (2) la consolidación solo oculta el problema temporalmente; (3) las condiciones del nuevo préstamo son peores que las actuales.

Antes de consolidar, haz números concretos. Calcula el total de intereses que pagarías con y sin consolidación. Si la consolidación te ahorra dinero Y resuelve un problema real de gestión, puede ser una buena opción.',
 10, 3, 20, true),

('b1000015-0000-0000-0000-000000000015',
 'fdcc27f6-130e-4291-930a-9fdc0cd3a96b',
 'Cómo negociar con tus acreedores',
 'Aprende técnicas efectivas para negociar tasas, plazos y descuentos con quienes te prestaron dinero.',
 'Muchas personas no saben que pueden negociar sus deudas. Los acreedores prefieren recuperar algo a no recuperar nada, y están abiertos a negociar si les demuestras buena fe y disposición de pago. Aquí te enseñamos cómo hacerlo.

Preparación antes de llamar: (1) Ten claros tus números: cuánto debes, a qué tasa, cuánto puedes pagar realmente. (2) Revisa tu historial de pagos: si has sido puntual, tienes más poder de negociación. (3) Investiga las opciones que ofrecen otros bancos o competidores. (4) Prepara un guión con lo que vas a decir.

Qué puedes negociar: (1) Reducción de la tasa de interés (especialmente si han bajado las tasas del mercado). (2) Extensión del plazo para reducir la cuota mensual. (3) Período de gracia sin intereses. (4) Condonación de intereses moratorios o cargos por mora. (5) Descuento por pago anticipado. (6) En casos extremos: quita (reducción del saldo total).

Cómo negociar efectivamente: Sé honesto sobre tu situación financiera. No finjas lo que no puedes pagar. Explica tu situación actual y tu voluntad de pago. Propón un plan realista. Si la primera persona no puede ayudarte, pide hablar con un supervisor o el departamento de dificultades económicas.

Qué hacer si tu deuda está en cobranza: Las agencias de cobranza compran deudas por fracciones de su valor original. Esto significa que están dispuestas a aceptar pagos significativamente menores al saldo total. Puedes negociar acuerdos de pago por montos mucho más bajos, pero asegúrate de obtener todo por escrito antes de pagar.

Recuerda: la negociación es un proceso. No te desanimes si no logras lo que quieres en la primera llamada. Sé persistente, educado y profesional. Los acreedores prefieren llegar a un acuerdo que continuar con procesos de cobranza costosos.',
 9, 4, 15, true),

('b1000016-0000-0000-0000-000000000016',
 'fdcc27f6-130e-4291-930a-9fdc0cd3a96b',
 'El ciclo de la deuda y cómo romperlo',
 'Identifica los patrones que te mantienen endeudado y aprende a romper el ciclo para siempre.',
 'El ciclo de la deuda es un patrón recurrente que atrapa a millones de personas: necesitas dinero, pides prestado, pagas cuotas, liberas crédito, y vuelves a pedir prestado. Entender este ciclo es el primer paso para romperlo.

Las 5 etapas del ciclo: (1) Necesidad o deseo: surge una necesidad o un deseo de consumo. (2) Endeudamiento: usas crédito porque no tienes el efectivo disponible. (3) Pago mínimo: pagas solo el mínimo, los intereses se acumulan. (4) Liberación de cupo: al pagar, el cupo se libera y sientes que tienes dinero disponible. (5) Repetición: vuelves a usar el crédito para otra necesidad o deseo.

¿Por qué es tan difícil romperlo? Porque el ciclo está diseñado por la industria financiera para mantenerte endeudado. Las tarjetas de crédito tienen tasas de interés altísimas, los pagos mínimos están calculados para maximizar los intereses, y la disponibilidad de crédito te da una falsa sensación de riqueza.

Cómo romper el ciclo: (1) Toma conciencia de tu situación: haz una lista completa de todas tus deudas con tasas y plazos. (2) Establece una regla personal: no uses tarjetas de crédito para gastos diarios ni para cosas que se deprecian. (3) Crea un fondo de emergencia: así no necesitarás crédito para imprevistos. (4) Usa efectivo o débito: durante 3 meses, usa solo efectivo o tarjeta débito. Sentirás físicamente el dinero salir de tu bolsillo. (5) Cancela tarjetas que no uses: reduce tu exposición al crédito fácil. (6) Celebra los hitos: cada deuda cancelada es una victoria que merece reconocimiento.

La libertad financiera no es tener mucho dinero, es no depender del crédito para vivir. Romper el ciclo de la deuda es el paso más importante hacia esa libertad.',
 8, 5, 15, true);

-- Módulo: Inversión (4 lecciones)
INSERT INTO public.lessons (id, module_id, title, summary, content, estimated_minutes, order_index, points_reward, is_active)
VALUES

('b1000017-0000-0000-0000-000000000017',
 '8f4d378a-9830-46c3-83ad-def7a3e0ac29',
 'Conceptos básicos de inversión para principiantes',
 'Conoce los fundamentos de la inversión: riesgo, rendimiento, liquidez y horizonte temporal.',
 'Invertir es poner tu dinero a trabajar para ti. A diferencia del ahorro, donde guardas dinero, la inversión busca hacer crecer ese dinero a través del tiempo. Es la herramienta más poderosa para construir riqueza a largo plazo.

Tres conceptos fundamentales: (1) Riesgo: la posibilidad de perder parte o todo tu dinero invertido. Generalmente, a mayor rendimiento potencial, mayor riesgo. (2) Rendimiento: la ganancia que obtienes de tu inversión, expresada como porcentaje anual. (3) Liquidez: la facilidad con la que puedes convertir tu inversión en efectivo sin perder valor.

La relación riesgo-rendimiento: No existe inversión segura con alto rendimiento. Si alguien te ofrece eso, es una estafa. Las inversiones de bajo riesgo (CDTs, bonos del gobierno) ofrecen rendimientos bajos. Las de alto riesgo (acciones de startups, criptomonedas) pueden ofrecer rendimientos altos pero también pueden perder todo su valor.

Horizonte temporal: El tiempo que planeas mantener tu inversión determina qué tipo de inversiones son adecuadas para ti. A corto plazo (menos de 2 años): inversiones de bajo riesgo y alta liquidez. A mediano plazo (2-5 años): inversiones de riesgo moderado. A largo plazo (más de 5 años): puedes asumir más riesgo porque tienes tiempo para recuperarte de las caídas del mercado.

Diversificación: No pongas todos tus huevos en la misma canasta. Distribuye tu inversión entre diferentes tipos de activos (acciones, bonos, bienes raíces, efectivo) para reducir el riesgo general de tu portafolio.

Para empezar a invertir, primero asegúrate de tener un fondo de emergencia, no tener deudas de alto interés y tener ingresos estables. Luego, empieza con montos pequeños que estés dispuesto a perder y educarte constantemente.',
 12, 1, 25, true),

('b1000018-0000-0000-0000-000000000018',
 '8f4d378a-9830-46c3-83ad-def7a3e0ac29',
 'Interés compuesto: el octavo milagro del mundo',
 'Descubre el poder del interés compuesto y cómo puede multiplicar tu dinero con el tiempo.',
 'Albert Einstein llamó al interés compuesto "el octavo milagro del mundo" y "la fuerza más poderosa del universo". Entenderlo es la clave para construir riqueza a largo plazo.

¿Qué es el interés compuesto? Es el interés que generas sobre los intereses anteriores. Si inviertes $1.000.000 y ganas un 10% anual, el primer año ganas $100.000. El segundo año, ganas 10% sobre $1.100.000, es decir $110.000. El tercer año, ganas sobre $1.210.000. Tu dinero crece exponencialmente, no linealmente.

La fórmula mágica: Valor Futuro = Valor Presente × (1 + tasa)^tiempo. El factor más importante es el tiempo. Cuanto más tiempo tengas, más poderoso es el efecto. Dos personas que invierten la misma cantidad pero una empieza 10 años antes, termina con mucho más dinero.

Ejemplo real: María invierte $500.000 al mes desde los 25 años hasta los 35 años (10 años, total invertido $60.000.000). Juan invierte $500.000 al mes desde los 35 hasta los 65 años (30 años, total invertido $180.000.000). Con un rendimiento del 8% anual, María termina con más dinero que Juan porque su dinero tuvo 30 años adicionales de crecimiento compuesto.

La regla del 72: Para calcular cuánto tiempo tarda tu dinero en duplicarse, divide 72 entre la tasa de rendimiento anual. Si inviertes al 8% anual, tu dinero se duplica cada 9 años (72/8=9). Al 12% anual, cada 6 años.

Cómo aprovechar el interés compuesto: (1) Empieza cuanto antes, aunque sea con montos pequeños. (2) Sé constante: invierte regularmente, no importa el monto. (3) Reinvierte tus ganancias, no las retires. (4) Ten paciencia: el interés compuesto funciona mejor a largo plazo. (5) No interrumpas el proceso: los retiros anticipados rompen el efecto compuesto.

El interés compuesto también aplica al conocimiento financiero: cada lección que aprendes se suma a las anteriores, multiplicando tu capacidad de tomar mejores decisiones financieras.',
 10, 2, 25, true),

('b1000019-0000-0000-0000-000000000019',
 '8f4d378a-9830-46c3-83ad-def7a3e0ac29',
 'Opciones de inversión en Colombia: CDTs, fondos, acciones',
 'Conoce las alternativas de inversión disponibles en el mercado colombiano y sus características.',
 'El mercado colombiano ofrece diversas opciones de inversión para diferentes perfiles de riesgo y horizontes temporales. Conocerlas te permite construir un portafolio diversificado y adecuado a tus necesidades.

CDTs (Certificados de Depósito a Término): Son títulos de deuda emitidos por bancos. Prestas tu dinero al banco por un plazo fijo (30 a 720 días) y recibes un interés garantizado. Están asegurados por Fogafín hasta $50.000.000 por entidad. Son de bajo riesgo pero ofrecen rendimientos moderados. Ideales para metas a corto y mediano plazo.

Fondos de inversión colectiva: Agrupan el dinero de múltiples inversionistas para invertir en diferentes activos. Gestionados por profesionales. Hay fondos de renta fija (bajo riesgo), renta variable (alto riesgo) y balanceados (riesgo medio). La inversión mínima suele ser baja, desde $50.000.

Acciones (Bolsa de Valores de Colombia - BVC): Compras una pequeña parte de una empresa. Puedes ganar por revalorización (la acción sube de precio) y por dividendos (la empresa reparte parte de sus ganancias). Alto riesgo pero alto potencial de rendimiento. Requiere conocimiento del mercado o asesoría profesional.

ETF (Exchange Traded Funds): Fondos que se negocian en bolsa como acciones. Invierten en un índice (como el COLCAP) o en un sector específico. Ofrecen diversificación instantánea con una sola compra. Comisiones más bajas que los fondos tradicionales.

Criptomonedas: Activos digitales como Bitcoin o Ethereum. Altísimo riesgo y volatilidad extrema. Solo aptas para perfiles muy agresivos y con dinero que puedas perder completamente. No son recomendadas para inversionistas principiantes.

Bienes raíces: Inversión en propiedades para arriendo o plusvalía. Requiere capital significativo. Ofrece protección contra inflación pero baja liquidez. Alternativa: fondos inmobiliarios o REITs con inversiones desde $100.000.

Recomendación para principiantes: empieza con CDTs o fondos de inversión de bajo riesgo mientras aprendes. Aumenta gradualmente el riesgo a medida que ganas experiencia y conocimiento.',
 12, 3, 25, true),

('b1000020-0000-0000-0000-000000000020',
 '8f4d378a-9830-46c3-83ad-def7a3e0ac29',
 'Cómo crear un portafolio de inversión diversificado',
 'Aprende a construir un portafolio balanceado que maximice rendimientos y minimice riesgos.',
 'La diversificación es el principio más importante de la inversión. Consiste en distribuir tu dinero entre diferentes tipos de activos para reducir el riesgo sin sacrificar rendimiento potencial. Como dice el refrán: no pongas todos los huevos en la misma canasta.

¿Por qué diversificar? Cuando un activo baja, otro puede subir. Por ejemplo, cuando las acciones bajan, los bonos suelen subir. Cuando la economía colombiana se desacelera, las inversiones internacionales pueden rendir bien. La diversificación suaviza los altibajos de tu portafolio.

La asignación de activos: Es el proceso de decidir qué porcentaje de tu dinero va a cada tipo de activo. Tu asignación ideal depende de tres factores: (1) Tu horizonte temporal: a más plazo, más riesgo puedes asumir. (2) Tu tolerancia al riesgo: ¿cómo reaccionarías si tu portafolio perdiera el 20% en un año? (3) Tus metas financieras: metas específicas requieren estrategias específicas.

Ejemplo de portafolios por perfil:

Perfil conservador (corto plazo, baja tolerancia): 80% renta fija (CDTs, bonos), 10% fondos balanceados, 10% efectivo. Rendimiento esperado: 4-6% anual.

Perfil moderado (mediano plazo, tolerancia media): 50% renta fija, 30% renta variable (acciones, ETF), 10% bienes raíces, 10% alternativos. Rendimiento esperado: 6-9% anual.

Perfil agresivo (largo plazo, alta tolerancia): 70% renta variable, 20% renta fija, 10% alternativos. Rendimiento esperado: 9-12% anual.

Rebalanceo: Con el tiempo, algunos activos crecen más que otros y tu portafolio se desbalancea. El rebalanceo consiste en vender los activos que crecieron y comprar los que bajaron para mantener tu asignación original. Esto te obliga a comprar barato y vender caro automáticamente.

Para empezar: no necesitas ser un experto. Un portafolio simple con 2 o 3 fondos diversificados (un fondo de renta fija, uno de renta variable y uno internacional) puede ser suficiente. Lo importante es empezar, ser constante y mantener la disciplina.',
 11, 4, 20, true);

-- Módulo: Crédito (4 lecciones)
INSERT INTO public.lessons (id, module_id, title, summary, content, estimated_minutes, order_index, points_reward, is_active)
VALUES

('b1000021-0000-0000-0000-000000000021',
 'd4655d09-abb1-41de-b04a-2673662b29fd',
 '¿Qué es el historial crediticio y cómo se construye?',
 'Entiende la importancia del historial crediticio y cómo construir uno sólido desde cero.',
 'Tu historial crediticio es el registro de cómo has manejado tus deudas y obligaciones financieras. Es como tu "hoja de vida financiera" y las entidades crediticias lo consultan para decidir si te prestan dinero, cuánto y a qué tasa.

¿Quién lo administra? En Colombia, las centrales de riesgo como Datacrédito (Experian) y Cifin recolectan información de tus créditos, pagos y comportamiento financiero. Tienen datos positivos (pagos puntuales, buen manejo) y negativos (morosidad, castigos).

¿Qué información contiene? (1) Tus datos personales. (2) Listado de todos tus créditos activos y cerrados. (3) Comportamiento de pago: si pagas puntual o tienes retrasos. (4) Cupos de tarjetas de crédito y su utilización. (5) Consultas realizadas a tu historial. (6) Score crediticio: un puntaje que resume tu comportamiento.

¿Cómo construir un buen historial si empiezas desde cero? (1) Solicita una tarjeta de crédito con cupo bajo garantizada (respalda el cupo con un CDT). (2) Úsala para gastos pequeños y paga el total cada mes sin falta. (3) No uses más del 30% de tu cupo disponible. (4) Mantén tus primeros créditos activos por al menos 6 meses. (5) Evita solicitar múltiples créditos en poco tiempo.

Factores que afectan tu score: Los más importantes son el historial de pagos (35%), el nivel de endeudamiento (30%), la antigüedad del historial (15%), los tipos de crédito que manejas (10%) y las consultas recientes (10%).

Errores comunes: (1) Cerrar tarjetas viejas al obtener una nueva (pierdes antigüedad). (2) No revisar tu historial periódicamente (puede tener errores). (3) Pagar solo el mínimo de la tarjeta (afecta tu nivel de endeudamiento). (4) Solicitar créditos que no necesitas solo "por si acaso".

Revisa tu historial al menos una vez al año en Datacrédito o Cifin. Es gratis y puedes hacerlo en línea. Un buen historial crediticio te abre puertas a mejores tasas, mayores cupos y condiciones más favorables.',
 10, 1, 20, true),

('b1000022-0000-0000-0000-000000000022',
 'd4655d09-abb1-41de-b04a-2673662b29fd',
 'Tarjetas de crédito: cómo usarlas a tu favor',
 'Aprende a aprovechar los beneficios de las tarjetas de crédito sin caer en el sobreendeudamiento.',
 'Las tarjetas de crédito son una herramienta financiera poderosa, pero mal utilizadas pueden convertirse en una trampa. La clave está en entender cómo funcionan y usarlas estratégicamente a tu favor.

Beneficios de las tarjetas de crédito: (1) Construyen historial crediticio si las usas responsablemente. (2) Ofrecen protección contra fraudes y compras no autorizadas. (3) Acumulan puntos, millas o cashback. (4) Diferimiento de compras a meses sin intereses. (5) Acceso a promociones exclusivas y seguros de viaje. (6) Liquidez temporal sin pagar intereses si pagas el total a tiempo.

El período de gracia: Es el tiempo entre la fecha de compra y la fecha de pago sin intereses. Generalmente es de 20 a 30 días. Si pagas el total del extracto antes de la fecha límite, no pagas intereses. Si pagas solo el mínimo, empiezas a pagar intereses sobre el saldo restante desde el día de la compra.

La regla del 30%: No utilices más del 30% de tu cupo total disponible. Si tu cupo es de $5.000.000, trata de no deber más de $1.500.000. Esto mantiene bajo tu nivel de endeudamiento y beneficia tu score crediticio.

Estrategias para usarlas a tu favor: (1) Úsalas solo para gastos presupuestados. (2) Paga el total del extracto cada mes, nunca el mínimo. (3) Aprovecha los meses sin intereses para compras planeadas, no impulsivas. (4) Revisa tus extractos mensualmente para detectar cargos no autorizados. (5) Ten máximo 2 tarjetas para mantener el control.

Lo que debes evitar: (1) Usar la tarjeta para retirar efectivo (tasas y comisiones altísimas). (2) Pagar solo el mínimo (te mantiene endeudado para siempre). (3) Tener múltiples tarjetas al límite. (4) Usar la tarjeta para gastos diarios pequeños que se acumulan sin darte cuenta. (5) Comprar cosas que no necesitas solo porque están en cuotas sin intereses.

Usada correctamente, la tarjeta de crédito es una aliada financiera. Usada incorrectamente, es una de las formas más caras de endeudamiento.',
 9, 2, 20, true),

('b1000023-0000-0000-0000-000000000023',
 'd4655d09-abb1-41de-b04a-2673662b29fd',
 'Préstamos personales vs líneas de crédito',
 'Comprende las diferencias entre préstamos personales y líneas de crédito para elegir la mejor opción.',
 'Tanto los préstamos personales como las líneas de crédito son productos financieros útiles, pero funcionan de manera diferente y son adecuados para distintas situaciones.

Préstamo personal: Recibes una cantidad fija de dinero por adelantado y la pagas en cuotas fijas durante un plazo determinado. Características: (1) Tasa de interés fija o variable. (2) Plazo definido (6 meses a 5 años). (3) Cuota fija mensual. (4) No puedes disponer de más dinero una vez desembolsado. (5) Ideal para metas específicas: compra de carro, remodelación, consolidación de deudas.

Línea de crédito: Es un cupo de dinero disponible que puedes usar cuando quieras, hasta cierto límite. Pagas intereses solo sobre lo que usas. Características: (1) Tasa de interés generalmente variable. (2) No hay plazo fijo, pero debes hacer pagos mínimos mensuales. (3) Pagas intereses solo sobre el saldo utilizado. (4) A medida que pagas, el cupo se libera. (5) Ideal para imprevistos o gastos variables.

¿Cuál elegir? Depende de tu necesidad:

Usa un préstamo personal cuando: (1) Necesitas una cantidad específica para un propósito definido. (2) Prefieres cuotas fijas y predecibles. (3) Quieres un plazo definido para pagar. (4) La tasa de interés suele ser más baja que la de una línea de crédito.

Usa una línea de crédito cuando: (1) No sabes exactamente cuánto necesitas. (2) Necesitas acceso flexible a dinero para imprevistos. (3) Puedes pagar el saldo rápidamente. (4) Quieres tener un "colchón" financiero disponible.

Costos asociados: Ambos productos pueden tener costos de estudio, comisiones, seguros asociados y penalizaciones por pago anticipado. Compara el costo total del crédito (incluyendo todos los cargos) antes de decidir.

Recomendación: No uses líneas de crédito para financiar gastos recurrentes o compras que no puedas pagar en el corto plazo. Las líneas de crédito son para necesidades temporales, no para financiar un estilo de vida.',
 9, 3, 20, true),

('b1000024-0000-0000-0000-000000000024',
 'd4655d09-abb1-41de-b04a-2673662b29fd',
 'Cómo mejorar tu score crediticio en 6 meses',
 'Estrategias prácticas y comprobadas para mejorar tu puntaje crediticio en medio año.',
 'Tu score crediticio no es permanente: puede mejorar si tomas las acciones correctas. Con disciplina y consistencia, puedes ver cambios significativos en tu puntaje en 6 meses.

Mes 1-2: Diagnóstico y limpieza. (1) Obtén tu reporte de crédito gratuito en Datacrédito o Cifin. (2) Revisa que no haya errores: deudas que ya pagaste pero aparecen abiertas, datos personales incorrectos, cuentas que no reconoces. (3) Disputa cualquier error ante la central de riesgo (es gratis). (4) Identifica qué factores están afectando más tu score.

Mes 2-3: Regularización de pagos. (1) Pon en orden todas tus cuentas: si tienes pagos atrasados, ponte al día cuanto antes. (2) Configura pagos automáticos del mínimo en todas tus cuentas. (3) Si tienes una deuda en cobranza, contacta al acreedor para negociar un acuerdo de pago. (4) El historial de pagos representa el 35% de tu score: es el factor más importante.

Mes 3-4: Reducción de endeudamiento. (1) Reduce el saldo de tus tarjetas de crédito a menos del 30% del cupo. (2) Si tienes varias tarjetas, prioriza pagar las que están más cerca del límite. (3) No cierres tarjetas viejas (la antigüedad ayuda a tu score). (4) El nivel de endeudamiento representa el 30% de tu score.

Mes 4-5: Diversificación y uso responsable. (1) Si solo tienes tarjetas de crédito, considera un pequeño préstamo personal (que puedas pagar cómodamente). (2) Demuestra que puedes manejar diferentes tipos de crédito. (3) Sigue usando tus tarjetas para gastos pequeños y pagando el total cada mes.

Mes 5-6: Monitoreo y paciencia. (1) Revisa tu score mensualmente. (2) No solicites múltiples créditos en poco tiempo. (3) Sigue pagando todo a tiempo. (4) Mantén baja tu utilización de crédito.

Resultados esperados: Siguiendo este plan, puedes esperar una mejora de 30 a 100 puntos en tu score en 6 meses, dependiendo de tu situación inicial. Los cambios más dramáticos ocurren en personas que tenían moras recientes y las regularizan.

Recuerda: mejorar tu score es un maratón, no una carrera de velocidad. Cada mes de buen comportamiento suma a tu historial.',
 10, 4, 20, true);

-- ============================================================
-- 3. ACHIEVEMENTS (10 logros automáticos)
-- ============================================================

INSERT INTO public.achievements (id, title, description, achievement_type, condition_type, condition_value, points_reward, is_active)
VALUES
  ('c0000001-0000-0000-0000-000000000001',
   'Primera lección',
   'Completaste tu primera lección. ¡El conocimiento es poder!',
   'learning', 'complete_lesson', 1, 50, true),

  ('c0000002-0000-0000-0000-000000000002',
   'Estudiante dedicado',
   'Completaste 5 lecciones. Sigues construyendo tu educación financiera.',
   'learning', 'complete_lesson', 5, 100, true),

  ('c0000003-0000-0000-0000-000000000003',
   'Ahorrador inicial',
   'Ahorraste $100.000. El primer paso hacia la libertad financiera.',
   'finance', 'save_money', 100000, 100, true),

  ('c0000004-0000-0000-0000-000000000004',
   'Maestro de quizzes',
   'Completaste 5 quizzes correctamente. Domina los conceptos financieros.',
   'learning', 'complete_quiz', 5, 120, true),

  ('c0000005-0000-0000-0000-000000000005',
   'Racha de 7 días',
   'Mantuviste una racha activa durante 7 días consecutivos.',
   'streak', 'login_streak', 7, 150, true),

  ('c0000006-0000-0000-0000-000000000006',
   'Controlador de gastos',
   'Registraste 20 gastos. Conocer a dónde va tu dinero es poder.',
   'finance', 'register_expense', 20, 80, true),

  ('c0000007-0000-0000-0000-000000000007',
   'Presupuestador constante',
   'Creaste 3 presupuestos. Planificar es la clave del éxito financiero.',
   'finance', 'create_budget', 3, 100, true),

  ('c0000008-0000-0000-0000-000000000008',
   'Pagador de deudas',
   'Realizaste 5 pagos a deudas. Vas camino a la libertad financiera.',
   'finance', 'pay_debt', 5, 200, true),

  ('c0000009-0000-0000-0000-000000000009',
   'Coleccionista de insignias',
   'Obtuviste 5 insignias. Eres un verdadero coleccionista financiero.',
   'challenge', 'badge_earned', 5, 150, true),

  ('c0000010-0000-0000-0000-000000000010',
   'Cash Capital Legend',
   'Alcanzaste 5.000 puntos totales. Eres una leyenda de las finanzas.',
   'challenge', 'total_points', 5000, 500, true);

-- ============================================================
-- 4. STREAKS (5 rachas)
-- ============================================================

INSERT INTO public.streaks (id, name, streak_type, description)
VALUES
  ('d0000001-0000-0000-0000-000000000001',
   'Racha de inicio de sesión',
   'login',
   'Días consecutivos iniciando sesión en la aplicación.'),

  ('d0000002-0000-0000-0000-000000000002',
   'Racha de aprendizaje',
   'lesson',
   'Días consecutivos completando al menos una lección.'),

  ('d0000003-0000-0000-0000-000000000003',
   'Racha de ahorro',
   'saving',
   'Días consecutivos registrando un movimiento de ahorro.'),

  ('d0000004-0000-0000-0000-000000000004',
   'Racha de presupuesto',
   'expense_tracking',
   'Semanas consecutivas registrando gastos y manteniendo el presupuesto.'),

  ('d0000005-0000-0000-0000-000000000005',
   'Racha de retos',
   'login',
   'Días consecutivos completando al menos un reto diario.');

-- ============================================================
-- 5. QUIZZES (5, uno por módulo)
-- ============================================================
-- Se asocia cada quiz a la primera lección de su módulo.
--   Lesson Ahorro:  b1000001
--   Lesson Presupuesto: b1000007
--   Lesson Deuda:  b1000012
--   Lesson Inversión: b1000017
--   Lesson Crédito: b1000021
-- ============================================================

INSERT INTO public.quizzes (id, lesson_id, title, description, passing_score, points_reward)
VALUES
  ('e0000001-0000-0000-0000-000000000001',
   'b1000001-0000-0000-0000-000000000001',
   'Evaluación: Conceptos de Ahorro',
   'Pon a prueba lo que aprendiste sobre ahorro y métodos de ahorro.',
   70, 30),

  ('e0000002-0000-0000-0000-000000000002',
   'b1000007-0000-0000-0000-000000000007',
   'Evaluación: Presupuesto y Control',
   'Demuestra tu comprensión sobre presupuestos y herramientas de control financiero.',
   70, 30),

  ('e0000003-0000-0000-0000-000000000003',
   'b1000012-0000-0000-0000-000000000012',
   'Evaluación: Manejo de Deudas',
   'Verifica tu conocimiento sobre tipos de deuda y estrategias de pago.',
   70, 30),

  ('e0000004-0000-0000-0000-000000000004',
   'b1000017-0000-0000-0000-000000000017',
   'Evaluación: Inversión y Crecimiento',
   'Evalúa lo que sabes sobre inversión, interés compuesto y portafolios.',
   70, 30),

  ('e0000005-0000-0000-0000-000000000005',
   'b1000021-0000-0000-0000-000000000021',
   'Evaluación: Crédito e Historial Crediticio',
   'Comprueba tu entendimiento sobre crédito, historial crediticio y score.',
   70, 30);

-- ============================================================
-- 6. QUIZ QUESTIONS (5 preguntas por quiz = 25 preguntas)
-- ============================================================

-- Quiz 1: Ahorro
INSERT INTO public.quiz_questions (id, quiz_id, question_text, question_type, points, order_index)
VALUES
  ('f0000001-0000-0000-0000-000000000001',
   'e0000001-0000-0000-0000-000000000001',
   '¿Cuál es la regla de presupuesto que recomienda destinar el 20% de los ingresos al ahorro?',
   'single_choice', 1, 1),
  ('f0000002-0000-0000-0000-000000000002',
   'e0000001-0000-0000-0000-000000000001',
   '¿Qué es un fondo de emergencia?',
   'single_choice', 1, 2),
  ('f0000003-0000-0000-0000-000000000003',
   'e0000001-0000-0000-0000-000000000001',
   'El método Kakebo consiste en:',
   'single_choice', 1, 3),
  ('f0000004-0000-0000-0000-000000000004',
   'e0000001-0000-0000-0000-000000000001',
   '¿Cuántos meses de gastos básicos recomiendan los expertos para un fondo de emergencia?',
   'single_choice', 1, 4),
  ('f0000005-0000-0000-0000-000000000005',
   'e0000001-0000-0000-0000-000000000001',
   '¿Qué significa "pagarse a uno mismo primero"?',
   'single_choice', 1, 5);

-- Quiz 2: Presupuesto
INSERT INTO public.quiz_questions (id, quiz_id, question_text, question_type, points, order_index)
VALUES
  ('f0000006-0000-0000-0000-000000000006',
   'e0000002-0000-0000-0000-000000000002',
   '¿Cuál es el propósito principal de un presupuesto?',
   'single_choice', 1, 1),
  ('f0000007-0000-0000-0000-000000000007',
   'e0000002-0000-0000-0000-000000000002',
   'En el presupuesto basado en cero, la fórmula es:',
   'single_choice', 1, 2),
  ('f0000008-0000-0000-0000-000000000008',
   'e0000002-0000-0000-0000-000000000002',
   '¿Cuál de los siguientes es un error común al hacer presupuestos?',
   'single_choice', 1, 3),
  ('f0000009-0000-0000-0000-000000000009',
   'e0000002-0000-0000-0000-000000000002',
   '¿Cuándo debes revisar tu presupuesto?',
   'single_choice', 1, 4),
  ('f0000010-0000-0000-0000-000000000010',
   'e0000002-0000-0000-0000-000000000002',
   '¿Qué herramienta digital es útil para controlar el presupuesto?',
   'single_choice', 1, 5);

-- Quiz 3: Deuda
INSERT INTO public.quiz_questions (id, quiz_id, question_text, question_type, points, order_index)
VALUES
  ('f0000011-0000-0000-0000-000000000011',
   'e0000003-0000-0000-0000-000000000003',
   '¿Cuál es un ejemplo de "deuda buena"?',
   'single_choice', 1, 1),
  ('f0000012-0000-0000-0000-000000000012',
   'e0000003-0000-0000-0000-000000000003',
   'En el método bola de nieve para pagar deudas, ¿cómo se ordenan las deudas?',
   'single_choice', 1, 2),
  ('f0000013-0000-0000-0000-000000000013',
   'e0000003-0000-0000-0000-000000000003',
   '¿Qué es la consolidación de deudas?',
   'single_choice', 1, 3),
  ('f0000014-0000-0000-0000-000000000014',
   'e0000003-0000-0000-0000-000000000003',
   '¿Cuál es la principal ventaja del método avalancha?',
   'single_choice', 1, 4),
  ('f0000015-0000-0000-0000-000000000015',
   'e0000003-0000-0000-0000-000000000003',
   '¿Qué debes hacer antes de negociar con un acreedor?',
   'single_choice', 1, 5);

-- Quiz 4: Inversión
INSERT INTO public.quiz_questions (id, quiz_id, question_text, question_type, points, order_index)
VALUES
  ('f0000016-0000-0000-0000-000000000016',
   'e0000004-0000-0000-0000-000000000004',
   '¿Qué es el interés compuesto?',
   'single_choice', 1, 1),
  ('f0000017-0000-0000-0000-000000000017',
   'e0000004-0000-0000-0000-000000000004',
   'Según la regla del 72, si inviertes al 8% anual, ¿en cuántos años se duplica tu dinero?',
   'single_choice', 1, 2),
  ('f0000018-0000-0000-0000-000000000018',
   'e0000004-0000-0000-0000-000000000004',
   '¿Qué es un CDT?',
   'single_choice', 1, 3),
  ('f0000019-0000-0000-0000-000000000019',
   'e0000004-0000-0000-0000-000000000004',
   'La diversificación en inversiones significa:',
   'single_choice', 1, 4),
  ('f0000020-0000-0000-0000-000000000020',
   'e0000004-0000-0000-0000-000000000004',
   '¿Cuál de estos NO es un factor para determinar tu perfil de inversión?',
   'single_choice', 1, 5);

-- Quiz 5: Crédito
INSERT INTO public.quiz_questions (id, quiz_id, question_text, question_type, points, order_index)
VALUES
  ('f0000021-0000-0000-0000-000000000021',
   'e0000005-0000-0000-0000-000000000005',
   '¿Qué porcentaje del cupo de tu tarjeta de crédito se recomienda no superar?',
   'single_choice', 1, 1),
  ('f0000022-0000-0000-0000-000000000022',
   'e0000005-0000-0000-0000-000000000005',
   '¿Qué entidad administra las centrales de riesgo en Colombia?',
   'single_choice', 1, 2),
  ('f0000023-0000-0000-0000-000000000023',
   'e0000005-0000-0000-0000-000000000005',
   '¿Cuál es la principal diferencia entre un préstamo personal y una línea de crédito?',
   'single_choice', 1, 3),
  ('f0000024-0000-0000-0000-000000000024',
   'e0000005-0000-0000-0000-000000000005',
   '¿Qué factor tiene más peso en tu score crediticio?',
   'single_choice', 1, 4),
  ('f0000025-0000-0000-0000-000000000025',
   'e0000005-0000-0000-0000-000000000005',
   '¿Qué es el período de gracia en una tarjeta de crédito?',
   'single_choice', 1, 5);

-- ============================================================
-- 7. QUIZ ANSWERS (4 respuestas por pregunta = 100 respuestas)
-- ============================================================

-- Quiz 1: Ahorro (preguntas f0000001 a f0000005)
INSERT INTO public.quiz_answers (id, question_id, answer_text, is_correct)
VALUES
  ('ff000001-0000-0000-0000-000000000001', 'f0000001-0000-0000-0000-000000000001', 'Regla 50/30/20', true),
  ('ff000002-0000-0000-0000-000000000002', 'f0000001-0000-0000-0000-000000000001', 'Regla 70/20/10', false),
  ('ff000003-0000-0000-0000-000000000003', 'f0000001-0000-0000-0000-000000000001', 'Regla 60/20/20', false),
  ('ff000004-0000-0000-0000-000000000004', 'f0000001-0000-0000-0000-000000000001', 'Regla 40/30/30', false),

  ('ff000005-0000-0000-0000-000000000005', 'f0000002-0000-0000-0000-000000000002', 'Dinero reservado para situaciones inesperadas', true),
  ('ff000006-0000-0000-0000-000000000006', 'f0000002-0000-0000-0000-000000000002', 'Una cuenta para gastos de vacaciones', false),
  ('ff000007-0000-0000-0000-000000000007', 'f0000002-0000-0000-0000-000000000002', 'Un préstamo bancario para emergencias', false),
  ('ff000008-0000-0000-0000-000000000008', 'f0000002-0000-0000-0000-000000000002', 'Una tarjeta de crédito con cupo extra', false),

  ('ff000009-0000-0000-0000-000000000009', 'f0000003-0000-0000-0000-000000000003', 'Llevar un diario de gastos diario', true),
  ('ff00000a-0000-0000-0000-00000000000a', 'f0000003-0000-0000-0000-000000000003', 'Usar sobres de efectivo para cada categoría', false),
  ('ff00000b-0000-0000-0000-00000000000b', 'f0000003-0000-0000-0000-000000000003', 'Automatizar el ahorro cada mes', false),
  ('ff00000c-0000-0000-0000-00000000000c', 'f0000003-0000-0000-0000-000000000003', 'Dividir ingresos en tres categorías', false),

  ('ff00000d-0000-0000-0000-00000000000d', 'f0000004-0000-0000-0000-000000000004', 'Entre 3 y 6 meses', true),
  ('ff00000e-0000-0000-0000-00000000000e', 'f0000004-0000-0000-0000-000000000004', 'Entre 1 y 2 meses', false),
  ('ff00000f-0000-0000-0000-00000000000f', 'f0000004-0000-0000-0000-000000000004', 'Entre 6 y 12 meses', false),
  ('ff000010-0000-0000-0000-000000000010', 'f0000004-0000-0000-0000-000000000004', 'Entre 12 y 24 meses', false),

  ('ff000011-0000-0000-0000-000000000011', 'f0000005-0000-0000-0000-000000000005', 'Ahorrar automáticamente al recibir ingresos', true),
  ('ff000012-0000-0000-0000-000000000012', 'f0000005-0000-0000-0000-000000000005', 'Pagarte un salario a ti mismo como dueño', false),
  ('ff000013-0000-0000-0000-000000000013', 'f0000005-0000-0000-0000-000000000005', 'Ser el primero en pagar tus deudas', false),
  ('ff000014-0000-0000-0000-000000000014', 'f0000005-0000-0000-0000-000000000005', 'Invertir antes de gastar en necesidades', false);

-- Quiz 2: Presupuesto (preguntas f0000006 a f0000010)
INSERT INTO public.quiz_answers (id, question_id, answer_text, is_correct)
VALUES
  ('ff000015-0000-0000-0000-000000000015', 'f0000006-0000-0000-0000-000000000006', 'Planificar y controlar ingresos y gastos', true),
  ('ff000016-0000-0000-0000-000000000016', 'f0000006-0000-0000-0000-000000000006', 'Gastar todo el dinero disponible', false),
  ('ff000017-0000-0000-0000-000000000017', 'f0000006-0000-0000-0000-000000000006', 'Reducir impuestos', false),
  ('ff000018-0000-0000-0000-000000000018', 'f0000006-0000-0000-0000-000000000006', 'Solicitar préstamos', false),

  ('ff000019-0000-0000-0000-000000000019', 'f0000007-0000-0000-0000-000000000007', 'Ingresos - Gastos = 0 (todo asignado)', true),
  ('ff00001a-0000-0000-0000-00000000001a', 'f0000007-0000-0000-0000-000000000007', 'Ingresos - Gastos = Ahorro', false),
  ('ff00001b-0000-0000-0000-00000000001b', 'f0000007-0000-0000-0000-000000000007', 'Gastos = Ingresos × 0.8', false),
  ('ff00001c-0000-0000-0000-00000000001c', 'f0000007-0000-0000-0000-000000000007', 'Ingresos = Gastos + Deudas', false),

  ('ff00001d-0000-0000-0000-00000000001d', 'f0000008-0000-0000-0000-000000000008', 'Ser demasiado restrictivo', true),
  ('ff00001e-0000-0000-0000-00000000001e', 'f0000008-0000-0000-0000-000000000008', 'Incluir una categoría de ocio', false),
  ('ff00001f-0000-0000-0000-00000000001f', 'f0000008-0000-0000-0000-000000000008', 'Revisar el presupuesto semanalmente', false),
  ('ff000020-0000-0000-0000-000000000020', 'f0000008-0000-0000-0000-000000000008', 'Involucrar a la familia en el presupuesto', false),

  ('ff000021-0000-0000-0000-000000000021', 'f0000009-0000-0000-0000-000000000009', 'Semanalmente y ajustar mensualmente', true),
  ('ff000022-0000-0000-0000-000000000022', 'f0000009-0000-0000-0000-000000000009', 'Solo al final del año', false),
  ('ff000023-0000-0000-0000-000000000023', 'f0000009-0000-0000-0000-000000000009', 'Nunca, se hace una sola vez', false),
  ('ff000024-0000-0000-0000-000000000024', 'f0000009-0000-0000-0000-000000000009', 'Solo cuando hay problemas financieros', false),

  ('ff000025-0000-0000-0000-000000000025', 'f0000010-0000-0000-0000-000000000010', 'Google Sheets o Excel', true),
  ('ff000026-0000-0000-0000-000000000026', 'f0000010-0000-0000-0000-000000000010', 'Una libreta física', false),
  ('ff000027-0000-0000-0000-000000000027', 'f0000010-0000-0000-0000-000000000010', 'WhatsApp', false),
  ('ff000028-0000-0000-0000-000000000028', 'f0000010-0000-0000-0000-000000000010', 'Instagram', false);

-- Quiz 3: Deuda (preguntas f0000011 a f0000015)
INSERT INTO public.quiz_answers (id, question_id, answer_text, is_correct)
VALUES
  ('ff000029-0000-0000-0000-000000000029', 'f0000011-0000-0000-0000-000000000011', 'Un crédito hipotecario para comprar vivienda', true),
  ('ff00002a-0000-0000-0000-00000000002a', 'f0000011-0000-0000-0000-000000000011', 'Una tarjeta de crédito para ropa', false),
  ('ff00002b-0000-0000-0000-00000000002b', 'f0000011-0000-0000-0000-000000000011', 'Un préstamo para un viaje', false),
  ('ff00002c-0000-0000-0000-00000000002c', 'f0000011-0000-0000-0000-000000000011', 'Un crédito de consumo para electrodomésticos', false),

  ('ff00002d-0000-0000-0000-00000000002d', 'f0000012-0000-0000-0000-000000000012', 'De menor a mayor saldo', true),
  ('ff00002e-0000-0000-0000-00000000002e', 'f0000012-0000-0000-0000-000000000012', 'De mayor a menor saldo', false),
  ('ff00002f-0000-0000-0000-00000000002f', 'f0000012-0000-0000-0000-000000000012', 'De mayor a menor tasa de interés', false),
  ('ff000030-0000-0000-0000-000000000030', 'f0000012-0000-0000-0000-000000000012', 'De menor a mayor tasa de interés', false),

  ('ff000031-0000-0000-0000-000000000031', 'f0000013-0000-0000-0000-000000000013', 'Agrupar varias deudas en un solo préstamo', true),
  ('ff000032-0000-0000-0000-000000000032', 'f0000013-0000-0000-0000-000000000013', 'Cancelar todas las deudas de una vez', false),
  ('ff000033-0000-0000-0000-000000000033', 'f0000013-0000-0000-0000-000000000013', 'Solicitar un nuevo préstamo para gastar', false),
  ('ff000034-0000-0000-0000-000000000034', 'f0000013-0000-0000-0000-000000000013', 'Ignorar las deudas pequeñas', false),

  ('ff000035-0000-0000-0000-000000000035', 'f0000014-0000-0000-0000-000000000014', 'Ahorra más dinero en intereses a largo plazo', true),
  ('ff000036-0000-0000-0000-000000000036', 'f0000014-0000-0000-0000-000000000014', 'Es más motivante porque se pagan deudas rápido', false),
  ('ff000037-0000-0000-0000-000000000037', 'f0000014-0000-0000-0000-000000000014', 'Reduce el número total de deudas más rápido', false),
  ('ff000038-0000-0000-0000-000000000038', 'f0000014-0000-0000-0000-000000000014', 'No requiere calcular tasas de interés', false),

  ('ff000039-0000-0000-0000-000000000039', 'f0000015-0000-0000-0000-000000000015', 'Tener claros tus números y tu capacidad de pago', true),
  ('ff00003a-0000-0000-0000-00000000003a', 'f0000015-0000-0000-0000-000000000015', 'Contratar un abogado', false),
  ('ff00003b-0000-0000-0000-00000000003b', 'f0000015-0000-0000-0000-000000000015', 'Solicitar otro préstamo para pagar', false),
  ('ff00003c-0000-0000-0000-00000000003c', 'f0000015-0000-0000-0000-000000000015', 'Esperar a que la deuda prescriba', false);

-- Quiz 4: Inversión (preguntas f0000016 a f0000020)
INSERT INTO public.quiz_answers (id, question_id, answer_text, is_correct)
VALUES
  ('ff00003d-0000-0000-0000-00000000003d', 'f0000016-0000-0000-0000-000000000016', 'Interés que se genera sobre los intereses acumulados', true),
  ('ff00003e-0000-0000-0000-00000000003e', 'f0000016-0000-0000-0000-000000000016', 'Interés que se paga solo sobre el capital inicial', false),
  ('ff00003f-0000-0000-0000-00000000003f', 'f0000016-0000-0000-0000-000000000016', 'Un tipo de interés fijo mensual', false),
  ('ff000040-0000-0000-0000-000000000040', 'f0000016-0000-0000-0000-000000000016', 'El interés que cobran los bancos centrales', false),

  ('ff000041-0000-0000-0000-000000000041', 'f0000017-0000-0000-0000-000000000017', '9 años', true),
  ('ff000042-0000-0000-0000-000000000042', 'f0000017-0000-0000-0000-000000000017', '6 años', false),
  ('ff000043-0000-0000-0000-000000000043', 'f0000017-0000-0000-0000-000000000017', '12 años', false),
  ('ff000044-0000-0000-0000-000000000044', 'f0000017-0000-0000-0000-000000000017', '8 años', false),

  ('ff000045-0000-0000-0000-000000000045', 'f0000018-0000-0000-0000-000000000018', 'Un certificado de depósito a término emitido por un banco', true),
  ('ff000046-0000-0000-0000-000000000046', 'f0000018-0000-0000-0000-000000000018', 'Un fondo de inversión en la bolsa', false),
  ('ff000047-0000-0000-0000-000000000047', 'f0000018-0000-0000-0000-000000000018', 'Un seguro de vida con ahorro', false),
  ('ff000048-0000-0000-0000-000000000048', 'f0000018-0000-0000-0000-000000000018', 'Una cuenta de ahorros tradicional', false),

  ('ff000049-0000-0000-0000-000000000049', 'f0000019-0000-0000-0000-000000000019', 'Distribuir el dinero entre diferentes tipos de activos', true),
  ('ff00004a-0000-0000-0000-00000000004a', 'f0000019-0000-0000-0000-000000000019', 'Invertir todo en un solo activo de alto rendimiento', false),
  ('ff00004b-0000-0000-0000-00000000004b', 'f0000019-0000-0000-0000-000000000019', 'Comprar acciones de una sola empresa', false),
  ('ff00004c-0000-0000-0000-00000000004c', 'f0000019-0000-0000-0000-000000000019', 'Mantener todo el dinero en efectivo', false),

  ('ff00004d-0000-0000-0000-00000000004d', 'f0000020-0000-0000-0000-000000000020', 'Tu color favorito', true),
  ('ff00004e-0000-0000-0000-00000000004e', 'f0000020-0000-0000-0000-000000000020', 'Tu horizonte temporal', false),
  ('ff00004f-0000-0000-0000-00000000004f', 'f0000020-0000-0000-0000-000000000020', 'Tu tolerancia al riesgo', false),
  ('ff000050-0000-0000-0000-000000000050', 'f0000020-0000-0000-0000-000000000020', 'Tus metas financieras', false);

-- Quiz 5: Crédito (preguntas f0000021 a f0000025)
INSERT INTO public.quiz_answers (id, question_id, answer_text, is_correct)
VALUES
  ('ff000051-0000-0000-0000-000000000051', 'f0000021-0000-0000-0000-000000000021', '30%', true),
  ('ff000052-0000-0000-0000-000000000052', 'f0000021-0000-0000-0000-000000000021', '50%', false),
  ('ff000053-0000-0000-0000-000000000053', 'f0000021-0000-0000-0000-000000000021', '70%', false),
  ('ff000054-0000-0000-0000-000000000054', 'f0000021-0000-0000-0000-000000000021', '100%', false),

  ('ff000055-0000-0000-0000-000000000055', 'f0000022-0000-0000-0000-000000000022', 'Datacrédito (Experian) y Cifin', true),
  ('ff000056-0000-0000-0000-000000000056', 'f0000022-0000-0000-0000-000000000022', 'El Banco de la República', false),
  ('ff000057-0000-0000-0000-000000000057', 'f0000022-0000-0000-0000-000000000022', 'La Superintendencia Financiera', false),
  ('ff000058-0000-0000-0000-000000000058', 'f0000022-0000-0000-0000-000000000022', 'El Ministerio de Hacienda', false),

  ('ff000059-0000-0000-0000-000000000059', 'f0000023-0000-0000-0000-000000000023', 'El préstamo da una cantidad fija; la línea es un cupo renovable', true),
  ('ff00005a-0000-0000-0000-00000000005a', 'f0000023-0000-0000-0000-000000000023', 'El préstamo no cobra intereses; la línea sí', false),
  ('ff00005b-0000-0000-0000-00000000005b', 'f0000023-0000-0000-0000-000000000023', 'La línea de crédito tiene plazo fijo; el préstamo no', false),
  ('ff00005c-0000-0000-0000-00000000005c', 'f0000023-0000-0000-0000-000000000023', 'No hay diferencias significativas', false),

  ('ff00005d-0000-0000-0000-00000000005d', 'f0000024-0000-0000-0000-000000000024', 'Historial de pagos (35%)', true),
  ('ff00005e-0000-0000-0000-00000000005e', 'f0000024-0000-0000-0000-000000000024', 'Nivel de endeudamiento (30%)', false),
  ('ff00005f-0000-0000-0000-00000000005f', 'f0000024-0000-0000-0000-000000000024', 'Antigüedad del historial (15%)', false),
  ('ff000060-0000-0000-0000-000000000060', 'f0000024-0000-0000-0000-000000000024', 'Tipos de crédito (10%)', false),

  ('ff000061-0000-0000-0000-000000000061', 'f0000025-0000-0000-0000-000000000025', 'El tiempo entre la compra y el pago sin intereses', true),
  ('ff000062-0000-0000-0000-000000000062', 'f0000025-0000-0000-0000-000000000025', 'El período para pagar el mínimo sin recargos', false),
  ('ff000063-0000-0000-0000-000000000063', 'f0000025-0000-0000-0000-000000000025', 'Los días de descuento por pago anticipado', false),
  ('ff000064-0000-0000-0000-000000000064', 'f0000025-0000-0000-0000-000000000025', 'El plazo para usar la tarjeta sin activarla', false);
