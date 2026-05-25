import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { sanitizeInput } from '../lib/utils'
import { useAuth } from '../contexts/AuthContext'
import { useTheme } from '../contexts/ThemeContext'
import MainLayout from '../components/MainLayout'
import EmptyState from '../components/EmptyState'
import { User, Settings, Bell, DollarSign, Globe, LogOut, Palette } from 'lucide-react'
import type { FinancialGoal } from '../types/database'

/* eslint-disable react-hooks/set-state-in-effect */
export default function PerfilPage() {
  const { user, profile, settings, logout, refreshProfile } = useAuth()
  const { theme, toggleTheme } = useTheme()
  const [goals, setGoals] = useState<FinancialGoal[]>([])
  const [editing, setEditing] = useState(false)
  const [firstName, setFirstName] = useState('')
  const [lastName, setLastName] = useState('')
  const [saving, setSaving] = useState(false)

  useEffect(() => {
    if (!user) return
    let cancelled = false

    const loadData = async () => {
      try {
        const { data: goalData } = await supabase
          .from('financial_goals')
          .select('*')
          .eq('user_id', user.id)
          .order('created_at', { ascending: false })
          .limit(5)

        if (!cancelled && goalData) setGoals(goalData)
      } catch (err) {
        if (!cancelled) console.error('Error cargando metas:', err)
      }
    }

    loadData()
    return () => { cancelled = true }
  }, [user])

  useEffect(() => {
    if (profile) {
      setFirstName(profile.first_name || '')
      setLastName(profile.last_name || '')
    }
  }, [profile])

  const startEditing = () => {
    setFirstName(profile?.first_name || '')
    setLastName(profile?.last_name || '')
    setEditing(true)
  }

  const cancelEditing = () => {
    setFirstName(profile?.first_name || '')
    setLastName(profile?.last_name || '')
    setEditing(false)
  }

  const handleSave = async () => {
    if (!user) return
    // Sanitizar inputs antes de guardar
    const cleanFirstName = sanitizeInput(firstName, 50)
    const cleanLastName = sanitizeInput(lastName, 50)
    setSaving(true)
    await supabase
      .from('user_profiles')
      .update({ first_name: cleanFirstName || null, last_name: cleanLastName || null })
      .eq('user_id', user.id)
    await refreshProfile()
    setSaving(false)
    setEditing(false)
  }

  const handleLogout = async () => {
    await logout()
    window.location.href = '/login'
  }

  return (
    <MainLayout>
      <div className="space-y-6 max-w-2xl">
        <div>
          <h1 className="font-heading text-2xl font-bold text-theme-text">Perfil</h1>
          <p className="text-theme-text-secondary text-sm mt-1">Tu información y configuración</p>
        </div>

        <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 md:p-6 border">
          <div className="flex items-center gap-4 mb-6">
            <div className="w-16 h-16 rounded-full bg-gradient-to-br from-violet-500 to-fuchsia-500 flex items-center justify-center text-white text-2xl font-heading font-bold shrink-0">
              {firstName?.[0]?.toUpperCase() || lastName?.[0]?.toUpperCase() || user?.email?.[0]?.toUpperCase() || 'U'}
            </div>
            <div className="flex-1 min-w-0">
              <h2 className="font-heading text-lg font-bold text-theme-text truncate">{firstName || 'Usuario'} {lastName}</h2>
              <p className="text-sm text-theme-text-secondary truncate">{user?.email}</p>
            </div>
            <button
              onClick={editing ? cancelEditing : startEditing}
              className="text-xs text-violet-500 hover:text-violet-400 cursor-pointer transition-colors shrink-0"
            >
              {editing ? 'Cancelar' : 'Editar'}
            </button>
          </div>

          {editing ? (
            <div className="space-y-3">
              <input
                value={firstName}
                onChange={(e) => setFirstName(e.target.value)}
                placeholder="Nombre"
                className="w-full bg-theme-input border border-theme-input-border rounded-lg px-3 py-2 text-sm text-theme-text placeholder-theme-text-tertiary focus:outline-none focus:border-violet-500 focus:ring-1 focus:ring-violet-500/50"
              />
              <input
                value={lastName}
                onChange={(e) => setLastName(e.target.value)}
                placeholder="Apellido"
                className="w-full bg-theme-input border border-theme-input-border rounded-lg px-3 py-2 text-sm text-theme-text placeholder-theme-text-tertiary focus:outline-none focus:border-violet-500 focus:ring-1 focus:ring-violet-500/50"
              />
              <button
                onClick={handleSave}
                disabled={saving}
                className="px-4 py-2 bg-violet-600 hover:bg-violet-500 disabled:bg-violet-600/40 text-white text-sm font-medium rounded-lg transition-all duration-200 cursor-pointer"
              >
                {saving ? 'Guardando...' : 'Guardar'}
              </button>
            </div>
          ) : (
            <div className="grid grid-cols-2 gap-4 text-sm">
              <div>
                <p className="text-theme-text-tertiary text-xs">País</p>
                <p className="text-theme-text">{profile?.country || 'No especificado'}</p>
              </div>
              <div>
                <p className="text-theme-text-tertiary text-xs">Ciudad</p>
                <p className="text-theme-text">{profile?.city || 'No especificado'}</p>
              </div>
              <div>
                <p className="text-theme-text-tertiary text-xs">Teléfono</p>
                <p className="text-theme-text">{profile?.phone || 'No especificado'}</p>
              </div>
              <div>
                <p className="text-theme-text-tertiary text-xs">Miembro desde</p>
                <p className="text-theme-text">{profile?.created_at ? new Date(profile.created_at).toLocaleDateString() : '-'}</p>
              </div>
            </div>
          )}
        </div>

        <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
          <div className="flex items-center gap-2 mb-4">
            <Palette className="w-4 h-4 text-violet-500" aria-hidden="true" />
            <h2 className="font-heading font-semibold text-sm text-theme-text">Apariencia</h2>
          </div>
          <div className="flex items-center justify-between">
            <span className="text-sm text-theme-text">Modo {theme === 'dark' ? 'oscuro' : 'claro'}</span>
            <button
              onClick={toggleTheme}
              className="text-xs px-3 py-1.5 rounded-lg bg-violet-600/15 text-violet-400 hover:bg-violet-600/25 transition-colors cursor-pointer"
            >
              Cambiar a {theme === 'dark' ? 'claro' : 'oscuro'}
            </button>
          </div>
        </div>

        <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
          <div className="flex items-center gap-2 mb-4">
            <Settings className="w-4 h-4 text-violet-500" aria-hidden="true" />
            <h2 className="font-heading font-semibold text-sm text-theme-text">Configuración</h2>
          </div>
          <div className="space-y-3">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Bell className="w-4 h-4 text-theme-text-tertiary" aria-hidden="true" />
                <span className="text-sm text-theme-text">Notificaciones</span>
              </div>
              <span className="text-xs text-theme-text-secondary">{settings?.notifications_enabled ? 'Activadas' : 'Desactivadas'}</span>
            </div>
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <DollarSign className="w-4 h-4 text-theme-text-tertiary" aria-hidden="true" />
                <span className="text-sm text-theme-text">Moneda</span>
              </div>
              <span className="text-xs text-theme-text-secondary">{settings?.currency || 'COP'}</span>
            </div>
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Globe className="w-4 h-4 text-theme-text-tertiary" aria-hidden="true" />
                <span className="text-sm text-theme-text">Idioma</span>
              </div>
              <span className="text-xs text-theme-text-secondary">{settings?.language || 'Español'}</span>
            </div>
          </div>
        </div>

        <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
          <div className="flex items-center gap-2 mb-4">
            <User className="w-4 h-4 text-violet-500" aria-hidden="true" />
            <h2 className="font-heading font-semibold text-sm text-theme-text">Metas Financieras</h2>
          </div>
          {goals.length === 0 ? (
            <EmptyState icon={User} message="Sin metas financieras. ¡Define tus objetivos!" />
          ) : (
            <div className="space-y-3">
              {goals.map((g) => (
                <div key={g.id} className="flex items-center justify-between bg-theme-muted/50 rounded-lg px-3 py-2.5">
                  <div className="flex-1 min-w-0">
                    <p className="text-sm text-theme-text truncate">{g.title}</p>
                    <p className="text-xs text-theme-text-secondary">{g.goal_type}</p>
                  </div>
                  <div className="text-right shrink-0 ml-2">
                    <p className="text-sm text-theme-text font-medium">
                      {g.target_amount ? `${Math.round((Number(g.current_amount) / Number(g.target_amount)) * 100)}%` : '-'}
                    </p>
                    <span className={`text-[10px] px-1.5 py-0.5 rounded-full ${
                      g.status === 'active' ? 'bg-emerald-500/15 text-emerald-400' :
                      g.status === 'completed' ? 'bg-blue-500/15 text-blue-400' :
                      'bg-slate-500/15 text-slate-400'
                    }`}>{g.status}</span>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        <button
          onClick={handleLogout}
          className="flex items-center gap-2 text-sm text-red-400 hover:text-red-300 transition-colors cursor-pointer px-1 py-2"
        >
          <LogOut className="w-4 h-4" aria-hidden="true" />
          Cerrar sesión
        </button>
      </div>
    </MainLayout>
  )
}
