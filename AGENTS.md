# Cash Capital — AGENTS.md

> Documento maestro para AI agents. Define stack, arquitectura, reglas y estado del proyecto.
> **Leer COMPLETO antes de cualquier tarea.**
> - `DB_SCHEMA.md` → operaciones de BD
> - `DESIGN.md` → sistema de diseño (CSS vars, Tailwind)
> - `COMPONENTS.md` → catálogo de componentes reutilizables

---

## 1. IDENTIDAD

| Campo | Valor |
|-------|-------|
| Proyecto | Cash Capital |
| Tipo | App web de gamificación financiera |
| Estado | Desarrollo activo (7/7 páginas implementadas con UI y datos) |
| Package manager | **`pnpm`** (NUNCA usar `npm`) |
| Servidor dev | `pnpm dev` → http://localhost:5173 |
| Supabase local | http://localhost:8000 |

---

## 2. STACK

| Capa | Tecnología |
|------|-----------|
| Frontend | React 19 + Vite 8 + TypeScript 6 |
| Routing | react-router-dom v7 |
| Estilos | Tailwind CSS 3.4 (sin CSS modules ni styled-components) |
| Fuentes | Google Fonts: **Fredoka** (headings) + **Nunito** (body) |
| Iconos | **Lucide React** (`import { Icon } from 'lucide-react'`) — NO emojis |
| Backend | Supabase (auth, BD PostgreSQL 15, almacenamiento) |
| BD schema | 41 tablas, 24 enums, 25 índices (→ `DB_SCHEMA.md`) |
| Auth | Supabase Auth (`auth.users`) + `user_profiles` (1:1) + `user_settings` (1:1) |
| Tipo theme | CSS Custom Properties + `data-theme="dark|light"` en `<html>` |
| Persistencia theme | `localStorage` key `cash-capital-theme` → fallback `prefers-color-scheme` |

---

## 3. ESTRUCTURA DEL PROYECTO

```
cash-capital/
├── src/
│   ├── components/            # 6 componentes reutilizables
│   │   ├── ThemeToggle.tsx     # Botón Sun/Moon (modo claro/oscuro)
│   │   ├── MainLayout.tsx     # Shell app: header fijo + sidebar + bottom nav + main
│   │   ├── Sidebar.tsx        # Nav lateral (visible md+), expandible en hover
│   │   ├── BottomNav.tsx      # Nav inferior fijo (solo mobile, md:hidden)
│   │   ├── StatCard.tsx       # Card de estadística con ícono y valor
│   │   └── SectionCard.tsx    # Card contenedor con título e ícono
│   ├── contexts/              # 2 React Contexts
│   │   ├── ThemeContext.tsx   # Tema dark/light con getInitialTheme()
│   │   └── AuthContext.tsx    # Session, user, profile, settings + login/register/logout
│   ├── pages/                 # 7 páginas
│   │   ├── HomePage.tsx       # Landing público con hero y 3 features
│   │   ├── AuthPage.tsx       # Login/Register toggle con slider animado
│   │   ├── InicioPage.tsx     # Dashboard protegido: stats, nivel, actividad, tips
│   │   ├── AprenderPage.tsx   # Módulos educativos con accordion y progreso
│   │   ├── MisFinanzasPage.tsx# Ingresos/gastos/mes, metas ahorro, deudas, presupuestos
│   │   ├── RetosPage.tsx      # Retos, logros, insignias, rachas, historial puntos
│   │   └── PerfilPage.tsx     # Datos personales, apariencia, configuración, metas, logout
│   ├── hooks/                 # 🟡 VACÍO — sin archivos aún
│   ├── lib/
│   │   ├── supabase.ts        # Cliente Supabase con fallback seguro (console.warn)
│   │   └── utils.ts           # Utilidades compartidas: timeAgo, formatCurrency, formatActivity
│   ├── types/
│   │   └── database.ts        # Interfaces TS para 41 tablas + 18 type enums
│   ├── styles/                # 🟡 VACÍO — sin archivos aún
│   ├── assets/                # 🟡 VACÍO — sin archivos aún
│   ├── App.tsx                # Router: 8 rutas con ProtectedRoute/PublicRoute
│   ├── main.tsx               # Entry: StrictMode > ThemeProvider > AuthProvider > App
│   └── index.css              # @tailwind directives + CSS custom properties (light/dark)
├── public/
│   └── icons.svg
├── supabase/                  # 🟡 NO EXISTE — migraciones SQL pendientes
├── DB_SCHEMA.md               # Esquema completo de BD (OBLIGATORIO leer)
├── AGENTS.md                  # ← ESTE DOCUMENTO
├── DESIGN.md                  # Sistema de diseño (CSS vars, Tailwind)
├── COMPONENTS.md              # Catálogo de componentes reutilizables
├── LINKS.md                   # URLs de navegación local
├── eslint.config.js           # ESLint flat config (typescript-eslint + react-hooks + react-refresh)
├── vite.config.ts             # Vite con @vitejs/plugin-react
├── tailwind.config.js         # Tailwind con theme personalizado (fonts + colors)
├── postcss.config.js          # PostCSS con tailwindcss + autoprefixer
├── .env                       # Credenciales Supabase local (gitignored)
├── .env.example               # Template .env
├── .gitignore
├── index.html                 # Entry HTML (lang="es")
├── package.json               # Dependencias (usar pnpm, no npm)
├── pnpm-lock.yaml             # Lockfile activo (usar pnpm)
├── tsconfig.json              # TS config base
├── tsconfig.app.json          # TS config app
└── tsconfig.node.json         # TS config node
```

### Directorios vacíos / pendientes
- `src/hooks/` → sin archivos
- `src/styles/` → sin archivos
- `src/assets/` → sin archivos
- `supabase/` → directorio no existe (sin migraciones, sin seeds)

---

## 4. ROUTING

### Mapa de rutas completo

| Ruta | Componente | Acceso | Layout | Descripción |
|------|-----------|--------|--------|-------------|
| `/` | `HomePage` | 🟢 Público | Sin layout | Landing con hero + features + CTA |
| `/login` | `AuthPage initialMode="login"` | 🟢 Público | Sin layout | Formulario login |
| `/register` | `AuthPage initialMode="register"` | 🟢 Público | Sin layout | Formulario registro |
| `/inicio` | `InicioPage` | 🔒 Protegido | `MainLayout` | Dashboard principal |
| `/aprender` | `AprenderPage` | 🔒 Protegido | `MainLayout` | Módulos y lecciones |
| `/mis-finanzas` | `MisFinanzasPage` | 🔒 Protegido | `MainLayout` | Control financiero |
| `/retos` | `RetosPage` | 🔒 Protegido | `MainLayout` | Retos y logros |
| `/perfil` | `PerfilPage` | 🔒 Protegido | `MainLayout` | Perfil y configuración |
| `*` | Redirect → `/` | — | — | Catch-all |

### Protección de rutas (`App.tsx`)

Dos wrappers:

**`ProtectedRoute`** (para rutas autenticadas):
- `loading` → `<Loader2 className="w-8 h-8 text-violet-500 animate-spin" />` centrado
- `!user` → `<Navigate to="/login" replace />`
- `user` existe → renderiza `children`

**`PublicRoute`** (para landing y auth):
- `loading` → spinner (mismo estilo)
- `user` existe → `<Navigate to="/inicio" replace />`
- `!user` → renderiza `children`

---

## 5. SISTEMA DE AUTENTICACIÓN

### AuthContext (`src/contexts/AuthContext.tsx`)

```typescript
interface AuthContextValue {
  session: Session | null
  user: User | null
  profile: UserProfile | null
  settings: UserSettings | null
  loading: boolean
  login(email: string, password: string): Promise<{ error: string | null }>
  register(email: string, password: string, firstName: string): Promise<{ error: string | null }>
  logout(): Promise<void>
}
```

**Provider tree** en `main.tsx`:
```
StrictMode > ThemeProvider > AuthProvider > App
```

**Flujo de login**: `supabase.auth.signInWithPassword({ email, password })` → devuelve `{ error }`.

**Flujo de registro**:
1. `supabase.auth.signUp({ email, password })`
2. Si éxito: insert en `user_profiles` (`user_id`, `first_name`, `last_name`)
3. Insert en `user_settings` (`user_id` con defaults)

**Flujo de logout**: `signOut()` → limpia `profile` y `settings` del estado local → redirect a `/login`.

**Error mapping** (`ERROR_MAP` en `AuthPage.tsx`):
```typescript
const ERROR_MAP: Record<string, string> = {
  'Invalid login credentials': 'Credenciales inválidas',
  'User already registered': 'Este correo ya está registrado',
  'Password should be at least 6 characters': 'La contraseña debe tener al menos 6 caracteres',
  'Email rate limit exceeded': 'Demasiados intentos, espera un momento',
  // ... ver AuthPage.tsx para el mapa completo
}
```

---

## 6. LAYOUT SYSTEM

### MainLayout (`src/components/MainLayout.tsx`)

Estructura visual:
```
┌──────────────────────────────────────────┐
│  Sidebar (md+)      │  Header            │
│  ┌──────────────┐   │  ┌──────────────┐   │
│  │ Logo / CC    │   │  │ ThemeToggle  │   │
│  │              │   │  │ Avatar + name │   │
│  │ Inicio       │   │  │ Logout btn   │   │
│  │ Aprender     │   │  └──────────────┘   │
│  │ Mis Finanzas │   │                     │
│  │ Retos        │   │  Main Content       │
│  │ Perfil       │   │  ┌──────────────┐   │
│  └──────────────┘   │  │  children    │   │
│                     │  │              │   │
│                     │  └──────────────┘   │
└──────────────────────────────────────────┘
│  BottomNav (solo mobile)                 │
└──────────────────────────────────────────┘
```

**Header**: `sticky top-0 bg-theme-surface backdrop-blur-2xl border-b z-30`
- Desktop: solo avatar + ThemeToggle + logout
- Mobile: logo "Cash Capital" + avatar + ThemeToggle + logout

**Main content**: `p-4 md:p-6 lg:p-8 max-w-7xl mx-auto`

**Margen responsive**: `md:ml-16 lg:ml-56 pb-16 md:pb-0`

### Sidebar (`src/components/Sidebar.tsx`)

| Propiedad | Valor |
|-----------|-------|
| Display | `hidden md:flex flex-col fixed left-0 top-0 bottom-0` |
| Width | `w-16` → `lg:w-56` (expande en hover con `group-hover`) |
| Background | `bg-theme-surface backdrop-blur-2xl border-r` |
| Z-index | `z-40` |

Ítems (5): `LayoutDashboard` (Inicio), `BookOpen` (Aprender), `Wallet` (Mis Finanzas), `Trophy` (Retos), `User` (Perfil)

`NavLink` con `isActive`:
- Activo: `bg-violet-600 text-white`
- Inactivo: `text-theme-text-secondary hover:text-theme-text hover:bg-theme-muted`

### BottomNav (`src/components/BottomNav.tsx`)

| Propiedad | Valor |
|-----------|-------|
| Display | `md:hidden fixed bottom-0 left-0 right-0` |
| Background | `bg-theme-surface backdrop-blur-2xl border-t` |
| Z-index | `z-40` |

**Ítems ORDEN DIFERENTE al Sidebar**: `Wallet` (Finanzas), `BookOpen` (Aprender), `LayoutDashboard` (Inicio - centro), `Trophy` (Retos), `User` (Perfil)

Patrón visual del ítem activo:
```tsx
<div className={`flex items-center justify-center w-10 h-10 rounded-full transition-all duration-200 ${
  isActive ? 'bg-violet-600' : ''
}`}>
  <item.icon className={`transition-all duration-200 ${
    isActive ? 'w-6 h-6 text-white' : 'w-5 h-5'
  }`} />
</div>
```

---

## 7. SISTEMA DE DISEÑO

> Ver `DESIGN.md` para CSS Custom Properties completas (dark/light) y configuración de Tailwind.

### Patrones visuales consistentes (usar SIEMPRE)

| Elemento | Clases Tailwind |
|----------|----------------|
| Fondo página | `bg-gradient-to-br from-[var(--gradient-from)] via-[var(--gradient-via)] to-[var(--gradient-to)]` |
| Card glassmorphism | `bg-theme-surface backdrop-blur-xl rounded-xl border` |
| Botón primario | `bg-violet-600 hover:bg-violet-500 text-white rounded-lg transition-all duration-200 cursor-pointer active:scale-[0.98]` |
| Botón deshabilitado | `bg-violet-600/40 cursor-not-allowed` |
| Input | `bg-theme-input border border-theme-input-border rounded-lg focus:outline-none focus:border-violet-500 focus:ring-1 focus:ring-violet-500/50 transition-colors` |
| Texto secundario | `text-theme-text-secondary` |
| Texto terciario | `text-theme-text-tertiary` |
| Link/CTA texto | `text-violet-500 hover:text-violet-400 transition-colors` |
| Badge dificultad básica | `bg-emerald-500/15 text-emerald-400` |
| Badge dificultad intermedia | `bg-amber-500/15 text-amber-400` |
| Badge dificultad avanzada | `bg-red-500/15 text-red-400` |
| Transición interactivos | `transition-all duration-200` |
| Skeleton loading | `bg-theme-muted rounded animate-pulse` |
| Estado vacío | Icono + "texto descriptivo" centrado |

---

## 8. PÁGINAS — DESCRIPCIÓN Y ESTADOS

### 8.1 HomePage (`/`) — Pública, sin layout

**Propósito**: Landing page de marketing.

**Secciones**:
- Header: logo + ThemeToggle + "Iniciar Sesión" + "Empezar" buttons
- Hero: badge "Aprende finanzas jugando" + h1 con gradient text + subtitle + CTA "Comienza Gratis"
- 3 feature cards: Lecciones Interactivas, Desafíos y Logros, Gamificación Total

**Estados**: solo render estático, sin data fetching.

### 8.2 AuthPage (`/login`, `/register`) — Pública, sin layout

**Propósito**: Autenticación de usuarios.

**Subcomponentes**: `LoginForm` y `RegisterForm` (definidos en el mismo archivo).

**Secciones**:
- ThemeToggle flotante: `fixed top-4 right-4 z-50` dentro de un `div` con glassmorphism
- Logo + título + subtítulo
- Card con toggle slider animado (Login / Crear Cuenta)
- **Login**: email + password + recordarme + olvidé contraseña + submit
- **Register**: nombre + email + password + confirmar password + aceptar términos + submit

**Reglas**:
- Submit deshabilitado hasta aceptar términos (Register)
- Password toggle con Eye/EyeOff
- `ERROR_MAP` para traducción de errores Supabase
- Loading state en botón con `Loader2` + texto "Ingresando..." / "Creando cuenta..."

**Transiciones**: slider 300ms ease-out, interactivos 200ms.

### 8.3 InicioPage (`/inicio`) — Protegida, MainLayout

**Propósito**: Dashboard principal del usuario.

**Data fetching**: `Promise.all` con 6 queries paralelas.

**Secciones**:
- Saludo: "¡Hola, {nombre}!"
- 4 stat cards (grid 2×2 → 4 cols): Puntos, Racha, Ingresos mes, Gastos mes
- Columna izquierda (md:col-span-2):
  - **Nivel Actual**: nombre + barra progreso gradiente + puntos totales/financial score
  - **Actividad Reciente**: lista con bullets, `formatActivity()`, `timeAgo()`
- Columna derecha:
  - **Tip del Día**: texto + categoría
  - **Retos Activos**: hasta 3 con barra progreso + "Ver todos"

**States**:
- `loading`: spinner implícito (useEffect async)
- `empty activities`: "Aún no hay actividad. ¡Empieza a aprender!"
- `empty challenges`: "No hay retos activos"
- `data`: render normal

### 8.4 AprenderPage (`/aprender`) — Protegida, MainLayout

**Propósito**: Módulos educativos y lecciones.

**Data fetching**: módulos activos → para cada módulo, sus lecciones activas → para cada lección, el progreso del usuario.

**Secciones**:
- Header: título + contador lecciones completadas/totales
- Barra global de progreso (gradiente violet→fuchsia)
- Accordion de módulos: cada uno expandible con click
  - Contraído: icono + título + descripción + progreso + badge dificultad + chevron
  - Expandido: lista de lecciones con estado (CheckCircle=completa, Play=enprogreso, Clock=no iniciada)
- Placeholders: Simuladores (próximamente) + Biblioteca

**States**:
- `loading`: 3 skeleton cards con `animate-pulse`
- `empty modules`: `BookOpen` icon + "No hay módulos disponibles aún"
- `empty lessons in module`: "Sin lecciones aún"
- `data`: accordion expandible

### 8.5 MisFinanzasPage (`/mis-finanzas`) — Protegida, MainLayout

**Propósito**: Control de ingresos, gastos, ahorro, deudas y presupuestos.

**Data fetching**: 5 queries paralelas del mes actual.

**Secciones**:
- 3 summary cards: Ingresos (emerald), Gastos (red), Balance (verde si ≥0, rojo si <0)
- Grid 2 cols:
  - Últimos Ingresos: lista con "+${amount}" + "Nuevo" button (placeholder)
  - Últimos Gastos: lista con "-${amount}" + "Nuevo" button (placeholder)
- Grid 3 cols:
  - Metas de Ahorro: nombre + progreso % + monto actual
  - Deudas Activas: nombre + balance + tipo
  - Presupuestos: nombre + monto + período

**States**:
- `empty incomes`: "Sin ingresos este mes"
- `empty expenses`: "Sin gastos este mes"
- `empty savings/debts/budgets`: "Sin metas/activas/presupuestos"

### 8.6 RetosPage (`/retos`) — Protegida, MainLayout

**Propósito**: Gamificación — retos, logros, insignias, rachas.

**Data fetching**: 5 queries paralelas + consulta adicional para `user_achievements`.

**Secciones**:
- 4 stat cards: Retos activos, Logros, Mejor racha, Puntos ganados
- Grid 2 cols:
  - **Retos**: cards con título + badge estado + barra progreso + %
  - **Logros**: grid 2×2 de cards, opacidad 50% si bloqueados, badge violeta si desbloqueados
- Grid 2 cols:
  - **Insignias**: badges con color según rareza (legendary=amber, epic=violet, rare=blue, common=slate) + inicial
  - **Rachas**: cada streak con flame icon + current count + best count
- **Historial de Puntos**: lista cronológica con fuente + puntos + `timeAgo()`

**States**:
- `loading`: skeleton cards (animate-pulse)
- `empty challenges`: "Aún no tienes retos. ¡Los retos aparecerán aquí!"
- `empty achievements`: "No hay logros disponibles"
- `empty badges`: "Sin insignias disponibles"
- `empty streaks`: "Sin rachas aún. ¡La constancia da recompensas!"
- `data`: render completo

### 8.7 PerfilPage (`/perfil`) — Protegida, MainLayout

**Propósito**: Datos del usuario, configuración y ajustes.

**Data fetching**: avatars + financial_goals.

**Secciones**:
- Avatar gradient + nombre + email + botón "Editar" (activa inline editing de nombre/apellido)
- Grid 2×2 datos: País, Ciudad, Teléfono, Miembro desde
- **Apariencia**: toggle tema con botón "Cambiar a claro/oscuro" que llama a `toggleTheme()`
- **Configuración**: Notificaciones, Moneda, Idioma (desde `user_settings`)
- **Metas Financieras**: lista de goals con progreso % y badge status
- **Cerrar sesión**: texto rojo `text-red-400 hover:text-red-300`, redirect a `/login`

**States**:
- `editing`: inline inputs con botón "Guardar" + "Cancelar"
- `empty goals`: "Sin metas financieras. ¡Define tus objetivos!"
- `saving`: botón "Guardando..." deshabilitado

---

## 9. DATOS Y SUPABASE

### Cliente (`src/lib/supabase.ts`)

```typescript
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  console.warn('Supabase no configurado. Crea un archivo .env con VITE_SUPABASE_URL y VITE_SUPABASE_ANON_KEY')
}

export const supabase = createClient(
  supabaseUrl || 'http://localhost:8000',
  supabaseAnonKey || ''
)
```

**Fallback seguro**: si faltan `.env`, apunta a `localhost:8000` (instancia local).

### Tipos (`src/types/database.ts`)

30+ interfaces exportadas y 18 type enums. Las principales:

| Interfaz | Tabla en BD | Notas |
|----------|-------------|-------|
| `UserLevel` | `user_levels` | 10 niveles seed |
| `UserProfile` | `user_profiles` | FK a `auth.users` (1:1) |
| `UserSettings` | `user_settings` | FK a `auth.users` (1:1) |
| `EducationalModule` | `educational_modules` | 5 módulos seed |
| `Lesson` | `lessons` | FK a módulos |
| `LessonProgress` | `lesson_progress` | UNIQUE(user_id, lesson_id) |
| `Income` | `incomes` | FK a `income_categories` |
| `Expense` | `expenses` | FK a `expense_categories` |
| `Budget` | `budgets` | FK a usuario |
| `SavingGoal` | `savings_goals` | FK a usuario |
| `Debt` | `debts` | FK a usuario |
| `Challenge` | `challenges` | Puede tener `badge_reward_id` |
| `Achievement` | `achievements` | Logros automáticos |
| `Badge` | `badges` | 4 rarezas, 14 seeds |
| `DailyTip` | `daily_tips` | 16 seeds |
| `ActivityLog` | `activity_logs` | 12 tipos de actividad |

**⚠️ Leer `DB_SCHEMA.md`** antes de crear o modificar cualquier query de Supabase. Contiene el esquema completo con columnas, tipos, FKs e índices.

---

## 10. CONVENCIONES — REGLAS ESTRICTAS

### 10.1 Nomenclatura

| Elemento | Regla | Ejemplo |
|----------|-------|---------|
| Archivos componente | PascalCase | `ThemeToggle.tsx`, `MainLayout.tsx` |
| Archivos página | PascalCase + `Page` suffix | `InicioPage.tsx`, `AuthPage.tsx` |
| Archivos contexto | PascalCase | `ThemeContext.tsx`, `AuthContext.tsx` |
| Archivos hook | camelCase + `use` prefix | `useAuth.ts`, `useTheme.ts` |
| Archivos tipo/utilidad | kebab-case | `database.ts`, `supabase.ts` |
| Interfaces/Types | PascalCase | `UserProfile`, `ActivityType` |
| Funciones | camelCase | `getInitialTheme()`, `formatActivity()` |
| Componentes funcionales | `export default function Nombre()` | — |

### 10.2 Código

- **TypeScript estricto** — tipar todo. Evitar `any`. Usar `as` casting solo cuando sea estrictamente necesario.
- **Componentes funcionales** con hooks — nunca class components.
- **Tailwind SIEMPRE** — prohibido CSS modules, styled-components o cualquier CSS-in-JS.
- **Lucide React para iconos** — prohibido usar emojis (😄🎉🔥) como decoración.
- **Importar tipos desde `../types/database`** — no crear interfaces inline nunca.
- **Toda página debe manejar 3 estados**: `loading` (spinner/skeleton), `empty` (icono + mensaje), `data` (contenido normal).
- **Transiciones**: `transition-all duration-200` en botones, links y elementos interactivos.
- **Sin `console.log` en código de producción** — solo `console.warn` para fallbacks de configuración.
- **Importaciones ordenadas**: primero React/terceros, luego contextos, luego componentes, luego lucide, luego types.

### 10.3 Estructura de página (template a seguir)

```typescript
import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from '../contexts/AuthContext'
import MainLayout from '../components/MainLayout'
import { Loader2, IconName } from 'lucide-react'
import type { SomeType } from '../types/database'

export default function NuevaPage() {
  const { user } = useAuth()
  const [data, setData] = useState<SomeType[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    const loadData = async () => {
      // fetch from supabase
      setLoading(false)
    }
    loadData()
  }, [user])

  if (loading) {
    return (
      <MainLayout>
        <div className="flex items-center justify-center py-16">
          <Loader2 className="w-8 h-8 text-violet-500 animate-spin" />
        </div>
      </MainLayout>
    )
  }

  if (data.length === 0) {
    return (
      <MainLayout>
        <div className="text-center py-16">
          <IconName className="w-12 h-12 text-theme-text-tertiary mx-auto mb-3" />
          <p className="text-theme-text-secondary">Mensaje de empty state</p>
        </div>
      </MainLayout>
    )
  }

  return (
    <MainLayout>
      <div className="space-y-6">
        {/* contenido */}
      </div>
    </MainLayout>
  )
}
```

---

## 11. ESTADO ACTUAL DEL PROYECTO

### ✅ Completado
- [x] Sistema de autenticación completo (login, register, logout, sesión con Supabase)
- [x] Tema claro/oscuro con persistencia en localStorage + fallback prefers-color-scheme
- [x] Todas las 7 páginas con UI completa y data fetching desde Supabase
- [x] Sidebar + BottomNav con navegación responsive y active states
- [x] Header sticky con avatar, ThemeToggle y logout
- [x] Conexión a Supabase local con fallback seguro
- [x] Tipos TypeScript para toda la BD (30+ interfaces, 18 enums)
- [x] DB_SCHEMA.md completo (41 tablas, diagrama ER textual, índices)
- [x] Componentes compartidos extraídos: StatCard, SectionCard
- [x] Utilidades compartidas: timeAgo, formatCurrency, formatActivity en `src/lib/utils.ts`

### 🟡 Pendiente / Vacío
- [ ] `src/hooks/` — sin archivos
- [ ] `src/styles/` — sin archivos
- [ ] `src/assets/` — sin archivos
- [ ] `supabase/` — directorio no existe (migraciones SQL, seeds, RLS policies pendientes)
- [ ] CRUD completo de ingresos/gastos (solo lectura implementada)
- [ ] Formularios "Nuevo" en Mis Finanzas (botones son placeholder)
- [ ] Simuladores financieros interactivos
- [ ] Biblioteca de recursos educativos
- [ ] Leaderboard / tabla de posiciones
- [ ] Seeds de BD: niveles (10), avatares (10), categorías (10 ingresos + 16 gastos), badges (14), tips (16), módulos (5)

### ⚠️ Issues conocidos
- Algunos casteos `as unknown as` en queries de Supabase (limpiar, en `InicioPage.tsx`)

---

## 12. COMANDOS

```bash
pnpm dev          # Iniciar servidor de desarrollo (localhost:5173)
pnpm build        # Build de producción (tsc -b && vite build)
pnpm lint         # ESLint sobre todo el proyecto
pnpm preview      # Vista previa del build de producción
pnpm add <pkg>    # Instalar dependencia (ej: pnpm add lucide-react)
pnpm remove <pkg> # Eliminar dependencia
```

---

## 13. REGLAS EXPLÍCITAS PARA AI AGENTS

Estas reglas son de OBLIGATORIO cumplimiento. Ignorarlas causará código inconsistente.

### Previo a trabajar
1. **Leer este documento completo** antes de hacer cualquier cambio.
2. **Leer DB_SCHEMA.md** antes de crear o modificar queries de Supabase.
3. **Leer los archivos existentes** relevantes antes de editarlos (no asumir contenido).

### Durante la implementación
4. **Seguir los patrones existentes** — cada componente/página nueva debe imitar exactamente el estilo, imports y estructura de los ya implementados.
5. **Preferir editar archivos existentes sobre crear nuevos**. Si algo se puede añadir a un archivo existente, hacerlo ahí.
6. **No duplicar lógica ni UI**. Si un patrón se repite 2+ veces, extraer a un componente compartido en `src/components/`. Antes de crear UI nueva, REVISAR `COMPONENTS.md` para ver si ya existe algo reutilizable.
7. **No modificar el sistema de theming** — no tocar `index.css`, `tailwind.config.js`, `ThemeContext.tsx` a menos que sea explícitamente solicitado.
8. **No agregar dependencias npm** sin preguntar primero. Usar solo lo que ya está en `package.json`.
9. **Usar los tipos de `src/types/database.ts`** — nunca crear interfaces o types inline.
10. **Tailwind SIEMPRE** — cero CSS modules, cero styled-components, cero CSS-in-JS.
11. **Lucide React para iconos** — cero emojis decorativos en la UI.
12. **pnpm para todo** — nunca ejecutar `npm install`, `npm add`, `npm run`.

### Estructura y calidad
13. **Manejar los 3 estados** en cada página: `loading` (spinner/skeleton), `empty` (icono + mensaje), `data` (contenido).
14. **Transiciones de 200ms** (`transition-all duration-200`) en todos los elementos interactivos.
15. **No dejar `console.log`** en commits. Solo `console.warn` para fallbacks de configuración.
16. **No hardcodear colores, valores o clases** que ya existen en las variables CSS o en `tailwind.config.js` → usar `text-theme-text`, `bg-theme-surface`, etc.
17. **TypeScript estricto** — tipar returns de funciones, props de componentes, estados.
18. **No usar `any`** — preferir `unknown` + casting específico, o crear el tipo correcto.
19. **Reutilización de componentes**. Antes de escribir UI nueva, REVISAR `COMPONENTS.md`. Si el componente que necesitas ya existe, USARLO. Si ves el mismo patrón 2+ veces en el código, EXTRACERLO a `src/components/`, agregarlo al catálogo en `COMPONENTS.md`, y refactorizar todas las páginas que lo usan.

### Flujo de trabajo (Reglas 20-24)
20. **Plan antes de codificar** 🚨. Antes de implementar cualquier cambio que requiera +50 líneas o modifique múltiples archivos, el agente DEBE presentar un plan breve (3-5 pasos) y ESPERAR aprobación explícita. No empezar a codificar sin confirmación. Esto aplica también a cambios que toquen lógica de negocio, BD o routing.
21. **Un feature a la vez + commit**. Trabajar UN feature o cambio a la vez por conversación. Cada ciclo completo: implementar → verificar con `pnpm build && pnpm lint` → preguntar "¿Sigo o ajusto?" → solo entonces hacer commit. No arrastrar features incompletos entre sesiones.
22. **Pedir opciones, elegir la simple**. Cuando una decisión de implementación tenga múltiples caminos, el agente DEBE ofrecer 2-3 opciones ordenadas de más simple a más compleja, con costo de implementación estimado. La opción SIMPLE es la default a menos que el usuario elija otra.
23. **Contextos frescos por feature**. Cada conversación nueva debe partir de un feature bien definido. No arrastrar múltiples features inconclusos en una misma sesión. `AGENTS.md` es el único puente entre sesiones. Si el contexto se llena y no se ha completado el feature, solicitar al usuario cerrar y abrir una sesión nueva.
24. **Revisión de seguridad**. Después de implementar cualquier feature que toque datos protegidos (auth, RLS, perfiles, endpoints), el agente DEBE verificar explícitamente: (1) ¿la query filtra por `user.id`? (2) ¿hay RLS policies en la tabla? (3) ¿se exponen datos sensibles (email, teléfono) en el frontend sin necesidad? (4) ¿el formulario valida inputs antes de enviar?

---

## 14. REFERENCIAS RÁPIDAS

| Archivo | Propósito |
|---------|-----------|
| `DB_SCHEMA.md` | Esquema completo de BD (41 tablas, enums, índices, relaciones) |
| `src/types/database.ts` | Interfaces TypeScript de todas las tablas |
| `src/lib/supabase.ts` | Cliente Supabase configurado |
| `src/App.tsx` | Router con todas las rutas y guards |
| `src/index.css` | CSS custom properties y Tailwind directives |
| `tailwind.config.js` | Configuración de tema Tailwind |
| `src/contexts/ThemeContext.tsx` | Lógica de tema claro/oscuro |
| `src/contexts/AuthContext.tsx` | Lógica de autenticación |
| `src/components/MainLayout.tsx` | Layout principal de la app |
| `src/components/StatCard.tsx` | Card de estadística reutilizable |
| `src/components/SectionCard.tsx` | Card contenedor con título e icono |
| `src/lib/utils.ts` | Utilidades compartidas (timeAgo, formatCurrency, formatActivity) |
| `DESIGN.md` | Sistema de diseño (CSS vars, Tailwind config, principios) |
| `COMPONENTS.md` | Catálogo de componentes reutilizables |

