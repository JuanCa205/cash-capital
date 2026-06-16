# Cash Capital — Documentación de Base de Datos

**App:** Educación Financiera Gamificada
**Motor:** PostgreSQL 15 (vía Supabase autoalojado)
**Total:** 41 tablas · 24 tipos ENUM · 1 trigger

---

## Convenciones

| Concepto | Estándar |
|---|---|
| IDs | `UUID DEFAULT gen_random_uuid()` |
| Timestamps | `TIMESTAMPTZ` |
| Enums | `CREATE TYPE ... AS ENUM` |
| updated_at | Trigger `update_updated_at_column()` |
| Tabla auth | `auth.users` de Supabase |

---

## Tipos ENUM

### Módulo Perfil
| Tipo | Valores |
|---|---|
| `user_status` | `active`, `inactive`, `blocked` |
| `goal_type` | `save`, `reduce_expenses`, `pay_debt`, `learn`, `invest` |
| `goal_status` | `active`, `completed`, `cancelled` |
| `user_theme` | `light`, `dark`, `system` |

### Módulo Aprender
| Tipo | Valores |
|---|---|
| `difficulty` | `basic`, `intermediate`, `advanced` |
| `lesson_status` | `not_started`, `in_progress`, `completed` |
| `question_type` | `single_choice`, `multiple_choice`, `true_false` |
| `resource_type` | `article`, `video`, `pdf`, `link` |
| `simulator_type` | `savings`, `debt`, `compound_interest`, `budget`, `investment` |

### Módulo Mis Finanzas
| Tipo | Valores |
|---|---|
| `recurrence_type` | `daily`, `weekly`, `monthly`, `yearly` |
| `payment_method` | `cash`, `debit_card`, `credit_card`, `transfer`, `other` |
| `movement_type` | `deposit`, `withdrawal` |
| `debt_type` | `credit_card`, `loan`, `personal`, `other` |
| `debt_status` | `active`, `paid`, `cancelled` |
| `report_type` | `monthly_summary`, `expense_analysis`, `budget_performance`, `debt_status`, `saving_progress` |

### Módulo Retos
| Tipo | Valores |
|---|---|
| `badge_rarity` | `common`, `rare`, `epic`, `legendary` |
| `challenge_type` | `daily`, `weekly`, `special` |
| `objective_type` | `complete_lesson`, `complete_quiz`, `register_expense`, `create_budget`, `save_money`, `pay_debt`, `login_streak` |
| `mission_type` | `learning`, `finance`, `habit`, `mixed` |
| `achievement_type` | `learning`, `finance`, `challenge`, `streak` |
| `streak_type` | `login`, `lesson`, `saving`, `expense_tracking` |
| `points_source` | `lesson`, `quiz`, `challenge`, `mission`, `achievement`, `streak`, `manual` |

### Módulo Inicio
| Tipo | Valores |
|---|---|
| `tip_category` | `saving`, `budget`, `debt`, `investment`, `habit`, `general` |
| `activity_type` | `login`, `lesson_completed`, `quiz_completed`, `income_added`, `expense_added`, `budget_created`, `saving_goal_created`, `saving_deposit`, `debt_payment`, `challenge_completed`, `badge_earned`, `achievement_unlocked` |

---

## Trigger

```sql
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';
```

Aplicado en: `user_profiles`

---

## Tablas — Fase 1: Perfil

### user_levels
Niveles de progresión del usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| name | VARCHAR(100) | NOT NULL |
| level_number | INT | NOT NULL, UNIQUE |
| min_points | INT | NOT NULL |
| max_points | INT | NOT NULL |
| description | TEXT | |

Seed: 10 niveles (Novato → Legendario)

### avatars
Avatares desbloqueables por nivel.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| name | VARCHAR(100) | NOT NULL |
| image_url | VARCHAR(255) | NOT NULL |
| required_level | INT | DEFAULT 1 |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Seed: 10 avatares (Pollo → Unicornio)

### user_profiles
Datos personales del usuario. FK a auth.users.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, UNIQUE, FK → auth.users(id) |
| first_name | VARCHAR(100) | |
| last_name | VARCHAR(100) | |
| birth_date | DATE | |
| phone | VARCHAR(30) | |
| country | VARCHAR(80) | |
| city | VARCHAR(80) | |
| avatar_id | UUID | FK → avatars(id) |
| current_level_id | UUID | FK → user_levels(id) |
| total_points | INT | DEFAULT 0 |
| financial_score | INT | DEFAULT 0 |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |
| updated_at | TIMESTAMPTZ | DEFAULT NOW(), trigger ON UPDATE |

### user_settings
Preferencias de configuración por usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, UNIQUE, FK → auth.users(id) |
| notifications_enabled | BOOLEAN | DEFAULT TRUE |
| daily_tip_enabled | BOOLEAN | DEFAULT TRUE |
| challenge_reminders | BOOLEAN | DEFAULT TRUE |
| currency | VARCHAR(10) | DEFAULT 'COP' |
| language | VARCHAR(10) | DEFAULT 'es' |
| theme | user_theme | DEFAULT 'system' |

### financial_goals
Metas financieras personales del usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| title | VARCHAR(150) | NOT NULL |
| description | TEXT | |
| goal_type | goal_type | NOT NULL |
| target_amount | DECIMAL(12,2) | |
| current_amount | DECIMAL(12,2) | DEFAULT 0 |
| target_date | DATE | |
| status | goal_status | DEFAULT 'active' |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

---

## Tablas — Fase 2: Aprender

### educational_modules
Módulos educativos (ahorro, presupuesto, deuda, etc.).

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| title | VARCHAR(150) | NOT NULL |
| description | TEXT | |
| difficulty | difficulty | DEFAULT 'basic' |
| order_index | INT | DEFAULT 0 |
| icon_url | VARCHAR(255) | |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Seed: 5 módulos. Índices: none

### lessons
Lecciones dentro de cada módulo.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| module_id | UUID | NOT NULL, FK → educational_modules(id) |
| title | VARCHAR(150) | NOT NULL |
| summary | TEXT | |
| content | TEXT | NOT NULL |
| estimated_minutes | INT | DEFAULT 5 |
| order_index | INT | DEFAULT 0 |
| points_reward | INT | DEFAULT 10 |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_lessons_module(module_id)`

### lesson_progress
Progreso de aprendizaje por usuario y lección.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| lesson_id | UUID | NOT NULL, FK → lessons(id) |
| status | lesson_status | DEFAULT 'not_started' |
| progress_percentage | DECIMAL(5,2) | DEFAULT 0 |
| started_at | TIMESTAMPTZ | |
| completed_at | TIMESTAMPTZ | |
| UNIQUE | (user_id, lesson_id) | |

Índices: `idx_lesson_progress_user(user_id)`

### quizzes
Cuestionarios asociados a lecciones.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| lesson_id | UUID | NOT NULL, FK → lessons(id) |
| title | VARCHAR(150) | NOT NULL |
| description | TEXT | |
| passing_score | DECIMAL(5,2) | DEFAULT 70 |
| points_reward | INT | DEFAULT 20 |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_quizzes_lesson(lesson_id)`

### quiz_questions
Preguntas dentro de un quiz.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| quiz_id | UUID | NOT NULL, FK → quizzes(id) |
| question_text | TEXT | NOT NULL |
| question_type | question_type | DEFAULT 'single_choice' |
| points | INT | DEFAULT 1 |
| order_index | INT | DEFAULT 0 |

Índices: `idx_quiz_questions_quiz(quiz_id)`

### quiz_answers
Opciones de respuesta para cada pregunta.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| question_id | UUID | NOT NULL, FK → quiz_questions(id) |
| answer_text | TEXT | NOT NULL |
| is_correct | BOOLEAN | DEFAULT FALSE |

Índices: `idx_quiz_answers_question(question_id)`

### user_quiz_attempts
Intentos de usuario en un quiz.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| quiz_id | UUID | NOT NULL, FK → quizzes(id) |
| score | DECIMAL(5,2) | DEFAULT 0 |
| passed | BOOLEAN | DEFAULT FALSE |
| started_at | TIMESTAMPTZ | DEFAULT NOW() |
| completed_at | TIMESTAMPTZ | |

Índices: `idx_quiz_attempts_user(user_id)`, `idx_quiz_attempts_quiz(quiz_id)`

### user_quiz_responses
Respuestas individuales del usuario en un intento.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| attempt_id | UUID | NOT NULL, FK → user_quiz_attempts(id) |
| question_id | UUID | NOT NULL, FK → quiz_questions(id) |
| answer_id | UUID | NOT NULL, FK → quiz_answers(id) |
| is_correct | BOOLEAN | DEFAULT FALSE |

Índices: `idx_quiz_responses_attempt(attempt_id)`

### financial_library_items
Biblioteca de recursos financieros.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| title | VARCHAR(150) | NOT NULL |
| content | TEXT | |
| resource_type | resource_type | DEFAULT 'article' |
| url | VARCHAR(255) | |
| category | VARCHAR(100) | |
| difficulty | difficulty | DEFAULT 'basic' |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

### simulators
Simuladores financieros interactivos.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| name | VARCHAR(150) | NOT NULL |
| description | TEXT | |
| simulator_type | simulator_type | NOT NULL |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

### simulator_attempts
Intentos del usuario en simuladores.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| simulator_id | UUID | NOT NULL, FK → simulators(id) |
| input_data | JSONB | |
| result_data | JSONB | |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_sim_attempts_user(user_id)`

---

## Tablas — Fase 3: Mis Finanzas

### income_categories
Categorías de ingresos.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| name | VARCHAR(100) | NOT NULL |
| icon | VARCHAR(100) | |
| color | VARCHAR(20) | |
| is_default | BOOLEAN | DEFAULT FALSE |

Seed: 10 categorías

### expense_categories
Categorías de gastos.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| name | VARCHAR(100) | NOT NULL |
| icon | VARCHAR(100) | |
| color | VARCHAR(20) | |
| is_default | BOOLEAN | DEFAULT FALSE |

Seed: 16 categorías

### incomes
Registro de ingresos del usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| category_id | UUID | NOT NULL, FK → income_categories(id) |
| amount | DECIMAL(12,2) | NOT NULL |
| description | VARCHAR(255) | |
| income_date | DATE | NOT NULL |
| is_recurring | BOOLEAN | DEFAULT FALSE |
| recurrence_type | recurrence_type | |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_incomes_user(user_id)`, `idx_incomes_date(income_date)`

### expenses
Registro de gastos del usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| category_id | UUID | NOT NULL, FK → expense_categories(id) |
| amount | DECIMAL(12,2) | NOT NULL |
| description | VARCHAR(255) | |
| expense_date | DATE | NOT NULL |
| payment_method | payment_method | DEFAULT 'cash' |
| is_recurring | BOOLEAN | DEFAULT FALSE |
| recurrence_type | recurrence_type | |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_expenses_user(user_id)`, `idx_expenses_date(expense_date)`

### budgets
Presupuestos por período del usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| name | VARCHAR(150) | NOT NULL |
| period_type | recurrence_type | DEFAULT 'monthly' |
| start_date | DATE | NOT NULL |
| end_date | DATE | NOT NULL |
| total_amount | DECIMAL(12,2) | NOT NULL |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_budgets_user(user_id)`

### budget_items
Asignación de presupuesto por categoría de gasto.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| budget_id | UUID | NOT NULL, FK → budgets(id) |
| expense_category_id | UUID | NOT NULL, FK → expense_categories(id) |
| planned_amount | DECIMAL(12,2) | NOT NULL |
| alert_percentage | DECIMAL(5,2) | DEFAULT 80 |
| UNIQUE | (budget_id, expense_category_id) | |

Índices: `idx_budget_items_budget(budget_id)`

### savings_goals
Metas de ahorro del usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| name | VARCHAR(150) | NOT NULL |
| target_amount | DECIMAL(12,2) | NOT NULL |
| current_amount | DECIMAL(12,2) | DEFAULT 0 |
| target_date | DATE | |
| status | goal_status | DEFAULT 'active' |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_savings_goals_user(user_id)`

### savings_movements
Movimientos (depósitos/retiros) de una meta de ahorro.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| savings_goal_id | UUID | NOT NULL, FK → savings_goals(id) |
| movement_type | movement_type | NOT NULL |
| amount | DECIMAL(12,2) | NOT NULL |
| description | VARCHAR(255) | |
| movement_date | DATE | NOT NULL |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_savings_movements_goal(savings_goal_id)`

### debts
Registro de deudas del usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| name | VARCHAR(150) | NOT NULL |
| original_amount | DECIMAL(12,2) | NOT NULL |
| current_balance | DECIMAL(12,2) | NOT NULL |
| interest_rate | DECIMAL(5,2) | DEFAULT 0 |
| minimum_payment | DECIMAL(12,2) | |
| due_day | INT | |
| debt_type | debt_type | DEFAULT 'other' |
| status | debt_status | DEFAULT 'active' |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_debts_user(user_id)`

### debt_payments
Pagos realizados a una deuda.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| debt_id | UUID | NOT NULL, FK → debts(id) |
| amount | DECIMAL(12,2) | NOT NULL |
| payment_date | DATE | NOT NULL |
| notes | VARCHAR(255) | |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_debt_payments_debt(debt_id)`

### financial_reports
Reportes financieros generados (histórico JSON).

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| report_type | report_type | NOT NULL |
| period_start | DATE | NOT NULL |
| period_end | DATE | NOT NULL |
| report_data | JSONB | |
| generated_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_financial_reports_user(user_id)`

---

## Tablas — Fase 4: Retos + Inicio

### badges
Insignias por rareza.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| name | VARCHAR(100) | NOT NULL |
| description | TEXT | |
| image_url | VARCHAR(255) | |
| rarity | badge_rarity | DEFAULT 'common' |
| is_active | BOOLEAN | DEFAULT TRUE |

Seed: 14 insignias

### challenges
Retos diarios, semanales o especiales.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| title | VARCHAR(150) | NOT NULL |
| description | TEXT | |
| challenge_type | challenge_type | NOT NULL |
| objective_type | objective_type | NOT NULL |
| target_value | DECIMAL(12,2) | DEFAULT 1 |
| points_reward | INT | DEFAULT 0 |
| badge_reward_id | UUID | FK → badges(id) |
| start_date | DATE | |
| end_date | DATE | |
| is_active | BOOLEAN | DEFAULT TRUE |

Índices: `idx_challenges_active(is_active)`

### user_challenges
Progreso del usuario en retos.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| challenge_id | UUID | NOT NULL, FK → challenges(id) |
| status | goal_status | DEFAULT 'active' |
| progress_value | DECIMAL(12,2) | DEFAULT 0 |
| accepted_at | TIMESTAMPTZ | DEFAULT NOW() |
| completed_at | TIMESTAMPTZ | |
| UNIQUE | (user_id, challenge_id) | |

Índices: `idx_user_challenges_user(user_id)`

### missions
Misiones compuestas por múltiples retos.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| title | VARCHAR(150) | NOT NULL |
| description | TEXT | |
| mission_type | mission_type | DEFAULT 'mixed' |
| points_reward | INT | DEFAULT 0 |
| badge_reward_id | UUID | FK → badges(id) |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

### mission_challenges
Relación muchos a muchos entre misiones y retos.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| mission_id | UUID | NOT NULL, FK → missions(id) |
| challenge_id | UUID | NOT NULL, FK → challenges(id) |
| UNIQUE | (mission_id, challenge_id) | |

### user_missions
Progreso del usuario en misiones.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| mission_id | UUID | NOT NULL, FK → missions(id) |
| status | goal_status | DEFAULT 'active' |
| progress_percentage | DECIMAL(5,2) | DEFAULT 0 |
| started_at | TIMESTAMPTZ | DEFAULT NOW() |
| completed_at | TIMESTAMPTZ | |
| UNIQUE | (user_id, mission_id) | |

Índices: `idx_user_missions_user(user_id)`

### achievements
Logros automáticos del sistema.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| title | VARCHAR(150) | NOT NULL |
| description | TEXT | |
| achievement_type | achievement_type | NOT NULL |
| condition_type | VARCHAR(100) | NOT NULL |
| condition_value | DECIMAL(12,2) | NOT NULL |
| points_reward | INT | DEFAULT 0 |
| is_active | BOOLEAN | DEFAULT TRUE |

### user_achievements
Logros desbloqueados por usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| achievement_id | UUID | NOT NULL, FK → achievements(id) |
| unlocked_at | TIMESTAMPTZ | DEFAULT NOW() |
| UNIQUE | (user_id, achievement_id) | |

Índices: `idx_user_achievements_user(user_id)`

### streaks
Tipos de rachas disponibles.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| name | VARCHAR(100) | NOT NULL |
| streak_type | streak_type | NOT NULL |
| description | TEXT | |

### user_streaks
Estado de rachas por usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| streak_id | UUID | NOT NULL, FK → streaks(id) |
| current_count | INT | DEFAULT 0 |
| best_count | INT | DEFAULT 0 |
| last_activity_date | DATE | |
| UNIQUE | (user_id, streak_id) | |

Índices: `idx_user_streaks_user(user_id)`

### user_points_history
Historial de puntos ganados/gastados por usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| source_type | points_source | NOT NULL |
| source_id | UUID | |
| points | INT | NOT NULL |
| description | VARCHAR(255) | |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_points_history_user(user_id)`

### daily_tips
Consejos financieros diarios.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| title | VARCHAR(150) | NOT NULL |
| content | TEXT | NOT NULL |
| category | tip_category | DEFAULT 'general' |
| difficulty | difficulty | DEFAULT 'basic' |
| is_active | BOOLEAN | DEFAULT TRUE |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Seed: 16 consejos

### user_daily_tips
Registro de consejos vistos por usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| daily_tip_id | UUID | NOT NULL, FK → daily_tips(id) |
| shown_date | DATE | NOT NULL |
| was_read | BOOLEAN | DEFAULT FALSE |
| UNIQUE | (user_id, daily_tip_id, shown_date) | |

Índices: `idx_user_daily_tips_user(user_id)`

### activity_logs
Registro de actividad reciente del usuario.

| Columna | Tipo | Restricciones |
|---|---|---|
| id | UUID | PK, DEFAULT gen_random_uuid() |
| user_id | UUID | NOT NULL, FK → auth.users(id) |
| activity_type | activity_type | NOT NULL |
| entity_type | VARCHAR(100) | |
| entity_id | UUID | |
| description | VARCHAR(255) | |
| created_at | TIMESTAMPTZ | DEFAULT NOW() |

Índices: `idx_activity_logs_user(user_id)`, `idx_activity_logs_created(created_at)`

---

## Resumen de Relaciones (FKs)

### Por módulo

**Perfil** (5 tablas)
```
auth.users → user_profiles (1:1)
auth.users → user_settings (1:1)
auth.users → financial_goals (1:N)
user_profiles → avatars (N:1)
user_profiles → user_levels (N:1)
```

**Aprender** (11 tablas)
```
educational_modules → lessons (1:N)
lessons → lesson_progress (1:N)
lessons → quizzes (1:N)
quizzes → quiz_questions (1:N)
quiz_questions → quiz_answers (1:N)
auth.users → lesson_progress (1:N)
auth.users → user_quiz_attempts (1:N)
user_quiz_attempts → user_quiz_responses (1:N)
auth.users → simulator_attempts (1:N)
simulators → simulator_attempts (1:N)
```

**Mis Finanzas** (11 tablas)
```
auth.users → incomes (1:N)
auth.users → expenses (1:N)
auth.users → budgets (1:N)
auth.users → savings_goals (1:N)
auth.users → debts (1:N)
auth.users → financial_reports (1:N)
income_categories → incomes (1:N)
expense_categories → expenses (1:N)
expense_categories → budget_items (1:N)
budgets → budget_items (1:N)
savings_goals → savings_movements (1:N)
debts → debt_payments (1:N)
```

**Retos + Inicio** (14 tablas)
```
badges → challenges (1:N, badge_reward_id)
badges → missions (1:N, badge_reward_id)
auth.users → user_challenges (1:N)
challenges → user_challenges (1:N)
auth.users → user_missions (1:N)
missions → user_missions (1:N)
missions → mission_challenges (1:N)
challenges → mission_challenges (1:N)
auth.users → user_achievements (1:N)
achievements → user_achievements (1:N)
auth.users → user_streaks (1:N)
streaks → user_streaks (1:N)
auth.users → user_points_history (1:N)
auth.users → user_daily_tips (1:N)
daily_tips → user_daily_tips (1:N)
auth.users → activity_logs (1:N)
```

---

## Índices (25 totales)

| Tabla | Índice | Columna |
|---|---|---|
| lessons | idx_lessons_module | module_id |
| lesson_progress | idx_lesson_progress_user | user_id |
| quizzes | idx_quizzes_lesson | lesson_id |
| quiz_questions | idx_quiz_questions_quiz | quiz_id |
| quiz_answers | idx_quiz_answers_question | question_id |
| user_quiz_attempts | idx_quiz_attempts_user | user_id |
| user_quiz_attempts | idx_quiz_attempts_quiz | quiz_id |
| user_quiz_responses | idx_quiz_responses_attempt | attempt_id |
| simulator_attempts | idx_sim_attempts_user | user_id |
| incomes | idx_incomes_user | user_id |
| incomes | idx_incomes_date | income_date |
| expenses | idx_expenses_user | user_id |
| expenses | idx_expenses_date | expense_date |
| budgets | idx_budgets_user | user_id |
| budget_items | idx_budget_items_budget | budget_id |
| savings_goals | idx_savings_goals_user | user_id |
| savings_movements | idx_savings_movements_goal | savings_goal_id |
| debts | idx_debts_user | user_id |
| debt_payments | idx_debt_payments_debt | debt_id |
| financial_reports | idx_financial_reports_user | user_id |
| challenges | idx_challenges_active | is_active |
| user_challenges | idx_user_challenges_user | user_id |
| user_missions | idx_user_missions_user | user_id |
| user_achievements | idx_user_achievements_user | user_id |
| user_streaks | idx_user_streaks_user | user_id |
| user_points_history | idx_points_history_user | user_id |
| user_daily_tips | idx_user_daily_tips_user | user_id |
| activity_logs | idx_activity_logs_user | user_id |
| activity_logs | idx_activity_logs_created | created_at |

---

## Diagrama de Entidad-Relación (textual)

```
auth.users
  ├── user_profiles (1:1)
  ├── user_settings (1:1)
  ├── financial_goals (1:N)
  ├── lesson_progress (1:N)
  ├── user_quiz_attempts (1:N)
  ├── simulator_attempts (1:N)
  ├── incomes (1:N)
  ├── expenses (1:N)
  ├── budgets (1:N)
  ├── savings_goals (1:N)
  ├── debts (1:N)
  ├── financial_reports (1:N)
  ├── user_challenges (1:N)
  ├── user_missions (1:N)
  ├── user_achievements (1:N)
  ├── user_streaks (1:N)
  ├── user_points_history (1:N)
  ├── user_daily_tips (1:N)
  └── activity_logs (1:N)
```

```
educational_modules ── lessons ── quizzes ── quiz_questions ── quiz_answers
                                        │
                                        └── user_quiz_attempts ── user_quiz_responses
```

```
incomes ── income_categories
expenses ── expense_categories ── budget_items ── budgets
savings_goals ── savings_movements
debts ── debt_payments
```

```
badges ── challenges ── mission_challenges ── missions
         └── missions
challenges ── user_challenges
missions ── user_missions
achievements ── user_achievements
streaks ── user_streaks
daily_tips ── user_daily_tips
```
