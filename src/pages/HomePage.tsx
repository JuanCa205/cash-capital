import { PiggyBank, ArrowRight, Sparkles, Trophy, BookOpen } from 'lucide-react'
import { useNavigate } from 'react-router-dom'
import ThemeToggle from '../components/ThemeToggle'

export default function HomePage() {
  const navigate = useNavigate()

  return (
    <div className="min-h-screen bg-gradient-to-br from-[var(--gradient-from)] via-[var(--gradient-via)] to-[var(--gradient-to)] font-body">
      <div className="max-w-6xl mx-auto px-6 py-12">
        <header className="flex items-center justify-between mb-24">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-violet-600/20 rounded-xl">
              <PiggyBank className="w-6 h-6 text-violet-400" aria-hidden="true" />
            </div>
            <span className="font-heading text-xl font-bold text-theme-text">Cash Capital</span>
          </div>
          <div className="flex items-center gap-2">
            <ThemeToggle />
            <button
              onClick={() => navigate('/login')}
              className="px-5 py-2 text-sm text-theme-text-secondary hover:text-theme-text transition-colors cursor-pointer"
            >
              Iniciar Sesión
            </button>
            <button
              onClick={() => navigate('/register')}
              className="px-5 py-2 text-sm bg-violet-600 hover:bg-violet-500 text-white rounded-lg transition-all duration-200 cursor-pointer active:scale-[0.98]"
            >
              Empezar
            </button>
          </div>
        </header>

        <section className="text-center mb-32">
          <div className="inline-flex items-center gap-2 px-4 py-1.5 bg-violet-600/10 border border-violet-600/20 rounded-full text-sm text-violet-300 mb-6">
            <Sparkles className="w-4 h-4" aria-hidden="true" />
            <span>Aprende finanzas jugando</span>
          </div>
          <h1 className="font-heading text-5xl sm:text-6xl font-bold text-theme-text leading-tight mb-6">
            Tu viaje financiero
            <br />
            <span className="text-transparent bg-clip-text bg-gradient-to-r from-violet-400 to-fuchsia-400">
              comienza aquí
            </span>
          </h1>
          <p className="text-theme-text-secondary text-lg max-w-xl mx-auto mb-10 leading-relaxed">
            Domina tus finanzas personales con lecciones interactivas, desafíos divertidos y un sistema de logros que te mantendrá motivado.
          </p>
          <button
            onClick={() => navigate('/register')}
            className="inline-flex items-center gap-2 px-8 py-3 bg-violet-600 hover:bg-violet-500 text-white font-medium rounded-xl transition-all duration-200 cursor-pointer active:scale-[0.98]"
          >
            Comienza Gratis
            <ArrowRight className="w-4 h-4" aria-hidden="true" />
          </button>
        </section>

        <section className="grid md:grid-cols-3 gap-6 mb-24">
          {[
            {
              icon: BookOpen,
              title: 'Lecciones Interactivas',
              desc: 'Aprende desde presupuestos hasta inversiones con contenido dinámico y fácil de entender.',
            },
            {
              icon: Trophy,
              title: 'Desafíos y Logros',
              desc: 'Gana puntos, sube de nivel y desbloquea insignias mientras avanzas en tu educación financiera.',
            },
            {
              icon: Sparkles,
              title: 'Gamificación Total',
              desc: 'Competencia amigable con leaderboards y rachas que hacen del aprendizaje un hábito diario.',
            },
          ].map((feature) => (
            <div
              key={feature.title}
              className="bg-theme-surface backdrop-blur-xl rounded-2xl p-6 border hover:border-violet-500/30 transition-all duration-300"
            >
              <div className="p-2.5 bg-violet-600/15 rounded-xl w-fit mb-4">
                <feature.icon className="w-5 h-5 text-violet-400" aria-hidden="true" />
              </div>
              <h3 className="font-heading text-lg font-semibold text-theme-text mb-2">{feature.title}</h3>
              <p className="text-theme-text-secondary text-sm leading-relaxed">{feature.desc}</p>
            </div>
          ))}
        </section>
      </div>
    </div>
  )
}
