import { type LucideIcon } from 'lucide-react'

interface EmptyStateProps {
  icon: LucideIcon
  message: string
  className?: string
}

export default function EmptyState({ icon: Icon, message, className = '' }: EmptyStateProps) {
  return (
    <div className={`text-center py-6 ${className}`}>
      <Icon className="w-12 h-12 text-theme-text-tertiary mx-auto mb-3" aria-hidden="true" />
      <p className="text-sm text-theme-text-secondary">{message}</p>
    </div>
  )
}
