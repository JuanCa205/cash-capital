import { useState, type FormEvent } from 'react'
import { Mail, Lock, User, Eye, EyeOff, PiggyBank, Check, Loader2 } from 'lucide-react'
import { useNavigate } from 'react-router-dom'
import { useAuth } from '../contexts/AuthContext'
import { sanitizeInput } from '../lib/utils'
import ThemeToggle from '../components/ThemeToggle'

type AuthMode = 'login' | 'register'

interface AuthPageProps {
  initialMode?: AuthMode
}

const ERROR_MAP: Record<string, string> = {
  'Invalid login credentials': 'Credenciales inválidas',
  'User already registered': 'Este correo ya está registrado',
  'Email not confirmed': 'Correo no confirmado',
  'Invalid email': 'Correo electrónico inválido',
  'Invalid password': 'Contraseña inválida',
  'Password should be at least 6 characters': 'La contraseña debe tener al menos 6 caracteres',
  'Email rate limit exceeded': 'Demasiados intentos, espera un momento',
  'User not found': 'Usuario no encontrado',
  'Error sending confirmation email': 'Error al enviar correo de confirmación. Revisa tu conexión o intenta más tarde.',
}

export default function AuthPage({ initialMode = 'login' }: AuthPageProps) {
  const [mode, setMode] = useState<AuthMode>(initialMode)
  const navigate = useNavigate()
  const { login, register } = useAuth()

  const switchMode = (newMode: AuthMode) => {
    setMode(newMode)
    navigate(newMode === 'login' ? '/login' : '/register')
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-[var(--gradient-from)] via-[var(--gradient-via)] to-[var(--gradient-to)] flex items-center justify-center p-4 font-body relative">
      <div className="fixed top-4 right-4 md:top-6 md:right-6 z-50">
        <div className="bg-theme-surface backdrop-blur-xl border rounded-full p-2.5 shadow-lg">
          <ThemeToggle />
        </div>
      </div>
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <div className="inline-flex items-center gap-3 mb-3">
            <div className="p-2.5 bg-violet-600/20 rounded-xl">
              <PiggyBank className="w-7 h-7 text-violet-400" aria-hidden="true" />
            </div>
            <h1 className="font-heading text-3xl font-bold text-theme-text tracking-tight">
              Cash Capital
            </h1>
          </div>
          <p className="text-theme-text-secondary text-sm">Aprende finanzas mientras juegas</p>
        </div>

        <div className="bg-theme-surface backdrop-blur-2xl rounded-2xl p-8 border shadow-[0_0_40px_rgba(139,92,246,0.15)]">
          <div className="flex mb-8 bg-theme-muted rounded-xl p-1 relative">
            <div
              className={`absolute inset-y-1 w-[calc(50%-4px)] bg-violet-600 rounded-lg transition-all duration-300 ease-out ${
                mode === 'login' ? 'left-1' : 'left-[calc(50%+2px)]'
              }`}
            />
            <button
              type="button"
              onClick={() => switchMode('login')}
              className={`relative z-10 flex-1 py-2.5 text-sm font-medium rounded-lg transition-colors duration-200 cursor-pointer ${
                mode === 'login' ? 'text-white' : 'text-theme-text-secondary hover:text-theme-text'
              }`}
            >
              Iniciar Sesión
            </button>
            <button
              type="button"
              onClick={() => switchMode('register')}
              className={`relative z-10 flex-1 py-2.5 text-sm font-medium rounded-lg transition-colors duration-200 cursor-pointer ${
                mode === 'register' ? 'text-white' : 'text-theme-text-secondary hover:text-theme-text'
              }`}
            >
              Crear Cuenta
            </button>
          </div>

          {mode === 'login' ? (
            <LoginForm onSuccess={() => navigate('/inicio')} login={login} />
          ) : (
            <RegisterForm onSuccess={() => navigate('/inicio')} register={register} />
          )}
        </div>
      </div>
    </div>
  )
}

function LoginForm({ onSuccess, login }: { onSuccess: () => void; login: (email: string, password: string) => Promise<{ error: string | null }> }) {
  const [showPassword, setShowPassword] = useState(false)
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [remember, setRemember] = useState(false)
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const navigate = useNavigate()

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault()
    setError('')

    // Sanitizar inputs antes de enviar
    const sanitizedEmail = sanitizeInput(email, 254)
    const sanitizedPassword = sanitizeInput(password, 128)
    if (!sanitizedEmail) {
      setError('Ingresa un correo electrónico válido')
      setLoading(false)
      return
    }
    if (!sanitizedPassword) {
      setError('Ingresa tu contraseña')
      setLoading(false)
      return
    }

    setLoading(true)
    const result = await login(sanitizedEmail, sanitizedPassword)
    setLoading(false)
    if (result.error) {
      setError(ERROR_MAP[result.error] || 'Error al iniciar sesión. Intenta de nuevo.')
    } else {
      onSuccess()
    }
  }

  return (
    <form className="space-y-5" onSubmit={handleSubmit}>
      {error && (
        <div className="bg-red-500/10 border border-red-500/20 rounded-lg px-4 py-2.5 text-sm text-red-400">
          {error}
        </div>
      )}
      <div>
        <label htmlFor="login-email" className="block text-sm font-medium text-theme-text-secondary mb-1.5">
          Correo electrónico
        </label>
        <div className="relative">
          <Mail className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-theme-text-tertiary" aria-hidden="true" />
          <input
            id="login-email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="tu@correo.com"
            required
            className="w-full bg-theme-input border border-theme-input-border rounded-lg pl-10 pr-4 py-2.5 text-sm text-theme-text placeholder-theme-text-tertiary focus:outline-none focus-visible:ring-2 focus-visible:ring-violet-500 focus-visible:ring-offset-2 focus-visible:ring-offset-[var(--theme-bg)] focus:border-violet-500 transition-colors"
          />
        </div>
      </div>

      <div>
        <label htmlFor="login-password" className="block text-sm font-medium text-theme-text-secondary mb-1.5">
          Contraseña
        </label>
        <div className="relative">
          <Lock className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-theme-text-tertiary" aria-hidden="true" />
          <input
            id="login-password"
            type={showPassword ? 'text' : 'password'}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="••••••••"
            required
            className="w-full bg-theme-input border border-theme-input-border rounded-lg pl-10 pr-10 py-2.5 text-sm text-theme-text placeholder-theme-text-tertiary focus:outline-none focus-visible:ring-2 focus-visible:ring-violet-500 focus-visible:ring-offset-2 focus-visible:ring-offset-[var(--theme-bg)] focus:border-violet-500 transition-colors"
          />
          <button
            type="button"
            onClick={() => setShowPassword(!showPassword)}
            className="absolute right-3.5 top-1/2 -translate-y-1/2 text-theme-text-tertiary hover:text-theme-text-secondary transition-colors cursor-pointer"
          >
            {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
          </button>
        </div>
      </div>

      <div className="flex items-center justify-between text-sm">
        <label className="flex items-center gap-2 cursor-pointer group">
          <div
            onClick={() => setRemember(!remember)}
            className={`w-4 h-4 rounded border flex items-center justify-center transition-all cursor-pointer ${
              remember
                ? 'bg-violet-600 border-violet-600'
                : 'border-theme-input-border group-hover:border-theme-text-tertiary'
            }`}
          >
            {remember && <Check className="w-3 h-3 text-white" aria-hidden="true" />}
          </div>
          <span className="text-theme-text-secondary group-hover:text-theme-text transition-colors">Recordarme</span>
        </label>
        <button type="button" className="text-violet-500 hover:text-violet-400 transition-colors cursor-pointer">
          ¿Olvidaste tu contraseña?
        </button>
      </div>

      <button
        type="submit"
        disabled={loading}
        className="w-full py-2.5 bg-violet-600 hover:bg-violet-500 disabled:bg-violet-600/40 disabled:cursor-not-allowed text-white text-sm font-medium rounded-lg transition-all duration-200 cursor-pointer active:scale-[0.98] flex items-center justify-center gap-2"
      >
        {loading ? <Loader2 className="w-4 h-4 animate-spin" aria-hidden="true" /> : null}
        {loading ? 'Ingresando...' : 'Iniciar Sesión'}
      </button>

      <p className="text-center text-sm text-theme-text-tertiary">
        ¿No tienes cuenta?{' '}
        <button type="button" onClick={() => navigate('/register')} className="text-violet-500 hover:text-violet-400 transition-colors cursor-pointer">
          Regístrate
        </button>
      </p>
    </form>
  )
}

function RegisterForm({ onSuccess, register }: { onSuccess: () => void; register: (email: string, password: string, firstName: string) => Promise<{ error: string | null }> }) {
  const [showPassword, setShowPassword] = useState(false)
  const [showConfirm, setShowConfirm] = useState(false)
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [confirm, setConfirm] = useState('')
  const [accepted, setAccepted] = useState(false)
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const navigate = useNavigate()

  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault()

    // Sanitizar inputs antes de enviar
    const sanitizedName = sanitizeInput(name, 50)
    const sanitizedEmail = sanitizeInput(email, 254)
    const sanitizedPassword = sanitizeInput(password, 128)

    if (!sanitizedName) {
      setError('Ingresa tu nombre completo')
      return
    }
    if (!sanitizedEmail) {
      setError('Ingresa un correo electrónico válido')
      return
    }
    if (!sanitizedPassword) {
      setError('Ingresa una contraseña')
      return
    }
    if (sanitizedPassword !== confirm.trim()) {
      setError('Las contraseñas no coinciden')
      return
    }
    if (sanitizedPassword.length < 6) {
      setError('La contraseña debe tener al menos 6 caracteres')
      return
    }
    setError('')
    setLoading(true)
    const result = await register(sanitizedEmail, sanitizedPassword, sanitizedName)
    setLoading(false)
    if (result.error) {
      setError(ERROR_MAP[result.error] || 'Error al crear la cuenta. Intenta de nuevo.')
    } else {
      onSuccess()
    }
  }

  return (
    <form className="space-y-4" onSubmit={handleSubmit}>
      {error && (
        <div className="bg-red-500/10 border border-red-500/20 rounded-lg px-4 py-2.5 text-sm text-red-400">
          {error}
        </div>
      )}
      <div>
        <label htmlFor="reg-name" className="block text-sm font-medium text-theme-text-secondary mb-1.5">
          Nombre completo
        </label>
        <div className="relative">
          <User className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-theme-text-tertiary" />
          <input
            id="reg-name"
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            placeholder="Tu nombre"
            required
            className="w-full bg-theme-input border border-theme-input-border rounded-lg pl-10 pr-4 py-2.5 text-sm text-theme-text placeholder-theme-text-tertiary focus:outline-none focus-visible:ring-2 focus-visible:ring-violet-500 focus-visible:ring-offset-2 focus-visible:ring-offset-[var(--theme-bg)] focus:border-violet-500 transition-colors"
          />
        </div>
      </div>

      <div>
        <label htmlFor="reg-email" className="block text-sm font-medium text-theme-text-secondary mb-1.5">
          Correo electrónico
        </label>
        <div className="relative">
          <Mail className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-theme-text-tertiary" aria-hidden="true" />
          <input
            id="reg-email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="tu@correo.com"
            required
className="w-full bg-theme-input border border-theme-input-border rounded-lg pl-10 pr-4 py-2.5 text-sm text-theme-text placeholder-theme-text-tertiary focus:outline-none focus-visible:ring-2 focus-visible:ring-violet-500 focus-visible:ring-offset-2 focus-visible:ring-offset-[var(--theme-bg)] focus:border-violet-500 transition-colors"
          />
        </div>
      </div>

      <div>
        <label htmlFor="login-password" className="block text-sm font-medium text-theme-text-secondary mb-1.5">
          Contraseña
        </label>
        <div className="relative">
          <Lock className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-theme-text-tertiary" aria-hidden="true" />
          <input
            id="reg-password"
            type={showPassword ? 'text' : 'password'}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="Mínimo 6 caracteres"
            required
            minLength={6}
            className="w-full bg-theme-input border border-theme-input-border rounded-lg pl-10 pr-10 py-2.5 text-sm text-theme-text placeholder-theme-text-tertiary focus:outline-none focus-visible:ring-2 focus-visible:ring-violet-500 focus-visible:ring-offset-2 focus-visible:ring-offset-[var(--theme-bg)] focus:border-violet-500 transition-colors"
          />
          <button
            type="button"
            onClick={() => setShowPassword(!showPassword)}
            className="absolute right-3.5 top-1/2 -translate-y-1/2 text-theme-text-tertiary hover:text-theme-text-secondary transition-colors cursor-pointer"
          >
            {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
          </button>
        </div>
      </div>

      <div>
        <label htmlFor="reg-confirm" className="block text-sm font-medium text-theme-text-secondary mb-1.5">
          Confirmar contraseña
        </label>
        <div className="relative">
          <Lock className="absolute left-3.5 top-1/2 -translate-y-1/2 w-4 h-4 text-theme-text-tertiary" aria-hidden="true" />
          <input
            id="reg-confirm"
            type={showConfirm ? 'text' : 'password'}
            value={confirm}
            onChange={(e) => setConfirm(e.target.value)}
            placeholder="Repite la contraseña"
            required
            minLength={6}
            className="w-full bg-theme-input border border-theme-input-border rounded-lg pl-10 pr-10 py-2.5 text-sm text-theme-text placeholder-theme-text-tertiary focus:outline-none focus-visible:ring-2 focus-visible:ring-violet-500 focus-visible:ring-offset-2 focus-visible:ring-offset-[var(--theme-bg)] focus:border-violet-500 transition-colors"
          />
          <button
            type="button"
            onClick={() => setShowConfirm(!showConfirm)}
            className="absolute right-3.5 top-1/2 -translate-y-1/2 text-theme-text-tertiary hover:text-theme-text-secondary transition-colors cursor-pointer"
          >
            {showConfirm ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
          </button>
        </div>
      </div>

      <label className="flex items-start gap-2.5 cursor-pointer group pt-1">
        <div
          onClick={() => setAccepted(!accepted)}
          className={`mt-0.5 w-4 h-4 rounded border flex items-center justify-center transition-all shrink-0 cursor-pointer ${
            accepted
              ? 'bg-violet-600 border-violet-600'
              : 'border-theme-input-border group-hover:border-theme-text-tertiary'
          }`}
        >
          {accepted && <Check className="w-3 h-3 text-white" aria-hidden="true" />}
        </div>
        <span className="text-xs text-theme-text-secondary group-hover:text-theme-text transition-colors leading-relaxed">
          Acepto los{' '}
          <span className="text-violet-500 hover:text-violet-400 underline underline-offset-2 decoration-theme-border">
            Términos y Condiciones
          </span>{' '}
          y la{' '}
          <span className="text-violet-500 hover:text-violet-400 underline underline-offset-2 decoration-theme-border">
            Política de Privacidad
          </span>
        </span>
      </label>

      <button
        type="submit"
        disabled={!accepted || loading}
        className="w-full py-2.5 bg-violet-600 hover:bg-violet-500 disabled:bg-violet-600/40 disabled:cursor-not-allowed text-white text-sm font-medium rounded-lg transition-all duration-200 cursor-pointer active:scale-[0.98] flex items-center justify-center gap-2"
      >
        {loading ? <Loader2 className="w-4 h-4 animate-spin" aria-hidden="true" /> : null}
        {loading ? 'Creando cuenta...' : 'Crear Cuenta'}
      </button>

      <p className="text-center text-sm text-theme-text-tertiary">
        ¿Ya tienes cuenta?{' '}
        <button type="button" onClick={() => navigate('/login')} className="text-violet-500 hover:text-violet-400 transition-colors cursor-pointer">
          Inicia sesión
        </button>
      </p>
    </form>
  )
}
