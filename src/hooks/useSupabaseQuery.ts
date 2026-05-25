import { useState, useEffect, useCallback } from 'react'

interface PostgrestErrorLike {
  message: string
}

interface UseSupabaseQueryResult<T> {
  data: T | null
  loading: boolean
  error: string | null
  refetch: () => void
}

/**
 * Hook genérico para encapsular el patrón de fetch desde Supabase.
 *
 * Maneja automáticamente los estados loading, data y error,
 * incluye cleanup para evitar actualizaciones en componentes desmontados
 * y un refetch para recarga manual.
 *
 * @param query - Función asíncrona que ejecuta la consulta a Supabase.
 *                Debe retornar `{ data: T | null; error: PostgrestErrorLike | null }`.
 * @param deps  - Array de dependencias para el useEffect.
 *
 * @returns { data, loading, error, refetch }
 *
 * @example
 * const { data, loading, error } = useSupabaseQuery(
 *   () => supabase.from('incomes').select('*').eq('user_id', user.id),
 *   [user]
 * )
 */
export function useSupabaseQuery<T>(
  query: () => Promise<{
    data: T | null
    error: PostgrestErrorLike | null
  }>,
  deps: React.DependencyList = []
): UseSupabaseQueryResult<T> {
  const [data, setData] = useState<T | null>(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [refreshKey, setRefreshKey] = useState(0)

  useEffect(() => {
    let cancelled = false

    const run = async () => {
      setLoading(true)
      setError(null)

      try {
        const { data: result, error: queryError } = await query()

        if (cancelled) return

        if (queryError) {
          setError(queryError.message || 'Error al ejecutar la consulta')
          setData(null)
        } else {
          setData(result)
        }
      } catch (err: unknown) {
        if (cancelled) return
        const message =
          err instanceof Error ? err.message : 'Error inesperado en la consulta'
        setError(message)
        setData(null)
      } finally {
        if (!cancelled) {
          setLoading(false)
        }
      }
    }

    run()

    return () => {
      cancelled = true
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [...deps, refreshKey])

  const refetch = useCallback(() => {
    setRefreshKey((k) => k + 1)
  }, [])

  return { data, loading, error, refetch }
}
