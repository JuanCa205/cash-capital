interface ProgressBarProps {
  percent: number
  size?: 'sm' | 'md' | 'lg'
  color?: 'violet' | 'emerald' | 'amber' | 'red'
  className?: string
}

const sizeMap: Record<string, string> = {
  sm: 'h-1.5',
  md: 'h-2',
  lg: 'h-3',
}

const colorMap: Record<string, string> = {
  violet: 'bg-gradient-to-r from-violet-500 to-fuchsia-500',
  emerald: 'bg-emerald-500',
  amber: 'bg-amber-500',
  red: 'bg-red-500',
}

export default function ProgressBar({ percent, size = 'md', color = 'violet', className = '' }: ProgressBarProps) {
  return (
    <div className={`${sizeMap[size]} bg-theme-muted rounded-full overflow-hidden ${className}`}>
      <div
        className={`h-full ${colorMap[color]} rounded-full transition-all duration-500`}
        style={{ width: `${Math.min(Math.max(percent, 0), 100)}%` }}
      />
    </div>
  )
}
