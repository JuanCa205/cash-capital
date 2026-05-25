export interface ModuleWithProgress extends EducationalModule {
  lessons: (Lesson & { progress: LessonProgress | null })[]
}

export type Json = string | number | boolean | null | { [key: string]: Json | undefined } | Json[]

// Enums
export type UserStatus = 'active' | 'inactive' | 'blocked'
export type GoalType = 'save' | 'reduce_expenses' | 'pay_debt' | 'learn' | 'invest'
export type GoalStatus = 'active' | 'completed' | 'cancelled'
export type Difficulty = 'basic' | 'intermediate' | 'advanced'
export type LessonStatus = 'not_started' | 'in_progress' | 'completed'
export type ChallengeType = 'daily' | 'weekly' | 'special'
export type BadgeRarity = 'common' | 'rare' | 'epic' | 'legendary'
export type ActivityType = 'login' | 'lesson_completed' | 'quiz_completed' | 'income_added' | 'expense_added' | 'budget_created' | 'saving_goal_created' | 'saving_deposit' | 'debt_payment' | 'challenge_completed' | 'badge_earned' | 'achievement_unlocked'
export type PointsSource = 'lesson' | 'quiz' | 'challenge' | 'mission' | 'achievement' | 'streak' | 'manual'
export type TipCategory = 'saving' | 'budget' | 'debt' | 'investment' | 'habit' | 'general'
export type MovementType = 'deposit' | 'withdrawal'
export type RecurrenceType = 'daily' | 'weekly' | 'monthly' | 'yearly'
export type PaymentMethod = 'cash' | 'debit_card' | 'credit_card' | 'transfer' | 'other'
export type DebtType = 'credit_card' | 'loan' | 'personal' | 'other'

// Tables
export interface UserLevel {
  id: string
  name: string
  level_number: number
  min_points: number
  max_points: number
  description: string | null
}

export interface Avatar {
  id: string
  name: string
  image_url: string
  required_level: number
  is_active: boolean
  created_at: string
}

export interface UserProfile {
  id: string
  user_id: string
  first_name: string | null
  last_name: string | null
  birth_date: string | null
  phone: string | null
  country: string | null
  city: string | null
  avatar_id: string | null
  current_level_id: string | null
  total_points: number
  financial_score: number
  created_at: string
  updated_at: string
}

export interface UserSettings {
  id: string
  user_id: string
  notifications_enabled: boolean
  daily_tip_enabled: boolean
  challenge_reminders: boolean
  currency: string
  language: string
  theme: string
}

export interface EducationalModule {
  id: string
  title: string
  description: string | null
  difficulty: Difficulty
  order_index: number
  icon_url: string | null
  is_active: boolean
  created_at: string
}

export interface Lesson {
  id: string
  module_id: string
  title: string
  summary: string | null
  content: string
  estimated_minutes: number
  order_index: number
  points_reward: number
  is_active: boolean
  created_at: string
}

export interface LessonProgress {
  id: string
  user_id: string
  lesson_id: string
  status: LessonStatus
  progress_percentage: number
  started_at: string | null
  completed_at: string | null
}

export interface Quiz {
  id: string
  lesson_id: string
  title: string
  description: string | null
  passing_score: number
  points_reward: number
  created_at: string
}

export interface UserQuizAttempt {
  id: string
  user_id: string
  quiz_id: string
  score: number
  passed: boolean
  started_at: string
  completed_at: string | null
}

export interface Simulator {
  id: string
  name: string
  description: string | null
  simulator_type: string
  is_active: boolean
  created_at: string
}

export interface IncomeCategory {
  id: string
  name: string
  icon: string | null
  color: string | null
  is_default: boolean
}

export interface ExpenseCategory {
  id: string
  name: string
  icon: string | null
  color: string | null
  is_default: boolean
}

export interface Income {
  id: string
  user_id: string
  category_id: string
  amount: number
  description: string | null
  income_date: string
  is_recurring: boolean
  recurrence_type: RecurrenceType | null
  created_at: string
}

export interface Expense {
  id: string
  user_id: string
  category_id: string
  amount: number
  description: string | null
  expense_date: string
  payment_method: PaymentMethod
  is_recurring: boolean
  recurrence_type: RecurrenceType | null
  created_at: string
}

export interface Budget {
  id: string
  user_id: string
  name: string
  period_type: RecurrenceType
  start_date: string
  end_date: string
  total_amount: number
  created_at: string
}

export interface BudgetItem {
  id: string
  budget_id: string
  expense_category_id: string
  planned_amount: number
  alert_percentage: number
}

export interface SavingGoal {
  id: string
  user_id: string
  name: string
  target_amount: number
  current_amount: number
  target_date: string | null
  status: GoalStatus
  created_at: string
}

export interface Debt {
  id: string
  user_id: string
  name: string
  original_amount: number
  current_balance: number
  interest_rate: number | null
  minimum_payment: number | null
  due_day: number | null
  debt_type: DebtType
  status: GoalStatus
  created_at: string
}

export interface Challenge {
  id: string
  title: string
  description: string | null
  challenge_type: ChallengeType
  objective_type: string
  target_value: number
  points_reward: number
  badge_reward_id: string | null
  start_date: string | null
  end_date: string | null
  is_active: boolean
}

export interface UserChallenge {
  id: string
  user_id: string
  challenge_id: string
  status: GoalStatus
  progress_value: number
  accepted_at: string
  completed_at: string | null
}

export interface Mission {
  id: string
  title: string
  description: string | null
  mission_type: string
  points_reward: number
  badge_reward_id: string | null
  is_active: boolean
  created_at: string
}

export interface UserMission {
  id: string
  user_id: string
  mission_id: string
  status: GoalStatus
  progress_percentage: number
  started_at: string
  completed_at: string | null
}

export interface Achievement {
  id: string
  title: string
  description: string | null
  achievement_type: string
  condition_type: string
  condition_value: number
  points_reward: number
  is_active: boolean
}

export interface UserAchievement {
  id: string
  user_id: string
  achievement_id: string
  unlocked_at: string
}

export interface Badge {
  id: string
  name: string
  description: string | null
  image_url: string | null
  rarity: BadgeRarity
  is_active: boolean
}

export interface Streak {
  id: string
  name: string
  streak_type: string
  description: string | null
}

export interface UserStreak {
  id: string
  user_id: string
  streak_id: string
  current_count: number
  best_count: number
  last_activity_date: string | null
}

export interface DailyTip {
  id: string
  title: string
  content: string
  category: TipCategory
  difficulty: Difficulty
  is_active: boolean
  created_at: string
}

export interface UserDailyTip {
  id: string
  user_id: string
  daily_tip_id: string
  shown_date: string
  was_read: boolean
}

export interface ActivityLog {
  id: string
  user_id: string
  activity_type: ActivityType
  entity_type: string | null
  entity_id: string | null
  description: string | null
  created_at: string
}

export interface FinancialGoal {
  id: string
  user_id: string
  title: string
  description: string | null
  goal_type: GoalType
  target_amount: number | null
  current_amount: number
  target_date: string | null
  status: GoalStatus
  created_at: string
}

export interface UserPointsHistory {
  id: string
  user_id: string
  source_type: PointsSource
  source_id: string | null
  points: number
  description: string | null
  created_at: string
}
