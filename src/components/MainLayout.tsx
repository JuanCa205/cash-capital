import { useNavigate, Outlet } from 'react-router-dom'
import { PiggyBank, LogOut } from 'lucide-react'
import { useAuth } from '../contexts/AuthContext'
import ThemeToggle from './ThemeToggle'
import Sidebar from './Sidebar'
import BottomNav from './BottomNav'

export default function MainLayout() {
  const { profile, logout } = useAuth()
  const navigate = useNavigate()

  const handleLogout = async () => {
    await logout()
    navigate('/login')
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-[var(--gradient-from)] via-[var(--gradient-via)] to-[var(--gradient-to)] font-body">
      <Sidebar />
      <BottomNav />

      <div className="md:ml-16 pb-16 md:pb-0">
        <header className="sticky top-0 bg-theme-surface backdrop-blur-2xl border-b z-30">
          <div className="flex items-center justify-between px-4 md:px-6 h-16">
            <div className="flex items-center gap-3 md:hidden">
              <div className="p-1.5 bg-violet-600/20 rounded-lg">
                <PiggyBank className="w-5 h-5 text-violet-400" aria-hidden="true" />
              </div>
              <span className="font-heading text-lg font-bold text-theme-text">Cash Capital</span>
            </div>
            <div className="flex-1" />

            <div className="flex items-center gap-3">
              <ThemeToggle />
              <div className="flex items-center gap-2.5">
                <div className="w-8 h-8 rounded-full bg-violet-600 flex items-center justify-center text-white text-sm font-medium shrink-0">
                  {profile?.first_name?.[0]?.toUpperCase() || 'U'}
                </div>
                <span className="hidden sm:inline text-sm font-medium text-theme-text">
                  {profile?.first_name || 'Usuario'}
                </span>
              </div>
              <button
                onClick={handleLogout}
                className="p-2 rounded-lg text-theme-text-tertiary hover:text-red-400 hover:bg-theme-muted transition-all duration-200 cursor-pointer"
                title="Cerrar sesión"
                aria-label="Cerrar sesión"
              >
                <LogOut className="w-4 h-4" />
              </button>
            </div>
          </div>
        </header>

        <main className="p-4 md:p-6 lg:p-8 max-w-7xl mx-auto">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
