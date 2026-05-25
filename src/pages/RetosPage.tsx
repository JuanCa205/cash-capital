import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { timeAgo } from '../lib/utils'
import { useAuth } from '../contexts/AuthContext'
import MainLayout from '../components/MainLayout'
import ProgressBar from '../components/ProgressBar'
import EmptyState from '../components/EmptyState'
import { Trophy, Target, Medal, Flame, Award, Star, Zap, CheckCircle } from 'lucide-react'
import type { Challenge, Achievement, Badge, UserStreak, UserPointsHistory } from '../types/database'

export default function RetosPage() {
  const { user } = useAuth()
  const [challenges, setChallenges] = useState<(Challenge & { progress: number; status: string })[]>([])
  const [achievements, setAchievements] = useState<(Achievement & { unlocked: boolean })[]>([])
  const [badges, setBadges] = useState<Badge[]>([])
  const [streaks, setStreaks] = useState<UserStreak[]>([])
  const [pointsHistory, setPointsHistory] = useState<UserPointsHistory[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    let cancelled = false

    const loadData = async () => {
      try {
        const [
          { data: challengeData },
          { data: achievementData },
          { data: badgeData },
          { data: streakData },
          { data: pointsData },
        ] = await Promise.all([
          supabase.from('user_challenges').select('*, challenges(*)').eq('user_id', user.id).order('status').limit(6),
          supabase.from('achievements').select('*').eq('is_active', true).limit(6),
          supabase.from('badges').select('*').eq('is_active', true).limit(6),
          supabase.from('user_streaks').select('*, streaks(*)').eq('user_id', user.id),
          supabase.from('user_points_history').select('*').eq('user_id', user.id).order('created_at', { ascending: false }).limit(10),
        ])

        if (cancelled) return

        if (challengeData) {
          const mapped = (challengeData as { challenges: unknown; progress_value: number; status: string }[]).map((c) => ({
            ...(c.challenges ?? {}) as Challenge,
            progress: c.progress_value,
            status: c.status,
          }))
          setChallenges(mapped)
        }

        if (achievementData) {
          const { data: achievementLinkData } = await supabase.from('user_achievements').select('achievement_id').eq('user_id', user.id)
          if (cancelled) return
          const unlockedIds = new Set((achievementLinkData ?? []).map((ua: { achievement_id: string }) => ua.achievement_id))
          setAchievements(achievementData.map((a) => ({ ...a, unlocked: unlockedIds.has(a.id) })))
        }

        if (badgeData && !cancelled) setBadges(badgeData)
        if (streakData && !cancelled) setStreaks(streakData)
        if (pointsData && !cancelled) setPointsHistory(pointsData)
        if (!cancelled) setLoading(false)
      } catch (err) {
        if (!cancelled) {
          console.error('Error cargando retos:', err)
          setLoading(false)
        }
      }
    }

    loadData()
    return () => { cancelled = true }
  }, [user])

  const totalPoints = pointsHistory.reduce((s, p) => s + p.points, 0)

  return (
    <MainLayout>
      <div className="space-y-6">
        <div>
          <h1 className="font-heading text-2xl font-bold text-theme-text">Retos y Logros</h1>
          <p className="text-theme-text-secondary text-sm mt-1">Desafíate a ti mismo y gana recompensas</p>
        </div>

        <div className="grid grid-cols-2 md:grid-cols-4 gap-3 md:gap-4">
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 border">
            <Trophy className="w-4 h-4 text-amber-400 mb-1" aria-hidden="true" />
            <p className="text-lg font-heading font-bold text-theme-text">{challenges.filter((c) => c.status === 'active').length}</p>
            <p className="text-[10px] text-theme-text-secondary">Retos activos</p>
          </div>
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 border">
            <Award className="w-4 h-4 text-violet-400 mb-1" aria-hidden="true" />
            <p className="text-lg font-heading font-bold text-theme-text">{achievements.filter((a) => a.unlocked).length}</p>
            <p className="text-[10px] text-theme-text-secondary">Logros</p>
          </div>
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 border">
            <Flame className="w-4 h-4 text-orange-400 mb-1" aria-hidden="true" />
            <p className="text-lg font-heading font-bold text-theme-text">{Math.max(...streaks.map((s) => s.current_count), 0)}</p>
            <p className="text-[10px] text-theme-text-secondary">Mejor racha</p>
          </div>
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 border">
            <Zap className="w-4 h-4 text-yellow-400 mb-1" aria-hidden="true" />
            <p className="text-lg font-heading font-bold text-theme-text">{totalPoints.toLocaleString()}</p>
            <p className="text-[10px] text-theme-text-secondary">Puntos ganados</p>
          </div>
        </div>

        <div className="grid md:grid-cols-2 gap-4">
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
            <div className="flex items-center gap-2 mb-4">
              <Target className="w-4 h-4 text-violet-500" aria-hidden="true" />
              <h2 className="font-heading font-semibold text-sm text-theme-text">Retos</h2>
            </div>
            {loading ? (
              <div className="animate-pulse space-y-3">
                {[1, 2].map((i) => (
                  <div key={i} className="bg-theme-muted/50 rounded-lg p-3">
                    <div className="flex items-center justify-between mb-2">
                      <div className="h-4 bg-theme-muted rounded w-2/3" />
                      <div className="h-5 bg-theme-muted rounded-full w-14" />
                    </div>
                    <div className="flex items-center gap-3">
                      <div className="flex-1 h-2 bg-theme-muted rounded-full" />
                      <div className="h-3 bg-theme-muted rounded w-8" />
                    </div>
                  </div>
                ))}
              </div>
            ) : challenges.length === 0 ? (
              <EmptyState icon={Target} message="Aún no tienes retos. ¡Los retos aparecerán aquí!" />
            ) : (
              <div className="space-y-3">
                {challenges.map((c) => (
                  <div key={c.id} className="bg-theme-muted/50 rounded-lg p-3">
                    <div className="flex items-center justify-between mb-1.5">
                      <span className="text-sm font-medium text-theme-text truncate">{c.title}</span>
                      <span className={`text-xs px-1.5 py-0.5 rounded-full ${
                        c.status === 'active' ? 'bg-emerald-500/15 text-emerald-400' : 'bg-slate-500/15 text-slate-400'
                      }`}>{c.status === 'active' ? 'Activo' : c.status}</span>
                    </div>
                    <div className="flex items-center gap-3">
                      <div className="flex-1">
                        <ProgressBar percent={(c.progress / c.target_value) * 100} size="sm" color="violet" />
                      </div>
                      <span className="text-xs text-theme-text-secondary shrink-0">{Math.round((c.progress / c.target_value) * 100)}%</span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>

          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
            <div className="flex items-center gap-2 mb-4">
              <Medal className="w-4 h-4 text-violet-500" aria-hidden="true" />
              <h2 className="font-heading font-semibold text-sm text-theme-text">Logros</h2>
            </div>
            {loading ? (
              <div className="animate-pulse grid grid-cols-2 gap-2">
                {[1, 2, 3, 4].map((i) => (
                  <div key={i} className="bg-theme-muted/50 rounded-lg p-3 text-center">
                    <div className="w-8 h-8 bg-theme-muted rounded-full mx-auto mb-2" />
                    <div className="h-3 bg-theme-muted rounded w-3/4 mx-auto mb-1" />
                    <div className="h-2 bg-theme-muted rounded w-1/2 mx-auto" />
                  </div>
                ))}
              </div>
            ) : achievements.length === 0 ? (
              <EmptyState icon={Medal} message="No hay logros disponibles" />
            ) : (
              <div className="grid grid-cols-2 gap-2">
                {achievements.map((a) => (
                  <div key={a.id} className={`rounded-lg p-3 text-center border transition-all ${a.unlocked ? 'bg-violet-600/10 border-violet-600/20' : 'bg-theme-muted/50 border-transparent opacity-50'}`}>
                    <CheckCircle className={`w-5 h-5 mx-auto mb-1 ${a.unlocked ? 'text-violet-400' : 'text-theme-text-tertiary'}`} aria-hidden="true" />
                    <p className="text-xs font-medium text-theme-text truncate">{a.title}</p>
                    <p className="text-[10px] text-theme-text-secondary">{a.points_reward} pts</p>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>

        <div className="grid md:grid-cols-2 gap-4">
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
            <div className="flex items-center gap-2 mb-4">
              <Star className="w-4 h-4 text-amber-500" aria-hidden="true" />
              <h2 className="font-heading font-semibold text-sm text-theme-text">Insignias</h2>
            </div>
            {badges.length === 0 ? (
              <EmptyState icon={Star} message="Sin insignias disponibles" />
            ) : (
              <div className="flex flex-wrap gap-2">
                {badges.map((b) => (
                  <div key={b.id} className="bg-theme-muted/50 rounded-lg px-3 py-2 text-center flex-1 min-w-[80px]">
                    <div className={`w-8 h-8 rounded-full mx-auto mb-1 flex items-center justify-center text-xs font-bold ${
                      b.rarity === 'legendary' ? 'bg-amber-500/20 text-amber-400' :
                      b.rarity === 'epic' ? 'bg-violet-500/20 text-violet-400' :
                      b.rarity === 'rare' ? 'bg-blue-500/20 text-blue-400' :
                      'bg-slate-500/20 text-slate-400'
                    }`}>
                      {b.name[0]}
                    </div>
                    <p className="text-[10px] text-theme-text truncate">{b.name}</p>
                  </div>
                ))}
              </div>
            )}
          </div>

          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
            <div className="flex items-center gap-2 mb-4">
              <Flame className="w-4 h-4 text-orange-500" aria-hidden="true" />
              <h2 className="font-heading font-semibold text-sm text-theme-text">Rachas</h2>
            </div>
            {streaks.length === 0 ? (
              <EmptyState icon={Flame} message="Sin rachas aún. ¡La constancia da recompensas!" />
            ) : (
              <div className="space-y-2">
                {streaks.map((s) => (
                  <div key={s.id} className="flex items-center justify-between bg-theme-muted/50 rounded-lg px-3 py-2">
                    <div>
                      <p className="text-sm text-theme-text">{s.streak_id ? 'Racha diaria' : 'Racha'}</p>
                      <p className="text-xs text-theme-text-secondary">Mejor: {s.best_count} días</p>
                    </div>
                    <div className="flex items-center gap-1">
                      <Flame className="w-4 h-4 text-orange-400" aria-hidden="true" />
                      <span className="font-heading font-bold text-theme-text">{s.current_count}</span>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>

        <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
          <div className="flex items-center gap-2 mb-4">
            <Zap className="w-4 h-4 text-yellow-500" aria-hidden="true" />
            <h2 className="font-heading font-semibold text-sm text-theme-text">Historial de Puntos</h2>
          </div>
          {pointsHistory.length === 0 ? (
            <p className="text-sm text-theme-text-secondary py-4 text-center">Sin historial de puntos aún</p>
          ) : (
            <div className="space-y-1">
              {pointsHistory.map((p) => (
                <div key={p.id} className="flex items-center justify-between text-sm py-1.5">
                  <div className="flex items-center gap-2">
                    <span className="text-theme-text truncate">{p.description || p.source_type}</span>
                    <span className="text-[10px] text-theme-text-tertiary">{timeAgo(p.created_at)}</span>
                  </div>
                  <span className="text-emerald-400 font-medium">+{p.points}</span>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </MainLayout>
  )
}


