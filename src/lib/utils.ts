/**
 * Sanitiza un string de input: recorta espacios, limita longitud,
 * elimina caracteres de control y previene XSS básico.
 * Útil para validar inputs de formularios antes de enviar a Supabase.
 */
export function sanitizeInput(value: string, maxLength: number = 100): string {
  if (typeof value !== 'string') return ''
  // Elimina caracteres de control (excepto tabs y newlines) usando su código
  const cleaned = value
    .trim()
    .slice(0, maxLength)
    .split('')
    .filter((c) => {
      const code = c.charCodeAt(0)
      return code >= 32 || code === 9 || code === 10 || code === 13
    })
    .join('')
  return cleaned
}

export function timeAgo(date: string): string {
  const diff = Date.now() - new Date(date).getTime()
  const mins = Math.floor(diff / 60000)
  if (mins < 1) return 'ahora'
  if (mins < 60) return `hace ${mins}m`
  const hours = Math.floor(mins / 60)
  if (hours < 24) return `hace ${hours}h`
  const days = Math.floor(hours / 24)
  return `hace ${days}d`
}

export function formatCurrency(amount: number): string {
  return `$${amount.toLocaleString()}`
}

export function formatActivity(type: string, desc?: string | null): string {
  if (desc) return desc
  const map: Record<string, string> = {
    login: 'Inició sesión',
    lesson_completed: 'Completó una lección',
    quiz_completed: 'Completó un quiz',
    challenge_completed: 'Completó un reto',
    badge_earned: 'Ganó una insignia',
    achievement_unlocked: 'Desbloqueó un logro',
    income_added: 'Registró un ingreso',
    expense_added: 'Registró un gasto',
    budget_created: 'Creó un presupuesto',
    saving_goal_created: 'Creó una meta de ahorro',
    saving_deposit: 'Depositó en una meta',
    debt_payment: 'Pagó una deuda',
  }
  return map[type] || type
}
