import { useEffect, useLayoutEffect, useRef, useState } from 'react'
import { NavLink, useLocation } from 'react-router-dom'
import { LayoutDashboard, BookOpen, Wallet, Trophy, User } from 'lucide-react'

const items = [
  { to: '/inicio', icon: LayoutDashboard, label: 'Inicio' },
  { to: '/aprender', icon: BookOpen, label: 'Aprender' },
  { to: '/mis-finanzas', icon: Wallet, label: 'Mis Finanzas' },
  { to: '/retos', icon: Trophy, label: 'Retos' },
  { to: '/perfil', icon: User, label: 'Perfil' },
]

export default function Sidebar() {
  const location = useLocation()
  const navRef = useRef<HTMLDivElement>(null)
  const itemRefs = useRef<(HTMLAnchorElement | null)[]>([])
  const [indicator, setIndicator] = useState({ top: 0, height: 0 })
  const [mounted, setMounted] = useState(false)

  const activeIndex = items.findIndex((item) => location.pathname === item.to)

  // Sincrónico: mide antes del primer pintado para evitar salto desde 0
  useLayoutEffect(() => {
    const idx = activeIndex >= 0 ? activeIndex : 0
    const el = itemRefs.current[idx]
    if (el) {
      setIndicator({
        top: el.offsetTop,
        height: el.offsetHeight,
      })
    }
    setMounted(true)
  }, [activeIndex])

  // Asíncrono: re-mide si cambia el tamaño del sidebar (hover expand/contract)
  useEffect(() => {
    if (!mounted) return
    const idx = activeIndex >= 0 ? activeIndex : 0
    const el = itemRefs.current[idx]
    if (el) {
      setIndicator({
        top: el.offsetTop,
        height: el.offsetHeight,
      })
    }
  }, [mounted, activeIndex])

  return (
    <aside className="hidden md:flex flex-col fixed left-0 top-0 bottom-0 w-16 bg-theme-surface backdrop-blur-2xl border-r z-40 transition-all duration-300 group hover:w-56 overflow-hidden">
      <div className="flex items-center justify-center lg:justify-start h-16 px-4 border-b overflow-hidden gap-0 group-hover:gap-3">
        <span className="font-heading text-lg font-bold text-theme-text transition-all duration-300 opacity-100 shrink-0 group-hover:opacity-0">
          CC
        </span>
        <span className="font-heading text-lg font-bold text-theme-text transition-all duration-300 opacity-0 max-w-0 group-hover:opacity-100 group-hover:max-w-40 whitespace-nowrap overflow-hidden">
          Cash Capital
        </span>
      </div>

      <nav ref={navRef} className="relative flex-1 flex flex-col gap-1 p-2 mt-2">
        {/* Indicador deslizante — sin transición en montaje inicial */}
        <div
          className={`absolute left-2 right-2 bg-violet-600 rounded-xl z-0 pointer-events-none ${
            mounted ? 'transition-all duration-300 ease-out' : ''
          }`}
          style={{ top: `${indicator.top}px`, height: `${indicator.height}px` }}
        />

        {items.map((item, i) => (
          <NavLink
            key={item.to}
            ref={(el) => { itemRefs.current[i] = el }}
            to={item.to}
            className={({ isActive }) =>
              `relative flex items-center justify-center lg:justify-start gap-0 group-hover:gap-3 px-3 py-3 rounded-xl transition-all duration-200 cursor-pointer z-10 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-violet-500 focus-visible:ring-offset-2 focus-visible:ring-offset-[var(--theme-bg)] ${
                isActive
                  ? 'text-white'
                  : 'text-theme-text-secondary hover:text-theme-text hover:bg-theme-muted/50'
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
