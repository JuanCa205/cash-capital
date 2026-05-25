/* eslint-disable react-refresh/only-export-components, react-hooks/set-state-in-effect */
import { createContext, useContext, useEffect, useState, type ReactNode } from 'react'
import type { Session, User } from '@supabase/supabase-js'
import { supabase } from '../lib/supabase'
import type { UserProfile, UserSettings } from '../types/database'

interface AuthContextValue {
  session: Session | null
  user: User | null
  profile: UserProfile | null
  settings: UserSettings | null
  loading: boolean
  login: (email: string, password: string) => Promise<{ error: string | null }>
  register: (email: string, password: string, firstName: string) => Promise<{ error: string | null }>
  logout: () => Promise<void>
  refreshProfile: () => Promise<void>
}

const AuthContext = createContext<AuthContextValue | null>(null)

export function AuthProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<Session | null>(null)
  const [user, setUser] = useState<User | null>(null)
  const [profile, setProfile] = useState<UserProfile | null>(null)
  const [settings, setSettings] = useState<UserSettings | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session)
      setUser(session?.user ?? null)
    })

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      setSession(session)
      setUser(session?.user ?? null)
    })

    return () => subscription.unsubscribe()
  }, [])

  useEffect(() => {
    if (!user) {
      setLoading(false)
      return
    }

    const fetchProfile = async () => {
      try {
        const { data: profileData } = await supabase
          .from('user_profiles')
          .select('*')
          .eq('user_id', user.id)
          .maybeSingle()

        const { data: settingsData } = await supabase
          .from('user_settings')
          .select('*')
          .eq('user_id', user.id)
          .maybeSingle()

        if (profileData) setProfile(profileData)
        if (settingsData) setSettings(settingsData)
      } catch (err) {
        console.error('Error cargando perfil:', err)
      } finally {
        setLoading(false)
      }
    }

    fetchProfile()
  }, [user])

  const login = async (email: string, password: string) => {
    const { error } = await supabase.auth.signInWithPassword({ email, password })
    return { error: error?.message ?? null }
  }

  const register = async (email: string, password: string, firstName: string) => {
    const { data, error } = await supabase.auth.signUp({ email, password })
    if (error) return { error: error.message }
    if (!data.user) return { error: 'Error al crear la cuenta. Revisa tu correo para confirmar.' }

    const [first, ...last] = firstName.trim().split(' ')

    // Obtener el nivel inicial (level_number = 1) para asignarlo al usuario
    const { data: firstLevel, error: levelError } = await supabase
      .from('user_levels')
      .select('id')
      .eq('level_number', 1)
      .maybeSingle()

    if (levelError) {
      console.warn('Error al obtener nivel inicial:', levelError.message)
    }

    if (!firstLevel) {
      // Si no existe el nivel 1, no bloqueamos el registro pero lo reportamos
      console.warn('Nivel inicial (level_number=1) no encontrado en user_levels. El usuario se creará sin nivel asignado.')
    }

    const { error: profileError } = await supabase.from('user_profiles').insert({
      user_id: data.user.id,
      first_name: first,
      last_name: last.join(' ') || null,
      current_level_id: firstLevel?.id || null,
    })

    if (profileError) {
      console.warn('Error creando perfil:', profileError.message)
      // No bloqueamos el registro si falla la creación del perfil,
      // pero lo reportamos para diagnóstico
    }

    const { error: settingsError } = await supabase.from('user_settings').insert({
      user_id: data.user.id,
    })

    if (settingsError) {
      console.warn('Error creando configuración:', settingsError.message)
    }

    return { error: null }
  }

  const logout = async () => {
    await supabase.auth.signOut()
    setProfile(null)
    setSettings(null)
  }

  const refreshProfile = async () => {
    if (!user) return
    const { data } = await supabase
      .from('user_profiles')
      .select('*')
      .eq('user_id', user.id)
      .maybeSingle()
    if (data) setProfile(data)
  }

  return (
    <AuthContext.Provider value={{ session, user, profile, settings, loading, login, register, logout, refreshProfile }}>
      {children}
    </AuthContext.Provider>
  )
}

export function useAuth() {
  const ctx = useContext(AuthContext)
  if (!ctx) throw new Error('useAuth must be used within AuthProvider')
  return ctx
}
