import { Navigate, Outlet } from 'react-router-dom'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { useAuth } from './contexts/AuthContext'
import MainLayout from './components/MainLayout'
import HomePage from './pages/HomePage'
import AuthPage from './pages/AuthPage'
import InicioPage from './pages/InicioPage'
import AprenderPage from './pages/AprenderPage'
import MisFinanzasPage from './pages/MisFinanzasPage'
import RetosPage from './pages/RetosPage'
import PerfilPage from './pages/PerfilPage'
import { Loader2 } from 'lucide-react'

function ProtectedRoute() {
  const { user, loading } = useAuth()

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-[var(--gradient-from)] via-[var(--gradient-via)] to-[var(--gradient-to)] flex items-center justify-center">
        <Loader2 className="w-8 h-8 text-violet-500 animate-spin" aria-hidden="true" />
      </div>
    )
  }

  if (!user) return <Navigate to="/login" replace />
  return <Outlet />
}

function PublicRoute({ children }: { children: React.ReactNode }) {
  const { user, loading } = useAuth()

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-[var(--gradient-from)] via-[var(--gradient-via)] to-[var(--gradient-to)] flex items-center justify-center">
        <Loader2 className="w-8 h-8 text-violet-500 animate-spin" aria-hidden="true" />
      </div>
    )
  }

  if (user) return <Navigate to="/inicio" replace />
  return <>{children}</>
}

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<PublicRoute><HomePage /></PublicRoute>} />
        <Route path="/login" element={<PublicRoute><AuthPage initialMode="login" /></PublicRoute>} />
        <Route path="/register" element={<PublicRoute><AuthPage initialMode="register" /></PublicRoute>} />

        {/* Rutas protegidas con layout persistente */}
        <Route element={<ProtectedRoute />}>
          <Route element={<MainLayout />}>
            <Route path="/inicio" element={<InicioPage />} />
            <Route path="/aprender" element={<AprenderPage />} />
            <Route path="/mis-finanzas" element={<MisFinanzasPage />} />
            <Route path="/retos" element={<RetosPage />} />
            <Route path="/perfil" element={<PerfilPage />} />
          </Route>
        </Route>

        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </BrowserRouter>
  )
}

export default App
