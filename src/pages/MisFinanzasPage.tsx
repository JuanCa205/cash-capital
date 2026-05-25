import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from '../contexts/AuthContext'
import MainLayout from '../components/MainLayout'
import MiniCard from '../components/MiniCard'
import { Wallet, TrendingUp, TrendingDown, PiggyBank, CreditCard, Target } from 'lucide-react'
import type { Income, Expense, Budget, SavingGoal, Debt } from '../types/database'

export default function MisFinanzasPage() {
  const { user } = useAuth()
  const [incomes, setIncomes] = useState<Income[]>([])
  const [expenses, setExpenses] = useState<Expense[]>([])
  const [budgets, setBudgets] = useState<Budget[]>([])
  const [savings, setSavings] = useState<SavingGoal[]>([])
  const [debts, setDebts] = useState<Debt[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    let cancelled = false

    const loadData = async () => {
      try {
        const now = new Date()
        const monthStart = new Date(now.getFullYear(), now.getMonth(), 1).toISOString().split('T')[0]
        const monthEnd = new Date(now.getFullYear(), now.getMonth() + 1, 0).toISOString().split('T')[0]

        const [
          { data: incomeData },
          { data: expenseData },
          { data: budgetData },
          { data: savingData },
          { data: debtData },
        ] = await Promise.all([
          supabase.from('incomes').select('*, income_categories(*)').eq('user_id', user.id).gte('income_date', monthStart).lte('income_date', monthEnd).order('income_date', { ascending: false }).limit(5),
          supabase.from('expenses').select('*, expense_categories(*)').eq('user_id', user.id).gte('expense_date', monthStart).lte('expense_date', monthEnd).order('expense_date', { ascending: false }).limit(5),
          supabase.from('budgets').select('*').eq('user_id', user.id).limit(3),
          supabase.from('savings_goals').select('*').eq('user_id', user.id).eq('status', 'active').limit(3),
          supabase.from('debts').select('*').eq('user_id', user.id).eq('status', 'active').limit(3),
        ])

        if (cancelled) return

        if (incomeData) setIncomes(incomeData)
        if (expenseData) setExpenses(expenseData)
        if (budgetData) setBudgets(budgetData)
        if (savingData) setSavings(savingData)
        if (debtData) setDebts(debtData)
        setLoading(false)
      } catch (err) {
        if (!cancelled) {
          console.error('Error cargando finanzas:', err)
          setLoading(false)
        }
      }
    }

    loadData()
    return () => { cancelled = true }
  }, [user])

  const totalIncome = incomes.reduce((s, i) => s + Number(i.amount), 0)
  const totalExpense = expenses.reduce((s, e) => s + Number(e.amount), 0)
  const balance = totalIncome - totalExpense

  if (loading) {
    return (
      <MainLayout>
        <div className="space-y-6">
          <div className="animate-pulse space-y-4">
            <div className="h-8 bg-theme-muted rounded w-1/3" />
            <div className="h-4 bg-theme-muted rounded w-1/4" />
          </div>
          <div className="grid grid-cols-3 gap-3 md:gap-4">
            {[1, 2, 3].map((i) => (
              <div key={i} className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 border animate-pulse">
                <div className="h-6 bg-theme-muted rounded w-1/2 mb-2" />
                <div className="h-4 bg-theme-muted rounded w-1/3" />
              </div>
            ))}
          </div>
          <div className="grid md:grid-cols-2 gap-4">
            {[1, 2].map((i) => (
              <div key={i} className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border animate-pulse">
                <div className="h-5 bg-theme-muted rounded w-1/3 mb-4" />
                {[1, 2, 3].map((j) => (
                  <div key={j} className="h-4 bg-theme-muted rounded w-full mb-2" />
                ))}
              </div>
            ))}
          </div>
        </div>
      </MainLayout>
    )
  }

  return (
    <MainLayout>
      <div className="space-y-6">
        <div>
          <h1 className="font-heading text-2xl font-bold text-theme-text">Mis Finanzas</h1>
          <p className="text-theme-text-secondary text-sm mt-1">Controla tus ingresos, gastos y más</p>
        </div>

        <div className="grid grid-cols-3 gap-3 md:gap-4">
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 border">
            <TrendingUp className="w-4 h-4 text-emerald-400 mb-1" aria-hidden="true" />
            <p className="text-lg font-heading font-bold text-theme-text">${totalIncome.toLocaleString()}</p>
            <p className="text-[10px] text-theme-text-secondary">Ingresos</p>
          </div>
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 border">
            <TrendingDown className="w-4 h-4 text-red-400 mb-1" aria-hidden="true" />
            <p className="text-lg font-heading font-bold text-theme-text">${totalExpense.toLocaleString()}</p>
            <p className="text-[10px] text-theme-text-secondary">Gastos</p>
          </div>
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-4 border">
            <Wallet className={`w-4 h-4 mb-1 ${balance >= 0 ? 'text-emerald-400' : 'text-red-400'}`} aria-hidden="true" />
            <p className="text-lg font-heading font-bold text-theme-text">${Math.abs(balance).toLocaleString()}</p>
            <p className="text-[10px] text-theme-text-secondary">{balance >= 0 ? 'Disponible' : 'Déficit'}</p>
          </div>
        </div>

        <div className="grid md:grid-cols-2 gap-4">
          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
            <div className="flex items-center justify-between mb-3">
              <div className="flex items-center gap-2">
                <TrendingUp className="w-4 h-4 text-emerald-500" aria-hidden="true" />
                <h2 className="font-heading font-semibold text-sm text-theme-text">Últimos Ingresos</h2>
              </div>
              <span className="text-xs text-violet-500 hover:text-violet-400 cursor-pointer transition-all duration-200 px-2 py-1 rounded-lg hover:bg-violet-600/10 active:scale-[0.95]">+ Nuevo</span>
            </div>
            {incomes.length === 0 ? (
              <p className="text-sm text-theme-text-secondary py-3 text-center">Sin ingresos este mes</p>
            ) : (
              <div className="space-y-2">
                {incomes.map((i) => (
                  <div key={i.id} className="flex items-center justify-between text-sm py-1.5">
                    <span className="text-theme-text truncate">{i.description || 'Ingreso'}</span>
                    <span className="text-emerald-400 font-medium shrink-0 ml-2">+${Number(i.amount).toLocaleString()}</span>
                  </div>
                ))}
              </div>
            )}
          </div>

          <div className="bg-theme-surface backdrop-blur-xl rounded-xl p-5 border">
            <div className="flex items-center justify-between mb-3">
              <div className="flex items-center gap-2">
                <TrendingDown className="w-4 h-4 text-red-500" aria-hidden="true" />
                <h2 className="font-heading font-semibold text-sm text-theme-text">Últimos Gastos</h2>
              </div>
              <span className="text-xs text-violet-500 hover:text-violet-400 cursor-pointer transition-all duration-200 px-2 py-1 rounded-lg hover:bg-violet-600/10 active:scale-[0.95]">+ Nuevo</span>
            </div>
            {expenses.length === 0 ? (
              <p className="text-sm text-theme-text-secondary py-3 text-center">Sin gastos este mes</p>
            ) : (
              <div className="space-y-2">
                {expenses.map((e) => (
                  <div key={e.id} className="flex items-center justify-between text-sm py-1.5">
                    <span className="text-theme-text truncate">{e.description || 'Gasto'}</span>
                    <span className="text-red-400 font-medium shrink-0 ml-2">-${Number(e.amount).toLocaleString()}</span>
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>

        <div className="grid md:grid-cols-3 gap-4">
          <MiniCard icon={PiggyBank} title="Metas de Ahorro" items={savings.map((s) => ({
            label: s.name,
            value: `${Math.round((Number(s.current_amount) / Number(s.target_amount)) * 100)}% · $${Number(s.current_amount).toLocaleString()}`,
            progress: (Number(s.current_amount) / Number(s.target_amount)) * 100,
          }))} empty="Sin metas de ahorro" />

          <MiniCard icon={CreditCard} title="Deudas Activas" items={debts.map((d) => ({
            label: d.name,
            value: `$${Number(d.current_balance).toLocaleString()} · ${d.debt_type}`,
            progress: ((Number(d.original_amount) - Number(d.current_balance)) / Number(d.original_amount)) * 100,
          }))} empty="Sin deudas activas" />

          <MiniCard icon={Target} title="Presupuestos" items={budgets.map((b) => ({
            label: b.name,
            value: `$${Number(b.total_amount).toLocaleString()} · ${b.period_type}`,
            progress: 0,
          }))} empty="Sin presupuestos" />
        </div>
      </div>
    </MainLayout>
  )
}


