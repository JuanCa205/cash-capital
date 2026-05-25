-- ============================================================
-- Cash Capital — RLS Policies (Row Level Security)
-- Generado por Security Agent — 2026-05-25
-- ============================================================
-- Habilita RLS y crea policies para las 41 tablas públicas.
-- Clasificación:
--   A) Tablas de referencia pública (solo SELECT para autenticados)
--   B) Tablas con user_id (propietario = auth.uid())
--   C) Tablas sin user_id directo (acceso vía FK → user_id)
-- ============================================================

-- ============================================================
-- HABILITAR RLS EN TODAS LAS TABLAS
-- ============================================================
DO $$
DECLARE
  tbl TEXT;
BEGIN
  FOR tbl IN
    SELECT tablename FROM pg_catalog.pg_tables
    WHERE schemaname = 'public'
      AND tablename NOT IN (
        '_http_response', 'audit_log_entries', 'buckets', 'buckets_analytics',
        'buckets_vectors', 'extensions', 'flow_state', 'hooks', 'http_request_queue',
        'iceberg_namespaces', 'iceberg_tables', 'mfa_amr_claims', 'mfa_challenges',
        'mfa_factors', 'migrations', 'oauth_authorizations', 'oauth_client_states',
        'oauth_clients', 'oauth_consents', 'objects', 'one_time_tokens',
        'refresh_tokens', 's3_multipart_uploads', 's3_multipart_uploads_parts',
        'saml_providers', 'saml_relay_states', 'schema_migrations', 'secrets',
        'sessions', 'sso_domains', 'sso_providers', 'subscription', 'tenants',
        'vector_indexes'
      )
      AND tablename NOT LIKE 'messages\_%'
  LOOP
    EXECUTE format('ALTER TABLE public.%I ENABLE ROW LEVEL SECURITY;', tbl);
  END LOOP;
END $$;

-- ============================================================
-- GRUPO A: Tablas de referencia pública (solo SELECT)
-- ============================================================

-- A1. user_levels
CREATE POLICY "read_authenticated" ON public.user_levels
  FOR SELECT TO authenticated USING (true);

-- A2. avatars
CREATE POLICY "read_authenticated" ON public.avatars
  FOR SELECT TO authenticated USING (true);

-- A3. educational_modules
CREATE POLICY "read_authenticated" ON public.educational_modules
  FOR SELECT TO authenticated USING (true);

-- A4. lessons
CREATE POLICY "read_authenticated" ON public.lessons
  FOR SELECT TO authenticated USING (true);

-- A5. quizzes
CREATE POLICY "read_authenticated" ON public.quizzes
  FOR SELECT TO authenticated USING (true);

-- A6. quiz_questions
CREATE POLICY "read_authenticated" ON public.quiz_questions
  FOR SELECT TO authenticated USING (true);

-- A7. quiz_answers
CREATE POLICY "read_authenticated" ON public.quiz_answers
  FOR SELECT TO authenticated USING (true);

-- A8. financial_library_items
CREATE POLICY "read_authenticated" ON public.financial_library_items
  FOR SELECT TO authenticated USING (true);

-- A9. simulators
CREATE POLICY "read_authenticated" ON public.simulators
  FOR SELECT TO authenticated USING (true);

-- A10. income_categories
CREATE POLICY "read_authenticated" ON public.income_categories
  FOR SELECT TO authenticated USING (true);

-- A11. expense_categories
CREATE POLICY "read_authenticated" ON public.expense_categories
  FOR SELECT TO authenticated USING (true);

-- A12. badges
CREATE POLICY "read_authenticated" ON public.badges
  FOR SELECT TO authenticated USING (true);

-- A13. challenges
CREATE POLICY "read_authenticated" ON public.challenges
  FOR SELECT TO authenticated USING (true);

-- A14. missions
CREATE POLICY "read_authenticated" ON public.missions
  FOR SELECT TO authenticated USING (true);

-- A15. mission_challenges
CREATE POLICY "read_authenticated" ON public.mission_challenges
  FOR SELECT TO authenticated USING (true);

-- A16. achievements
CREATE POLICY "read_authenticated" ON public.achievements
  FOR SELECT TO authenticated USING (true);

-- A17. streaks
CREATE POLICY "read_authenticated" ON public.streaks
  FOR SELECT TO authenticated USING (true);

-- A18. daily_tips
CREATE POLICY "read_authenticated" ON public.daily_tips
  FOR SELECT TO authenticated USING (true);

-- ============================================================
-- GRUPO B: Tablas con user_id (propietario)
-- ============================================================

-- B1. user_profiles
CREATE POLICY "users_own_records" ON public.user_profiles
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B2. user_settings
CREATE POLICY "users_own_records" ON public.user_settings
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B3. financial_goals
CREATE POLICY "users_own_records" ON public.financial_goals
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B4. lesson_progress
CREATE POLICY "users_own_records" ON public.lesson_progress
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B5. user_quiz_attempts
CREATE POLICY "users_own_records" ON public.user_quiz_attempts
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B6. simulator_attempts
CREATE POLICY "users_own_records" ON public.simulator_attempts
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B7. incomes
CREATE POLICY "users_own_records" ON public.incomes
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B8. expenses
CREATE POLICY "users_own_records" ON public.expenses
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B9. budgets
CREATE POLICY "users_own_records" ON public.budgets
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B10. savings_goals
CREATE POLICY "users_own_records" ON public.savings_goals
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B11. debts
CREATE POLICY "users_own_records" ON public.debts
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B12. financial_reports
CREATE POLICY "users_own_records" ON public.financial_reports
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B13. user_challenges
CREATE POLICY "users_own_records" ON public.user_challenges
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B14. user_missions
CREATE POLICY "users_own_records" ON public.user_missions
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B15. user_achievements
CREATE POLICY "users_own_records" ON public.user_achievements
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B16. user_streaks
CREATE POLICY "users_own_records" ON public.user_streaks
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B17. user_points_history
CREATE POLICY "users_own_records" ON public.user_points_history
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B18. user_daily_tips
CREATE POLICY "users_own_records" ON public.user_daily_tips
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- B19. activity_logs
CREATE POLICY "users_own_records" ON public.activity_logs
  FOR ALL USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- ============================================================
-- GRUPO C: Tablas sin user_id directo (acceso vía FK)
-- ============================================================

-- C1. user_quiz_responses → user_quiz_attempts.user_id
CREATE POLICY "users_own_via_attempt" ON public.user_quiz_responses
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.user_quiz_attempts
      WHERE id = attempt_id AND user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.user_quiz_attempts
      WHERE id = attempt_id AND user_id = auth.uid()
    )
  );

-- C2. budget_items → budgets.user_id
CREATE POLICY "users_own_via_budget" ON public.budget_items
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.budgets
      WHERE id = budget_id AND user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.budgets
      WHERE id = budget_id AND user_id = auth.uid()
    )
  );

-- C3. savings_movements → savings_goals.user_id
CREATE POLICY "users_own_via_savings" ON public.savings_movements
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.savings_goals
      WHERE id = savings_goal_id AND user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.savings_goals
      WHERE id = savings_goal_id AND user_id = auth.uid()
    )
  );

-- C4. debt_payments → debts.user_id
CREATE POLICY "users_own_via_debt" ON public.debt_payments
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.debts
      WHERE id = debt_id AND user_id = auth.uid()
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.debts
      WHERE id = debt_id AND user_id = auth.uid()
    )
  );
