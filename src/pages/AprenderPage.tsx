import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from '../contexts/AuthContext'
import MainLayout from '../components/MainLayout'
import ProgressBar from '../components/ProgressBar'
import DifficultyBadge from '../components/DifficultyBadge'
import EmptyState from '../components/EmptyState'
import { BookOpen, ChevronDown, ChevronUp, CheckCircle, Clock, Play, BarChart3, Library } from 'lucide-react'
import type { ModuleWithProgress } from '../types/database'

export default function AprenderPage() {
  const { user } = useAuth()
  const [modules, setModules] = useState<ModuleWithProgress[]>([])
  const [expanded, setExpanded] = useState<string | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    let cancelled = false

    const loadModules = async () => {
      try {
        const { data: moduleData } = await supabase
          .from('educational_modules')
          .select('*, lessons(*)')
          .eq('is_active', true)
          .eq('lessons.is_active', true)
          .order('order_index')

        if (cancelled) return
        if (!moduleData) { setLoading(false); return }

        const allLessonIds = moduleData.flatMap((m) => m.lessons.map((l: { id: string }) => l.id))

        const { data: progressData } = allLessonIds.length > 0
          ? await supabase.from('lesson_progress').select('*').in('lesson_id', allLessonIds).eq('user_id', user.id)
          : { data: [] }

        if (cancelled) return

        const progressMap = new Map((progressData ?? []).map((p: { lesson_id: string }) => [p.lesson_id, p]))

        const modulesWithLessons: ModuleWithProgress[] = moduleData.map((mod) => ({
          ...mod,
          lessons: mod.lessons.map((lesson: { id: string }) => ({
            ...lesson,
            progress: progressMap.get(lesson.id) ?? null,
          })),
        }))

        if (!cancelled) {
          setModules(modulesWithLessons)
          setLoading(false)
        }
      } catch (err) {
        if (!cancelled) {
          console.error('Error cargando módulos:', err)
          setLoading(false)
        }
      }
    }

    loadModules()
    return () => { cancelled = true }
  }, [user])

  const completedCount = modules.reduce(
    (sum, m) => sum + m.lessons.filter((l) => l.progress?.status === 'completed').length,
    0
  )
  const totalLessons = modules.reduce((sum, m) => sum + m.lessons.length, 0)

  return (
    <MainLayout>
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="font-heading text-2xl font-bold text-theme-text">Aprender</h1>
            <p className="text-theme-text-secondary text-sm mt-1">Domina tus finanzas paso a paso</p>
          </div>
          <div className="text-right">
            <p className="text-lg font-heading font-bold text-theme-text">{completedCount}/{totalLessons}</p>
            <p className="text-xs text-theme-text-secondary">lecciones</p>
          </div>
        </div>

        <ProgressBar percent={totalLessons ? (completedCount / totalLessons) * 100 : 0} size="lg" />

        {loading ? (
          <div className="space-y-4">
            {[1, 2, 3].map((i) => (
              <div key={i} className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border animate-pulse">
                <div className="h-5 bg-theme-muted rounded w-1/3 mb-3" />
                <div className="h-3 bg-theme-muted rounded w-2/3" />
              </div>
            ))}
          </div>
        ) : modules.length === 0 ? (
          <EmptyState icon={BookOpen} message="No hay módulos disponibles aún" className="py-16" />
        ) : (
          <div className="space-y-3">
            {modules.map((mod) => {
              const modCompleted = mod.lessons.filter((l) => l.progress?.status === 'completed').length
              const modTotal = mod.lessons.length

              return (
                <div key={mod.id} className="bg-theme-surface backdrop-blur-xl rounded-xl border overflow-hidden transition-all duration-200">
                  <button
                    onClick={() => setExpanded(expanded === mod.id ? null : mod.id)}
                    className="w-full flex items-center gap-4 p-4 md:p-5 text-left cursor-pointer hover:bg-theme-muted/50 transition-colors"
                  >
                    <div className="p-2.5 bg-violet-600/15 rounded-xl shrink-0">
                      <BookOpen className="w-5 h-5 text-violet-400" aria-hidden="true" />
                    </div>
                    <div className="flex-1 min-w-0">
                      <h3 className="font-heading font-semibold text-theme-text text-sm md:text-base truncate">{mod.title}</h3>
                      <p className="text-xs text-theme-text-secondary mt-0.5 truncate">{mod.description}</p>
                    </div>
                    <div className="text-right shrink-0">
                      <p className="text-xs text-theme-text-secondary">{modCompleted}/{modTotal}</p>
                      <DifficultyBadge difficulty={mod.difficulty} />
                    </div>
                    {expanded === mod.id ? <ChevronUp className="w-4 h-4 text-theme-text-tertiary" aria-hidden="true" /> : <ChevronDown className="w-4 h-4 text-theme-text-tertiary" aria-hidden="true" />}
                  </button>

                  {expanded === mod.id && (
                    <div className="border-t px-4 md:px-5 py-3 space-y-1">
                      {mod.lessons.length === 0 ? (
                        <EmptyState icon={BookOpen} message="Sin lecciones aún" />
                      ) : (
                        mod.lessons.map((lesson) => {
                          const status = lesson.progress?.status || 'not_started'
                          return (
                            <div key={lesson.id} className="flex items-center gap-3 py-2.5 px-3 rounded-lg hover:bg-theme-muted/50 transition-colors cursor-pointer group">
                              <div className={`p-1 rounded-full ${
                                status === 'completed' ? 'bg-emerald-500/20 text-emerald-400' :
                                status === 'in_progress' ? 'bg-amber-500/20 text-amber-400' :
                                'bg-theme-muted text-theme-text-tertiary group-hover:text-theme-text-secondary'
                              }`}>
                                {status === 'completed' ? <CheckCircle className="w-4 h-4" aria-hidden="true" /> :
                                 status === 'in_progress' ? <Play className="w-4 h-4" aria-hidden="true" /> :
                                 <Clock className="w-4 h-4" aria-hidden="true" />}
                              </div>
                              <div className="flex-1 min-w-0">
                                <p className="text-sm text-theme-text truncate">{lesson.title}</p>
                                <p className="text-xs text-theme-text-secondary">{lesson.estimated_minutes} min</p>
                              </div>
                              {status === 'not_started' && (
                                <span className="text-xs text-violet-500 opacity-0 group-hover:opacity-100 transition-opacity">Empezar</span>
                              )}
                            </div>
                          )
                        })
                      )}
                    </div>
                  )}
                </div>
              )
            })}
          </div>
        )}

        <div className="grid sm:grid-cols-2 gap-4">
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
            <div className="flex items-center gap-2 mb-3">
              <BarChart3 className="w-4 h-4 text-violet-500" aria-hidden="true" />
              <h2 className="font-heading font-semibold text-sm text-theme-text">Simuladores</h2>
            </div>
            <p className="text-xs text-theme-text-secondary">Próximamente podrás simular escenarios financieros interactivos.</p>
          </div>
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
            <div className="flex items-center gap-2 mb-3">
              <Library className="w-4 h-4 text-violet-500" aria-hidden="true" />
              <h2 className="font-heading font-semibold text-sm text-theme-text">Biblioteca</h2>
            </div>
            <p className="text-xs text-theme-text-secondary">Accede a artículos, videos y recursos educativos.</p>
          </div>
        </div>
      </div>
    </MainLayout>
  )
}
