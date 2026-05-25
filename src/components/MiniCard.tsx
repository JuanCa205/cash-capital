import { type LucideIcon } from 'lucide-react'
import ProgressBar from './ProgressBar'

interface MiniCardItem {
  label: string
  value: string
  progress: number
}

interface MiniCardProps {
  icon: LucideIcon
  title: string
  items: MiniCardItem[]
  empty: string
}

export default function MiniCard({ icon: Icon, title, items, empty }: MiniCardProps) {
  return (
    <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
      <div className="flex items-center gap-2 mb-3">
        <Icon className="w-4 h-4 text-violet-500" aria-hidden="true" />
        <h2 className="font-heading font-semibold text-sm text-theme-text">{title}</h2>
      </div>
      {items.length === 0 ? (
        <p className="text-sm text-theme-text-secondary py-3 text-center">{empty}</p>
      ) : (
        <div className="space-y-3">
          {items.map((item, i) => (
            <div key={i}>
              <div className="flex justify-between text-sm mb-1">
                <span className="text-theme-text truncate">{item.label}</span>
                <span className="text-theme-text-secondary text-xs shrink-0 ml-2">{item.value}</span>
              </div>
              {item.progress > 0 && (
                <ProgressBar percent={item.progress} size="sm" color="violet" />
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
