import { type LucideIcon } from 'lucide-react'

interface SectionCardProps {
  title: string
  icon: LucideIcon
  children: React.ReactNode
}

export default function SectionCard({ title, icon: Icon, children }: SectionCardProps) {
  return (
    <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 md:p-5 border">
      <div className="flex items-center gap-2 mb-3">
        <Icon className="w-4 h-4 text-violet-500" aria-hidden="true" />
        <h2 className="font-heading font-semibold text-sm text-theme-text">{title}</h2>
      </div>
      {children}
    </div>
  )
}
