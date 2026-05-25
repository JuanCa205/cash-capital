import { NavLink } from 'react-router-dom'
import { LayoutDashboard, BookOpen, Wallet, Trophy, User } from 'lucide-react'

const items = [
  { to: '/inicio', icon: LayoutDashboard, label: 'Inicio' },
  { to: '/aprender', icon: BookOpen, label: 'Aprender' },
  { to: '/mis-finanzas', icon: Wallet, label: 'Mis Finanzas' },
  { to: '/retos', icon: Trophy, label: 'Retos' },
  { to: '/perfil', icon: User, label: 'Perfil' },
]

export default function Sidebar() {
  return (
    <aside className="hidden md:flex flex-col fixed left-0 top-0 bottom-0 w-16 bg-theme-surface backdrop-blur-2xl border-r z-40 transition-all duration-300 group hover:w-56 overflow-hidden">
      <div className="relative flex items-center justify-center lg:justify-start h-16 px-4 border-b overflow-hidden">
        <span className="font-heading text-lg font-bold text-theme-text transition-all duration-300 opacity-0 max-w-0 group-hover:opacity-100 group-hover:max-w-40 whitespace-nowrap overflow-hidden">
          Cash Capital
        </span>
        <span className="absolute left-4 font-heading text-lg font-bold text-theme-text transition-all duration-300 opacity-100 max-w-8 group-hover:opacity-0 group-hover:max-w-0 overflow-hidden whitespace-nowrap">
          CC
        </span>
      </div>
      <nav className="flex-1 flex flex-col gap-1 p-2 mt-2">
        {items.map((item) => (
          <NavLink
            key={item.to}
            to={item.to}
            className={({ isActive }) =>
  `flex items-center justify-center lg:justify-start gap-3 px-3 py-3 rounded-xl transition-all duration-200 cursor-pointer focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-violet-500 focus-visible:ring-offset-2 focus-visible:ring-offset-[var(--theme-bg)] ${
    isActive
      ? 'bg-violet-600 text-white'
      : 'text-theme-text-secondary hover:text-theme-text hover:bg-theme-muted'
  }`
            }
          >
            <item.icon className="w-5 h-5 shrink-0" aria-hidden="true" />
            <span className="text-sm font-medium whitespace-nowrap transition-all duration-300 opacity-0 max-w-0 group-hover:opacity-100 group-hover:max-w-40 overflow-hidden">
              {item.label}
            </span>
          </NavLink>
        ))}
      </nav>
    </aside>
  )
}
