import { useLayoutEffect, useRef, useState } from 'react'
import { NavLink, useLocation } from 'react-router-dom'
import { LayoutDashboard, BookOpen, Wallet, Trophy, User } from 'lucide-react'

const items = [
  { to: '/mis-finanzas', icon: Wallet, label: 'Finanzas' },
  { to: '/aprender', icon: BookOpen, label: 'Aprender' },
  { to: '/inicio', icon: LayoutDashboard, label: 'Inicio' },
  { to: '/retos', icon: Trophy, label: 'Retos' },
  { to: '/perfil', icon: User, label: 'Perfil' },
]

export default function BottomNav() {
  const location = useLocation()
  const navRef = useRef<HTMLDivElement>(null)
  const itemRefs = useRef<(HTMLAnchorElement | null)[]>([])
  const [indicator, setIndicator] = useState({ left: 0, width: 0 })
  const [mounted, setMounted] = useState(false)

  const activeIndex = items.findIndex((item) => location.pathname === item.to)

  useLayoutEffect(() => {
    const idx = activeIndex >= 0 ? activeIndex : 2
    const el = itemRefs.current[idx]
    if (el) {
      setIndicator({
        left: el.offsetLeft,
        width: el.offsetWidth,
      })
    }
    setMounted(true)
  }, [activeIndex])

  return (
    <nav className="md:hidden fixed bottom-0 left-0 right-0 bg-theme-surface backdrop-blur-2xl border-t z-40 safe-area-bottom">
      <div ref={navRef} className="relative flex items-center justify-around px-2 py-1">
        {/* Indicador deslizante horizontal — sin transición en montaje */}
        <div
          className={`absolute top-1 bottom-1 bg-violet-600/15 rounded-xl z-0 pointer-events-none ${
            mounted ? 'transition-all duration-300 ease-out' : ''
          }`}
          style={{ left: `${indicator.left}px`, width: `${indicator.width}px` }}
        />

        {items.map((item, i) => (
          <NavLink
            key={item.to}
            ref={(el) => { itemRefs.current[i] = el }}
            to={item.to}
            aria-label={item.label}
            className={({ isActive }) =>
              `relative flex flex-col items-center gap-0.5 px-3 py-2 rounded-xl transition-all duration-200 cursor-pointer min-w-0 z-10 ${
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
