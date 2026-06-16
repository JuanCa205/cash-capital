# Cash Capital — AGENTS.md

Instrucciones compactas para agentes AI trabajando en este repo. Cada línea responde a "¿un agente fallaría en esto sin ayuda?".

---

## Stack

| Capa | Tecnología |
|------|-----------|
| Frontend | React 19 + Vite 8 + TypeScript 6 |
| Routing | react-router-dom v7 (layout routes con `<Outlet />`) |
| Estilos | **Tailwind CSS 3.4 exclusivamente** — prohibido CSS modules, styled-components, CSS-in-JS |
| Iconos | **Lucide React** (`lucide-react`) — prohibido emojis decorativos |
| Fuentes | Fredoka (headings) + Nunito (body) — importadas en `index.css` vía Google Fonts |
| Backend | Supabase (auth, PostgreSQL 15, storage) |
| Auth | Supabase Auth + `user_profiles` (1:1) + `user_settings` (1:1) |
| Tema | CSS custom properties + `data-theme="dark\|light"` en `<html>`. Persiste en localStorage `cash-capital-theme` |

## Package manager

**`pnpm`** exclusivamente. `npm install / npm run / npm add` están prohibidos.

```bash
pnpm dev          # Servidor desarrollo → http://localhost:5173
pnpm build        # Build producción: tsc -b && vite build
pnpm lint         # ESLint flat config sobre todo el proyecto
pnpm preview      # Vista previa del build
pnpm add <pkg>    # Instalar dependencia (ej: pnpm add lucide-react)
```

## Comandos de verificación

```bash
pnpm build && pnpm lint   # Ejecutar siempre antes de commitear
```

El build falla si hay errores de TypeScript (`tsc -b`). El lint usa `typescript-eslint` + `react-hooks` + `react-refresh`.

## Enlaces importantes

| Archivo | Cuándo leerlo |
|---------|---------------|
| `src/types/database.ts` | **Siempre** antes de escribir queries — 30+ interfaces, 18 type enums |
| `docs/DB_SCHEMA.md` | Antes de crear o modificar cualquier query a Supabase (esquema completo: 41 tablas, FKs, índices) |
| `docs/COMPONENTS.md` | Antes de escribir UI nueva — catálogo de 10 componentes reutilizables |
| `docs/DESIGN.md` | Sistema de diseño completo (CSS vars, tokens, Tailwind config) |

## Arquitectura

### Provider tree (`src/main.tsx`)
```
StrictMode > ThemeProvider > AuthProvider > App
```

### Routing (`src/App.tsx`)

| Ruta | Componente | Layout | Acceso |
|------|-----------|--------|--------|
| `/` | `HomePage` | — | Público |
| `/login` | `AuthPage initialMode="login"` | — | Público |
| `/register` | `AuthPage initialMode="register"` | — | Público |
| `/inicio` | `InicioPage` | MainLayout | 🔒 Autenticado |
| `/aprender` | `AprenderPage` | MainLayout | 🔒 Autenticado |
| `/mis-finanzas` | `MisFinanzasPage` | MainLayout | 🔒 Autenticado |
| `/retos` | `RetosPage` | MainLayout | 🔒 Autenticado |
| `/perfil` | `PerfilPage` | MainLayout | 🔒 Autenticado |
| `*` | Redirect → `/` | — | Público |

Dos guards: **`ProtectedRoute`** (redirige a `/login` si no hay sesión) y **`PublicRoute`** (redirige a `/inicio` si hay sesión). Ambos muestran `<Loader2 />` durante `loading`. Las rutas protegidas anidan `<ProtectedRoute>` → `<MainLayout>` → `<Route path=...>` para que sidebar/header/bottom nav persistan.

### Auth (`src/contexts/AuthContext.tsx`)

Expone: `{ session, user, profile, settings, loading, login, register, logout, refreshProfile }`.

- `login(email, password)` → `supabase.auth.signInWithPassword()`
- `register(email, password, firstName)` → signUp + insert `user_profiles` + insert `user_settings` (con nivel inicial level_number=1)
- `logout()` → signOut + limpia estado + navigate `/login`
- `profile` y `settings` se cargan automáticamente cuando `user` cambia

### Layout (`src/components/MainLayout.tsx`)

Usa `<Outlet />` (no `children`). Header sticky con ThemeToggle + avatar + logout. Sidebar (`hidden md:flex`) colapsable en hover. BottomNav (`md:hidden`) fijo abajo. Margen responsive: `md:ml-16 lg:ml-56 pb-16 md:pb-0`.

## Convenciones de código

### Nomenclatura
- Componentes: PascalCase (`ThemeToggle.tsx`, `ProgressBar.tsx`)
- Páginas: PascalCase + `Page` suffix (`InicioPage.tsx`)
- Contextos: PascalCase + `Context` suffix (`ThemeContext.tsx`)
- Hooks: camelCase con `use` prefix (`useSupabaseQuery.ts`)
- Utilidades/tipos: kebab-case (`database.ts`, `supabase.ts`)
- Funciones: camelCase (`formatActivity()`, `timeAgo()`)
- Componentes: `export default function Nombre()` siempre

### Estilo
- **TypeScript estricto** — tipar todo. Prohibido `any`. Preferir `unknown` + casting específico
- **Tailwind SIEMPRE** — cero CSS-in-JS, cero CSS modules
- **Lucide React** para iconos — cero emojis decorativos
- Tipos desde `src/types/database.ts` — nunca interfaces inline
- Sin `console.log` en producción. Solo `console.warn` para fallbacks de configuración
- Transiciones: `transition-all duration-200` en elementos interactivos

### Template de página protegida

Las páginas **NO** importan `MainLayout` — se renderizan como hijo del `<Outlet />`.

```typescript
import { useEffect, useState } from 'react'
import { supabase } from '../lib/supabase'
import { useAuth } from '../contexts/AuthContext'
import { Loader2 } from 'lucide-react'
import EmptyState from '../components/EmptyState'
import type { SomeType } from '../types/database'

export default function NuevaPage() {
  const { user } = useAuth()
  const [data, setData] = useState<SomeType[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!user) return
    let cancelled = false
    const loadData = async () => {
      try {
        // fetch con supabase
        if (!cancelled) setData(result)
      } catch (err) {
        if (!cancelled) console.error('Error:', err)
      } finally {
        if (!cancelled) setLoading(false)
      }
    }
    loadData()
    return () => { cancelled = true }
  }, [user])

  if (loading) return <div className="animate-pulse space-y-4">{/* skeletons */}</div>
  if (data.length === 0) return <EmptyState icon={SomeIcon} message="Mensaje vacío" />
  return <div className="space-y-6">{/* contenido */}</div>
}
```

**3 estados obligatorios**: `loading` (skeleton/spinner con `animate-pulse`), `empty` (EmptyState), `data`.

### Consultas a Supabase

- Hook genérico disponible: `useSupabaseQuery<T>(query, deps)` → `{ data, loading, error, refetch }`
- Para queries paralelas: `Promise.all` con `cancelled` flag
- Siempre filtrar por `user.id` en tablas con `user_id`
- Leer `docs/DB_SCHEMA.md` antes de cualquier query nueva

## Flujo de trabajo

1. **Plan antes de codificar**. Cambios >50 líneas o multi-archivo requieren plan breve (3-5 pasos) y aprobación explícita.
2. **Un feature a la vez**. Implementar → `pnpm build && pnpm lint` → preguntar "¿Sigo o ajusto?" → commit.
3. **Preferir editar archivos existentes** sobre crear nuevos. No duplicar lógica/UI. Si un patrón se repite 2+ veces, extraer a `src/components/` y agregar a `docs/COMPONENTS.md`.
4. **Documentar inmediatamente** después de cada cambio: actualizar `docs/FEATURES.md`, `docs/COMPONENTS.md`, y `AGENTS.md` antes del commit.
5. **Revisión de seguridad** después de tocar auth/RLS/datos protegidos: (a) ¿la query filtra por `user.id`? (b) ¿hay RLS policies en la tabla? (c) ¿se exponen datos sensibles sin necesidad? (d) ¿el formulario valida inputs?
6. **Dar opciones simple/compleja** cuando haya múltiples caminos. Default: la más simple.
7. **No agregar dependencias npm** sin preguntar. Usar solo lo que ya está en `package.json`.
8. **No modificar theming** (`index.css`, `tailwind.config.js`, `ThemeContext.tsx`) sin permiso explícito.

## Issues conocidos

- `InicioPage.tsx` (líneas 60-64): casteo `as { challenges: unknown; progress_value: number }[]` — refactorizar para tipado correcto cuando se aborde.
- CRUD real de ingresos/gastos/metas/deudas/presupuestos: solo lectura implementada. Botones "Nuevo" son placeholders.
- Lecciones + quizzes: tablas seedeadas pero sin UI de contenido ni interactividad.
