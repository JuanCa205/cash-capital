import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { timeAgo, formatActivity } from '../lib/utils'
import { useAuth } from '../contexts/AuthContext'
import MainLayout from '../components/MainLayout'
import StatCard from '../components/StatCard'
import SectionCard from '../components/SectionCard'
import ProgressBar from '../components/ProgressBar'
import EmptyState from '../components/EmptyState'
import { Sparkles, TrendingUp, Flame, Target, ArrowRight, BookOpen, PiggyBank } from 'lucide-react'
import type { UserLevel, DailyTip, ActivityLog, Challenge, UserStreak } from '../types/database'

export default function InicioPage() {
  const { profile, user } = useAuth()
  const [level, setLevel] = useState<UserLevel | null>(null)
  const [tip, setTip] = useState<DailyTip | null>(null)
  const [activities, setActivities] = useState<ActivityLog[]>([])
  const [challenges, setChallenges] = useState<(Challenge & { progress: number })[]>([])
  const [streaks, setStreaks] = useState<UserStreak[]>([])
  const [incomeMonth, setIncomeMonth] = useState(0)
  const [expenseMonth, setExpenseMonth] = useState(0)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    let cancelled = false

    const loadData = async () => {
      try {
        const now = new Date()
        const monthStart = new Date(now.getFullYear(), now.getMonth(), 1).toISOString().split('T')[0]
        const monthEnd = new Date(now.getFullYear(), now.getMonth() + 1, 0).toISOString().split('T')[0]

        const [
          { data: tipData },
          { data: activityData },
          { data: challengeData },
          { data: streakData },
          { data: incomeData },
          { data: expenseData },
        ] = await Promise.all([
          supabase.from('daily_tips').select('*').limit(1).single(),
          supabase.from('activity_logs').select('*').eq('user_id', user.id).order('created_at', { ascending: false }).limit(5),
          supabase.from('user_challenges').select('challenge_id, progress_value, status, challenges(*)').eq('user_id', user.id).eq('status', 'active').limit(3),
          supabase.from('user_streaks').select('*, streaks(*)').eq('user_id', user.id),
          supabase.from('incomes').select('amount').gte('income_date', monthStart).lte('income_date', monthEnd).eq('user_id', user.id),
          supabase.from('expenses').select('amount').gte('expense_date', monthStart).lte('expense_date', monthEnd).eq('user_id', user.id),
        ])

        if (cancelled) return

        const levelQuery = profile?.current_level_id
          ? supabase.from('user_levels').select('*').eq('id', profile.current_level_id).single()
          : supabase.from('user_levels').select('*').eq('level_number', 1).single()
        const { data: levelData } = await levelQuery
        if (levelData && !cancelled) setLevel(levelData)

        if (tipData && !cancelled) setTip(tipData)
        if (activityData && !cancelled) setActivities(activityData)
        if (challengeData && !cancelled) {
          const mapped = (challengeData as { challenges: unknown; progress_value: number }[]).map((c) => ({
            ...(c.challenges ?? {}) as Challenge,
            progress: c.progress_value,
          }))
          setChallenges(mapped)
        }
        if (streakData && !cancelled) setStreaks(streakData)
        if (incomeData && !cancelled) setIncomeMonth(incomeData.reduce((sum, i) => sum + Number(i.amount), 0))
        if (expenseData && !cancelled) setExpenseMonth(expenseData.reduce((sum, e) => sum + Number(e.amount), 0))
      } catch (err) {
        if (!cancelled) console.error('Error cargando datos del inicio:', err)
      } finally {
        if (!cancelled) setLoading(false)
      }
    }

    loadData()
    return () => { cancelled = true }
  }, [user, profile])

  const levelProgress = level
    ? ((profile?.total_points ?? 0) - level.min_points) / (level.max_points - level.min_points) * 100
    : 0

  const loginStreak = streaks.find((s) => s.streak_id)

  if (loading) {
    return (
      <MainLayout>
        <div className="space-y-6">
          <div className="animate-pulse space-y-2">
            <div className="h-8 bg-theme-muted rounded w-1/3" />
            <div className="h-4 bg-theme-muted rounded w-1/4" />
          </div>

          <div className="grid grid-cols-2 md:grid-cols-4 gap-3 md:gap-4">
            {[1, 2, 3, 4].map((i) => (
              <div key={i} className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 border animate-pulse">
                <div className="w-4 h-4 bg-theme-muted rounded mb-2" />
                <div className="h-6 bg-theme-muted rounded w-1/2 mb-1" />
                <div className="h-3 bg-theme-muted rounded w-2/3" />
              </div>
            ))}
          </div>

          <div className="grid md:grid-cols-3 gap-4 md:gap-6">
            <div className="md:col-span-2 space-y-4">
              {[1, 2].map((i) => (
                <div key={i} className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border animate-pulse">
                  <div className="flex items-center gap-2 mb-4">
                    <div className="w-4 h-4 bg-theme-muted rounded" />
                    <div className="h-4 bg-theme-muted rounded w-1/4" />
                  </div>
                  <div className="h-3 bg-theme-muted rounded w-full mb-2" />
                  <div className="h-2 bg-theme-muted rounded w-3/4" />
                </div>
              ))}
            </div>
            <div className="space-y-4">
              {[1, 2].map((i) => (
                <div key={i} className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border animate-pulse">
                  <div className="flex items-center gap-2 mb-4">
                    <div className="w-4 h-4 bg-theme-muted rounded" />
                    <div className="h-4 bg-theme-muted rounded w-1/3" />
                  </div>
                  <div className="space-y-2">
                    <div className="h-3 bg-theme-muted rounded w-full" />
                    <div className="h-3 bg-theme-muted rounded w-2/3" />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </MainLayout>
    )
  }

  return (
    <MainLayout>
      <div className="space-y-6">
        <div>
          <h1 className="font-heading text-2xl font-bold text-theme-text">
            ¡Hola, {profile?.first_name || 'Financiero'}!
          </h1>
          <p className="text-theme-text-secondary text-sm mt-1">Aquí está tu resumen financiero</p>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-3 md:gap-4">
          <StatCard icon={TrendingUp} label="Puntos" value={(profile?.total_points ?? 0).toLocaleString()} sub={level?.name || 'Nivel 1'} color="violet" />
          <StatCard icon={Flame} label="Racha" value={`${loginStreak?.current_count || 0}`} sub="días seguidos" color="orange" />
          <StatCard icon={PiggyBank} label="Ingresos" value={`$${(incomeMonth).toLocaleString()}`} sub="este mes" color="green" />
          <StatCard icon={BookOpen} label="Gastos" value={`$${(expenseMonth).toLocaleString()}`} sub="este mes" color="red" />
        </div>

        <div className="grid md:grid-cols-3 gap-4 md:gap-6">
          <div className="md:col-span-2 space-y-4">
            <SectionCard title="Nivel Actual" icon={TrendingUp}>
              <div className="space-y-3">
                <div className="flex justify-between items-center">
                  <span className="text-lg font-heading font-semibold text-theme-text">{level?.name || 'Cargando...'}</span>
                  <span className="text-sm text-theme-text-secondary">{level?.min_points.toLocaleString()} / {level?.max_points.toLocaleString()} pts</span>
                </div>
                <ProgressBar percent={levelProgress} size="lg" />
                <p className="text-xs text-theme-text-secondary">{profile?.total_points.toLocaleString()} puntos totales · Puntaje financiero: {profile?.financial_score || 0}</p>
              </div>
            </SectionCard>

            <SectionCard title="Actividad Reciente" icon={Sparkles}>
              {activities.length === 0 ? (
                <EmptyState icon={Sparkles} message="Aún no hay actividad. ¡Empieza a aprender!" />
              ) : (
                <div className="space-y-2">
                  {activities.map((a) => (
                    <div key={a.id} className="flex items-center gap-3 text-sm py-1.5">
                      <div className="w-2 h-2 rounded-full bg-violet-500 shrink-0" />
                      <span className="text-theme-text-secondary">{formatActivity(a.activity_type, a.description)}</span>
                      <span className="text-theme-text-tertiary text-xs ml-auto shrink-0">{timeAgo(a.created_at)}</span>
                    </div>
                  ))}
                </div>
              )}
            </SectionCard>
          </div>

          <div className="space-y-4">
            <SectionCard title="Tip del Día" icon={Sparkles}>
              <p className="text-theme-text text-sm leading-relaxed">{tip?.content || 'Carga tu primer consejo financiero'}</p>
              <span className="text-xs text-theme-text-tertiary mt-2 block">{tip?.category || 'general'}</span>
            </SectionCard>

            <SectionCard title="Retos Activos" icon={Target}>
              {challenges.length === 0 ? (
                <EmptyState icon={Target} message="No hay retos activos" />
              ) : (
                <div className="space-y-3">
                  {challenges.map((c) => (
                    <div key={c.id}>
                      <div className="flex justify-between text-sm mb-1">
                        <span className="text-theme-text truncate">{c.title}</span>
                        <span className="text-theme-text-secondary shrink-0 ml-2">{Math.round((c.progress / c.target_value) * 100)}%</span>
                      </div>
                      <ProgressBar percent={(c.progress / c.target_value) * 100} size="md" color="violet" />
                    </div>
                  ))}
                </div>
              )}
              <button className="mt-3 text-xs text-violet-500 hover:text-violet-400 flex items-center gap-1 cursor-pointer transition-colors">
                Ver todos <ArrowRight className="w-3 h-3" aria-hidden="true" />
              </button>
            </SectionCard>
          </div>
        </div>
      </div>
    </MainLayout>
  )
}


