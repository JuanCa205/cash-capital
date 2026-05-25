-- ============================================================
-- Cash Capital — Migración Inicial
-- Fecha: 2026-05-25
-- Descripción: Schema completo de la BD (41 tablas, 24 enums,
--               trigger, índices, RLS policies)
-- ============================================================

-- ============================================================
-- 1. FUNCIÓN TRIGGER
-- ============================================================
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- 2. TIPOS ENUM (24)
-- ============================================================

CREATE TYPE public.achievement_type AS ENUM (
    'learning', 'finance', 'challenge', 'streak'
);

CREATE TYPE public.activity_type AS ENUM (
    'login', 'lesson_completed', 'quiz_completed',
    'income_added', 'expense_added', 'budget_created',
    'saving_goal_created', 'saving_deposit', 'debt_payment',
    'challenge_completed', 'badge_earned', 'achievement_unlocked'
);

CREATE TYPE public.badge_rarity AS ENUM (
    'common', 'rare', 'epic', 'legendary'
);

CREATE TYPE public.challenge_type AS ENUM (
    'daily', 'weekly', 'special'
);

CREATE TYPE public.debt_status AS ENUM (
    'active', 'paid', 'cancelled'
);

CREATE TYPE public.debt_type AS ENUM (
    'credit_card', 'loan', 'personal', 'other'
);

CREATE TYPE public.difficulty AS ENUM (
    'basic', 'intermediate', 'advanced'
);

CREATE TYPE public.goal_status AS ENUM (
    'active', 'completed', 'cancelled'
);

CREATE TYPE public.goal_type AS ENUM (
    'save', 'reduce_expenses', 'pay_debt', 'learn', 'invest'
);

CREATE TYPE public.lesson_status AS ENUM (
    'not_started', 'in_progress', 'completed'
);

CREATE TYPE public.mission_type AS ENUM (
    'learning', 'finance', 'habit', 'mixed'
);

CREATE TYPE public.movement_type AS ENUM (
    'deposit', 'withdrawal'
);

CREATE TYPE public.objective_type AS ENUM (
    'complete_lesson', 'complete_quiz', 'register_expense',
    'create_budget', 'save_money', 'pay_debt', 'login_streak'
);

CREATE TYPE public.payment_method AS ENUM (
    'cash', 'debit_card', 'credit_card', 'transfer', 'other'
);

CREATE TYPE public.points_source AS ENUM (
    'lesson', 'quiz', 'challenge', 'mission',
    'achievement', 'streak', 'manual'
);

CREATE TYPE public.question_type AS ENUM (
    'single_choice', 'multiple_choice', 'true_false'
);

CREATE TYPE public.recurrence_type AS ENUM (
    'daily', 'weekly', 'monthly', 'yearly'
);

CREATE TYPE public.report_type AS ENUM (
    'monthly_summary', 'expense_analysis',
    'budget_performance', 'debt_status', 'saving_progress'
);

CREATE TYPE public.resource_type AS ENUM (
    'article', 'video', 'pdf', 'link'
);

CREATE TYPE public.simulator_type AS ENUM (
    'savings', 'debt', 'compound_interest', 'budget', 'investment'
);

CREATE TYPE public.streak_type AS ENUM (
    'login', 'lesson', 'saving', 'expense_tracking'
);

CREATE TYPE public.tip_category AS ENUM (
    'saving', 'budget', 'debt', 'investment', 'habit', 'general'
);

CREATE TYPE public.user_status AS ENUM (
    'active', 'inactive', 'blocked'
);

CREATE TYPE public.user_theme AS ENUM (
    'light', 'dark', 'system'
);

-- ============================================================
-- 3. TABLAS (41)
-- ============================================================

-- 3.1 Perfil

CREATE TABLE public.user_levels (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    level_number integer NOT NULL,
    min_points integer NOT NULL,
    max_points integer NOT NULL,
    description text
);

CREATE TABLE public.avatars (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    image_url character varying(255) NOT NULL,
    required_level integer DEFAULT 1,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.user_profiles (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    birth_date date,
    phone character varying(30),
    country character varying(80),
    city character varying(80),
    avatar_id uuid,
    current_level_id uuid,
    total_points integer DEFAULT 0,
    financial_score integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.user_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    notifications_enabled boolean DEFAULT true,
    daily_tip_enabled boolean DEFAULT true,
    challenge_reminders boolean DEFAULT true,
    currency character varying(10) DEFAULT 'COP'::character varying,
    language character varying(10) DEFAULT 'es'::character varying,
    theme public.user_theme DEFAULT 'system'::public.user_theme
);

CREATE TABLE public.financial_goals (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    title character varying(150) NOT NULL,
    description text,
    goal_type public.goal_type NOT NULL,
    target_amount numeric(12,2),
    current_amount numeric(12,2) DEFAULT 0,
    target_date date,
    status public.goal_status DEFAULT 'active'::public.goal_status,
    created_at timestamp with time zone DEFAULT now()
);

-- 3.2 Aprender

CREATE TABLE public.educational_modules (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(150) NOT NULL,
    description text,
    difficulty public.difficulty DEFAULT 'basic'::public.difficulty,
    order_index integer DEFAULT 0,
    icon_url character varying(255),
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.lessons (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    module_id uuid NOT NULL,
    title character varying(150) NOT NULL,
    summary text,
    content text NOT NULL,
    estimated_minutes integer DEFAULT 5,
    order_index integer DEFAULT 0,
    points_reward integer DEFAULT 10,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.lesson_progress (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    lesson_id uuid NOT NULL,
    status public.lesson_status DEFAULT 'not_started'::public.lesson_status,
    progress_percentage numeric(5,2) DEFAULT 0,
    started_at timestamp with time zone,
    completed_at timestamp with time zone
);

CREATE TABLE public.quizzes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    lesson_id uuid NOT NULL,
    title character varying(150) NOT NULL,
    description text,
    passing_score numeric(5,2) DEFAULT 70,
    points_reward integer DEFAULT 20,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.quiz_questions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    quiz_id uuid NOT NULL,
    question_text text NOT NULL,
    question_type public.question_type DEFAULT 'single_choice'::public.question_type,
    points integer DEFAULT 1,
    order_index integer DEFAULT 0
);

CREATE TABLE public.quiz_answers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    question_id uuid NOT NULL,
    answer_text text NOT NULL,
    is_correct boolean DEFAULT false
);

CREATE TABLE public.user_quiz_attempts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    quiz_id uuid NOT NULL,
    score numeric(5,2) DEFAULT 0,
    passed boolean DEFAULT false,
    started_at timestamp with time zone DEFAULT now(),
    completed_at timestamp with time zone
);

CREATE TABLE public.user_quiz_responses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    attempt_id uuid NOT NULL,
    question_id uuid NOT NULL,
    answer_id uuid NOT NULL,
    is_correct boolean DEFAULT false
);

CREATE TABLE public.financial_library_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(150) NOT NULL,
    content text,
    resource_type public.resource_type DEFAULT 'article'::public.resource_type,
    url character varying(255),
    category character varying(100),
    difficulty public.difficulty DEFAULT 'basic'::public.difficulty,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.simulators (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(150) NOT NULL,
    description text,
    simulator_type public.simulator_type NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.simulator_attempts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    simulator_id uuid NOT NULL,
    input_data jsonb,
    result_data jsonb,
    created_at timestamp with time zone DEFAULT now()
);

-- 3.3 Mis Finanzas

CREATE TABLE public.income_categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(100),
    color character varying(20),
    is_default boolean DEFAULT false
);

CREATE TABLE public.expense_categories (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(100),
    color character varying(20),
    is_default boolean DEFAULT false
);

CREATE TABLE public.incomes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    category_id uuid NOT NULL,
    amount numeric(12,2) NOT NULL,
    description character varying(255),
    income_date date NOT NULL,
    is_recurring boolean DEFAULT false,
    recurrence_type public.recurrence_type,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.expenses (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    category_id uuid NOT NULL,
    amount numeric(12,2) NOT NULL,
    description character varying(255),
    expense_date date NOT NULL,
    payment_method public.payment_method DEFAULT 'cash'::public.payment_method,
    is_recurring boolean DEFAULT false,
    recurrence_type public.recurrence_type,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.budgets (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    name character varying(150) NOT NULL,
    period_type public.recurrence_type DEFAULT 'monthly'::public.recurrence_type,
    start_date date NOT NULL,
    end_date date NOT NULL,
    total_amount numeric(12,2) NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.budget_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    budget_id uuid NOT NULL,
    expense_category_id uuid NOT NULL,
    planned_amount numeric(12,2) NOT NULL,
    alert_percentage numeric(5,2) DEFAULT 80
);

CREATE TABLE public.savings_goals (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    name character varying(150) NOT NULL,
    target_amount numeric(12,2) NOT NULL,
    current_amount numeric(12,2) DEFAULT 0,
    target_date date,
    status public.goal_status DEFAULT 'active'::public.goal_status,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.savings_movements (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    savings_goal_id uuid NOT NULL,
    movement_type public.movement_type NOT NULL,
    amount numeric(12,2) NOT NULL,
    description character varying(255),
    movement_date date NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.debts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    name character varying(150) NOT NULL,
    original_amount numeric(12,2) NOT NULL,
    current_balance numeric(12,2) NOT NULL,
    interest_rate numeric(5,2) DEFAULT 0,
    minimum_payment numeric(12,2),
    due_day integer,
    debt_type public.debt_type DEFAULT 'other'::public.debt_type,
    status public.debt_status DEFAULT 'active'::public.debt_status,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.debt_payments (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    debt_id uuid NOT NULL,
    amount numeric(12,2) NOT NULL,
    payment_date date NOT NULL,
    notes character varying(255),
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.financial_reports (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    report_type public.report_type NOT NULL,
    period_start date NOT NULL,
    period_end date NOT NULL,
    report_data jsonb,
    generated_at timestamp with time zone DEFAULT now()
);

-- 3.4 Retos + Inicio

CREATE TABLE public.badges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    image_url character varying(255),
    rarity public.badge_rarity DEFAULT 'common'::public.badge_rarity,
    is_active boolean DEFAULT true
);

CREATE TABLE public.challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(150) NOT NULL,
    description text,
    challenge_type public.challenge_type NOT NULL,
    objective_type public.objective_type NOT NULL,
    target_value numeric(12,2) DEFAULT 1,
    points_reward integer DEFAULT 0,
    badge_reward_id uuid,
    start_date date,
    end_date date,
    is_active boolean DEFAULT true
);

CREATE TABLE public.user_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    challenge_id uuid NOT NULL,
    status public.goal_status DEFAULT 'active'::public.goal_status,
    progress_value numeric(12,2) DEFAULT 0,
    accepted_at timestamp with time zone DEFAULT now(),
    completed_at timestamp with time zone
);

CREATE TABLE public.missions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(150) NOT NULL,
    description text,
    mission_type public.mission_type DEFAULT 'mixed'::public.mission_type,
    points_reward integer DEFAULT 0,
    badge_reward_id uuid,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.mission_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    mission_id uuid NOT NULL,
    challenge_id uuid NOT NULL
);

CREATE TABLE public.user_missions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    mission_id uuid NOT NULL,
    status public.goal_status DEFAULT 'active'::public.goal_status,
    progress_percentage numeric(5,2) DEFAULT 0,
    started_at timestamp with time zone DEFAULT now(),
    completed_at timestamp with time zone
);

CREATE TABLE public.achievements (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(150) NOT NULL,
    description text,
    achievement_type public.achievement_type NOT NULL,
    condition_type character varying(100) NOT NULL,
    condition_value numeric(12,2) NOT NULL,
    points_reward integer DEFAULT 0,
    is_active boolean DEFAULT true
);

CREATE TABLE public.user_achievements (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    achievement_id uuid NOT NULL,
    unlocked_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.streaks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying(100) NOT NULL,
    streak_type public.streak_type NOT NULL,
    description text
);

CREATE TABLE public.user_streaks (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    streak_id uuid NOT NULL,
    current_count integer DEFAULT 0,
    best_count integer DEFAULT 0,
    last_activity_date date
);

CREATE TABLE public.user_points_history (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    source_type public.points_source NOT NULL,
    source_id uuid,
    points integer NOT NULL,
    description character varying(255),
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.daily_tips (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    title character varying(150) NOT NULL,
    content text NOT NULL,
    category public.tip_category DEFAULT 'general'::public.tip_category,
    difficulty public.difficulty DEFAULT 'basic'::public.difficulty,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now()
);

CREATE TABLE public.user_daily_tips (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    daily_tip_id uuid NOT NULL,
    shown_date date NOT NULL,
    was_read boolean DEFAULT false
);

CREATE TABLE public.activity_logs (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    activity_type public.activity_type NOT NULL,
    entity_type character varying(100),
    entity_id uuid,
    description character varying(255),
    created_at timestamp with time zone DEFAULT now()
);

-- ============================================================
-- 4. CONSTRAINTS — PRIMARY KEYS
-- ============================================================

ALTER TABLE ONLY public.achievements ADD CONSTRAINT achievements_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.activity_logs ADD CONSTRAINT activity_logs_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.avatars ADD CONSTRAINT avatars_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.badges ADD CONSTRAINT badges_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.budget_items ADD CONSTRAINT budget_items_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.budgets ADD CONSTRAINT budgets_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.challenges ADD CONSTRAINT challenges_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.daily_tips ADD CONSTRAINT daily_tips_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.debt_payments ADD CONSTRAINT debt_payments_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.debts ADD CONSTRAINT debts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.educational_modules ADD CONSTRAINT educational_modules_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.expense_categories ADD CONSTRAINT expense_categories_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.expenses ADD CONSTRAINT expenses_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.financial_goals ADD CONSTRAINT financial_goals_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.financial_library_items ADD CONSTRAINT financial_library_items_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.financial_reports ADD CONSTRAINT financial_reports_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.income_categories ADD CONSTRAINT income_categories_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.incomes ADD CONSTRAINT incomes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.lesson_progress ADD CONSTRAINT lesson_progress_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.lessons ADD CONSTRAINT lessons_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.mission_challenges ADD CONSTRAINT mission_challenges_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.missions ADD CONSTRAINT missions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.quiz_answers ADD CONSTRAINT quiz_answers_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.quiz_questions ADD CONSTRAINT quiz_questions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.quizzes ADD CONSTRAINT quizzes_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.savings_goals ADD CONSTRAINT savings_goals_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.savings_movements ADD CONSTRAINT savings_movements_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.simulator_attempts ADD CONSTRAINT simulator_attempts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.simulators ADD CONSTRAINT simulators_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.streaks ADD CONSTRAINT streaks_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_achievements ADD CONSTRAINT user_achievements_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_challenges ADD CONSTRAINT user_challenges_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_daily_tips ADD CONSTRAINT user_daily_tips_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_levels ADD CONSTRAINT user_levels_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_missions ADD CONSTRAINT user_missions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_points_history ADD CONSTRAINT user_points_history_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_profiles ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_quiz_attempts ADD CONSTRAINT user_quiz_attempts_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_quiz_responses ADD CONSTRAINT user_quiz_responses_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_settings ADD CONSTRAINT user_settings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.user_streaks ADD CONSTRAINT user_streaks_pkey PRIMARY KEY (id);

-- ============================================================
-- 5. CONSTRAINTS — UNIQUE
-- ============================================================

ALTER TABLE ONLY public.budget_items
    ADD CONSTRAINT budget_items_budget_id_expense_category_id_key UNIQUE (budget_id, expense_category_id);
ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT lesson_progress_user_id_lesson_id_key UNIQUE (user_id, lesson_id);
ALTER TABLE ONLY public.mission_challenges
    ADD CONSTRAINT mission_challenges_mission_id_challenge_id_key UNIQUE (mission_id, challenge_id);
ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_user_id_achievement_id_key UNIQUE (user_id, achievement_id);
ALTER TABLE ONLY public.user_challenges
    ADD CONSTRAINT user_challenges_user_id_challenge_id_key UNIQUE (user_id, challenge_id);
ALTER TABLE ONLY public.user_daily_tips
    ADD CONSTRAINT user_daily_tips_user_id_daily_tip_id_shown_date_key UNIQUE (user_id, daily_tip_id, shown_date);
ALTER TABLE ONLY public.user_levels
    ADD CONSTRAINT user_levels_level_number_key UNIQUE (level_number);
ALTER TABLE ONLY public.user_missions
    ADD CONSTRAINT user_missions_user_id_mission_id_key UNIQUE (user_id, mission_id);
ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_user_id_key UNIQUE (user_id);
ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_user_id_key UNIQUE (user_id);
ALTER TABLE ONLY public.user_streaks
    ADD CONSTRAINT user_streaks_user_id_streak_id_key UNIQUE (user_id, streak_id);

-- ============================================================
-- 6. CONSTRAINTS — FOREIGN KEYS
-- ============================================================

-- Perfil
ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_avatar_id_fkey FOREIGN KEY (avatar_id) REFERENCES public.avatars(id);
ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_current_level_id_fkey FOREIGN KEY (current_level_id) REFERENCES public.user_levels(id);
ALTER TABLE ONLY public.user_settings
    ADD CONSTRAINT user_settings_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.financial_goals
    ADD CONSTRAINT financial_goals_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);

-- Aprender
ALTER TABLE ONLY public.lessons
    ADD CONSTRAINT lessons_module_id_fkey FOREIGN KEY (module_id) REFERENCES public.educational_modules(id);
ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT lesson_progress_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);
ALTER TABLE ONLY public.lesson_progress
    ADD CONSTRAINT lesson_progress_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.quizzes
    ADD CONSTRAINT quizzes_lesson_id_fkey FOREIGN KEY (lesson_id) REFERENCES public.lessons(id);
ALTER TABLE ONLY public.quiz_questions
    ADD CONSTRAINT quiz_questions_quiz_id_fkey FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id);
ALTER TABLE ONLY public.quiz_answers
    ADD CONSTRAINT quiz_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id);
ALTER TABLE ONLY public.user_quiz_attempts
    ADD CONSTRAINT user_quiz_attempts_quiz_id_fkey FOREIGN KEY (quiz_id) REFERENCES public.quizzes(id);
ALTER TABLE ONLY public.user_quiz_attempts
    ADD CONSTRAINT user_quiz_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.user_quiz_responses
    ADD CONSTRAINT user_quiz_responses_attempt_id_fkey FOREIGN KEY (attempt_id) REFERENCES public.user_quiz_attempts(id);
ALTER TABLE ONLY public.user_quiz_responses
    ADD CONSTRAINT user_quiz_responses_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.quiz_questions(id);
ALTER TABLE ONLY public.user_quiz_responses
    ADD CONSTRAINT user_quiz_responses_answer_id_fkey FOREIGN KEY (answer_id) REFERENCES public.quiz_answers(id);
ALTER TABLE ONLY public.simulator_attempts
    ADD CONSTRAINT simulator_attempts_simulator_id_fkey FOREIGN KEY (simulator_id) REFERENCES public.simulators(id);
ALTER TABLE ONLY public.simulator_attempts
    ADD CONSTRAINT simulator_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);

-- Mis Finanzas
ALTER TABLE ONLY public.incomes
    ADD CONSTRAINT incomes_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.income_categories(id);
ALTER TABLE ONLY public.incomes
    ADD CONSTRAINT incomes_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.expense_categories(id);
ALTER TABLE ONLY public.expenses
    ADD CONSTRAINT expenses_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.budgets
    ADD CONSTRAINT budgets_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.budget_items
    ADD CONSTRAINT budget_items_budget_id_fkey FOREIGN KEY (budget_id) REFERENCES public.budgets(id);
ALTER TABLE ONLY public.budget_items
    ADD CONSTRAINT budget_items_expense_category_id_fkey FOREIGN KEY (expense_category_id) REFERENCES public.expense_categories(id);
ALTER TABLE ONLY public.savings_goals
    ADD CONSTRAINT savings_goals_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.savings_movements
    ADD CONSTRAINT savings_movements_savings_goal_id_fkey FOREIGN KEY (savings_goal_id) REFERENCES public.savings_goals(id);
ALTER TABLE ONLY public.debts
    ADD CONSTRAINT debts_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.debt_payments
    ADD CONSTRAINT debt_payments_debt_id_fkey FOREIGN KEY (debt_id) REFERENCES public.debts(id);
ALTER TABLE ONLY public.financial_reports
    ADD CONSTRAINT financial_reports_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);

-- Retos + Inicio
ALTER TABLE ONLY public.challenges
    ADD CONSTRAINT challenges_badge_reward_id_fkey FOREIGN KEY (badge_reward_id) REFERENCES public.badges(id);
ALTER TABLE ONLY public.user_challenges
    ADD CONSTRAINT user_challenges_challenge_id_fkey FOREIGN KEY (challenge_id) REFERENCES public.challenges(id);
ALTER TABLE ONLY public.user_challenges
    ADD CONSTRAINT user_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_badge_reward_id_fkey FOREIGN KEY (badge_reward_id) REFERENCES public.badges(id);
ALTER TABLE ONLY public.mission_challenges
    ADD CONSTRAINT mission_challenges_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES public.missions(id);
ALTER TABLE ONLY public.mission_challenges
    ADD CONSTRAINT mission_challenges_challenge_id_fkey FOREIGN KEY (challenge_id) REFERENCES public.challenges(id);
ALTER TABLE ONLY public.user_missions
    ADD CONSTRAINT user_missions_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES public.missions(id);
ALTER TABLE ONLY public.user_missions
    ADD CONSTRAINT user_missions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_achievement_id_fkey FOREIGN KEY (achievement_id) REFERENCES public.achievements(id);
ALTER TABLE ONLY public.user_achievements
    ADD CONSTRAINT user_achievements_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.user_streaks
    ADD CONSTRAINT user_streaks_streak_id_fkey FOREIGN KEY (streak_id) REFERENCES public.streaks(id);
ALTER TABLE ONLY public.user_streaks
    ADD CONSTRAINT user_streaks_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.user_points_history
    ADD CONSTRAINT user_points_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.user_daily_tips
    ADD CONSTRAINT user_daily_tips_daily_tip_id_fkey FOREIGN KEY (daily_tip_id) REFERENCES public.daily_tips(id);
ALTER TABLE ONLY public.user_daily_tips
    ADD CONSTRAINT user_daily_tips_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);
ALTER TABLE ONLY public.activity_logs
    ADD CONSTRAINT activity_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);

-- ============================================================
-- 7. TRIGGER
-- ============================================================

CREATE TRIGGER update_user_profiles_updated_at
    BEFORE UPDATE ON public.user_profiles
    FOR EACH ROW
    EXECUTE FUNCTION public.update_updated_at_column();

-- ============================================================
-- 8. ÍNDICES (30)
-- ============================================================

CREATE INDEX idx_lessons_module ON public.lessons USING btree (module_id);
CREATE INDEX idx_lesson_progress_user ON public.lesson_progress USING btree (user_id);
CREATE INDEX idx_quizzes_lesson ON public.quizzes USING btree (lesson_id);
CREATE INDEX idx_quiz_questions_quiz ON public.quiz_questions USING btree (quiz_id);
CREATE INDEX idx_quiz_answers_question ON public.quiz_answers USING btree (question_id);
CREATE INDEX idx_quiz_attempts_user ON public.user_quiz_attempts USING btree (user_id);
CREATE INDEX idx_quiz_attempts_quiz ON public.user_quiz_attempts USING btree (quiz_id);
CREATE INDEX idx_quiz_responses_attempt ON public.user_quiz_responses USING btree (attempt_id);
CREATE INDEX idx_sim_attempts_user ON public.simulator_attempts USING btree (user_id);
CREATE INDEX idx_incomes_user ON public.incomes USING btree (user_id);
CREATE INDEX idx_incomes_date ON public.incomes USING btree (income_date);
CREATE INDEX idx_expenses_user ON public.expenses USING btree (user_id);
CREATE INDEX idx_expenses_date ON public.expenses USING btree (expense_date);
CREATE INDEX idx_budgets_user ON public.budgets USING btree (user_id);
CREATE INDEX idx_budget_items_budget ON public.budget_items USING btree (budget_id);
CREATE INDEX idx_savings_goals_user ON public.savings_goals USING btree (user_id);
CREATE INDEX idx_savings_movements_goal ON public.savings_movements USING btree (savings_goal_id);
CREATE INDEX idx_debts_user ON public.debts USING btree (user_id);
CREATE INDEX idx_debt_payments_debt ON public.debt_payments USING btree (debt_id);
CREATE INDEX idx_financial_reports_user ON public.financial_reports USING btree (user_id);
CREATE INDEX idx_challenges_active ON public.challenges USING btree (is_active);
CREATE INDEX idx_user_challenges_user ON public.user_challenges USING btree (user_id);
CREATE INDEX idx_user_missions_user ON public.user_missions USING btree (user_id);
CREATE INDEX idx_user_achievements_user ON public.user_achievements USING btree (user_id);
CREATE INDEX idx_user_streaks_user ON public.user_streaks USING btree (user_id);
CREATE INDEX idx_points_history_user ON public.user_points_history USING btree (user_id);
CREATE INDEX idx_user_daily_tips_user ON public.user_daily_tips USING btree (user_id);
CREATE INDEX idx_activity_logs_user ON public.activity_logs USING btree (user_id);
CREATE INDEX idx_activity_logs_created ON public.activity_logs USING btree (created_at);

-- ============================================================
-- 9. ROW LEVEL SECURITY
-- ============================================================

-- Habilitar RLS en todas las tablas
ALTER TABLE public.achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activity_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.avatars ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.badges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.budget_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.budgets ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_tips ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.debt_payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.debts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.educational_modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.expense_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.financial_goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.financial_library_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.financial_reports ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.income_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.incomes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lesson_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.mission_challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.missions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quiz_answers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quiz_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quizzes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.savings_goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.savings_movements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.simulator_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.simulators ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.streaks ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_daily_tips ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_levels ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_missions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_points_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_quiz_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_quiz_responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_streaks ENABLE ROW LEVEL SECURITY;

-- Grupo A: Tablas de referencia pública (solo SELECT para autenticados)
CREATE POLICY "read_authenticated" ON public.user_levels
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.avatars
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.educational_modules
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.lessons
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.quizzes
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.quiz_questions
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.quiz_answers
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.financial_library_items
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.simulators
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.income_categories
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.expense_categories
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.badges
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.challenges
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.missions
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.mission_challenges
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.achievements
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.streaks
    FOR SELECT TO authenticated USING (true);
CREATE POLICY "read_authenticated" ON public.daily_tips
    FOR SELECT TO authenticated USING (true);

-- Grupo B: Tablas con user_id (propietario = auth.uid())
CREATE POLICY "users_own_records" ON public.user_profiles
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.user_settings
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.financial_goals
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.lesson_progress
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.user_quiz_attempts
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.simulator_attempts
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.incomes
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.expenses
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.budgets
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.savings_goals
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.debts
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.financial_reports
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.user_challenges
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.user_missions
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.user_achievements
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.user_streaks
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.user_points_history
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.user_daily_tips
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);
CREATE POLICY "users_own_records" ON public.activity_logs
    FOR ALL USING (auth.uid() = user_id) WITH CHECK (auth.uid() = user_id);

-- Grupo C: Tablas sin user_id directo (acceso vía FK)
CREATE POLICY "users_own_via_attempt" ON public.user_quiz_responses
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM public.user_quiz_attempts
            WHERE id = attempt_id AND user_id = auth.uid()
        )
    ) WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.user_quiz_attempts
            WHERE id = attempt_id AND user_id = auth.uid()
        )
    );

CREATE POLICY "users_own_via_budget" ON public.budget_items
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM public.budgets
            WHERE id = budget_id AND user_id = auth.uid()
        )
    ) WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.budgets
            WHERE id = budget_id AND user_id = auth.uid()
        )
    );

CREATE POLICY "users_own_via_savings" ON public.savings_movements
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM public.savings_goals
            WHERE id = savings_goal_id AND user_id = auth.uid()
        )
    ) WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.savings_goals
            WHERE id = savings_goal_id AND user_id = auth.uid()
        )
    );

CREATE POLICY "users_own_via_debt" ON public.debt_payments
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM public.debts
            WHERE id = debt_id AND user_id = auth.uid()
        )
    ) WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.debts
            WHERE id = debt_id AND user_id = auth.uid()
        )
    );
