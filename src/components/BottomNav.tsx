import { NavLink } from 'react-router-dom'
import { LayoutDashboard, BookOpen, Wallet, Trophy, User } from 'lucide-react'

const items = [
  { to: '/mis-finanzas', icon: Wallet, label: 'Finanzas' },
  { to: '/aprender', icon: BookOpen, label: 'Aprender' },
  { to: '/inicio', icon: LayoutDashboard, label: 'Inicio' },
  { to: '/retos', icon: Trophy, label: 'Retos' },
  { to: '/perfil', icon: User, label: 'Perfil' },
]

export default function BottomNav() {
  return (
    <nav className="md:hidden fixed bottom-0 left-0 right-0 bg-theme-surface backdrop-blur-2xl border-t z-40 safe-area-bottom">
      <div className="flex items-center justify-around px-2 py-1">
        {items.map((item) => (
          <NavLink
            key={item.to}
            to={item.to}
            aria-label={item.label}
            className={({ isActive }) =>
              `flex flex-col items-center gap-0.5 px-3 py-2 rounded-xl transition-all duration-200 cursor-pointer min-w-0 ${
                isActive
                  ? 'text-violet-500'
                  : 'text-theme-text-tertiary hover:text-theme-text-secondary'
              }`
            }
          >
            {({ isActive }: { isActive: boolean }) => (
              <>
                <div className={`flex items-center justify-center w-10 h-10 rounded-full transition-all duration-200 ${
                  isActive ? 'bg-violet-600' : ''
                }`}>
                  <item.icon className={`transition-all duration-200 ${
                    isActive ? 'w-6 h-6 text-white' : 'w-5 h-5'
                  }`} aria-hidden="true" />
                </div>
                <span className="text-[10px] font-medium leading-tight">{item.label}</span>
              </>
            )}
          </NavLink>
        ))}
      </div>
    </nav>
  )
}
