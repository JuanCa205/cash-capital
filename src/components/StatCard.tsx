import { type LucideIcon } from 'lucide-react'

interface StatCardProps {
  icon: LucideIcon
  label: string
  value: string
  sub: string
  color: 'violet' | 'orange' | 'green' | 'red'
}

const colorMap: Record<string, string> = {
  violet: 'from-violet-500/20 to-violet-600/10 text-violet-400',
  orange: 'from-orange-500/20 to-orange-600/10 text-orange-400',
  green: 'from-emerald-500/20 to-emerald-600/10 text-emerald-400',
  red: 'from-red-500/20 to-red-600/10 text-red-400',
}

export default function StatCard({ icon: Icon, label, value, sub, color }: StatCardProps) {
  return (
    <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 border">
      <div className={`inline-flex p-2 rounded-lg bg-gradient-to-br ${colorMap[color]} mb-2`}>
        <Icon className="w-4 h-4" aria-hidden="true" />
      </div>
      <p className="text-2xl font-heading font-bold text-theme-text">{value}</p>
      <p className="text-xs text-theme-text-secondary mt-0.5">{label}</p>
      <p className="text-[10px] text-theme-text-tertiary">{sub}</p>
    </div>
  )
}
