import type { Difficulty } from '../types/database'

interface DifficultyBadgeProps {
  difficulty: Difficulty
}

const config: Record<Difficulty, { label: string; classes: string }> = {
  basic: { label: 'Básico', classes: 'bg-emerald-500/15 text-emerald-400' },
  intermediate: { label: 'Intermedio', classes: 'bg-amber-500/15 text-amber-400' },
  advanced: { label: 'Avanzado', classes: 'bg-red-500/15 text-red-400' },
}

export default function DifficultyBadge({ difficulty }: DifficultyBadgeProps) {
  const { label, classes } = config[difficulty]
  return (
    <span className={`text-[10px] px-1.5 py-0.5 rounded-full ${classes}`}>
      {label}
    </span>
  )
}
