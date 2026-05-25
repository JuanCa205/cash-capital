# DevOps Agent Report — Wave 3: Infrastructure

> **Fecha**: 2026-05-25
> **Agente**: DevOps Automator
> **Estado**: Parcial (4/8 issues resueltos)

---

## Resumen

Se implementaron 4 de los 8 issues de infraestructura identificados en el audit.
Los 4 restantes (INF-001, INF-003, INF-005, INF-006) requieren decisiones de equipo
y no fueron abordados en esta ronda.

| Issue | Estado | Archivo(s) creados |
|-------|--------|-------------------|
| INF-002 | ✅ Resuelto | `src/hooks/useSupabaseQuery.ts` |
| INF-004 | ✅ Resuelto | `public/favicon.svg`, `public/og-image.svg` |
| INF-007 | ✅ Resuelto | `.github/workflows/deploy.yml` |
| INF-008 | ✅ Resuelto | `.nvmrc` |
| INF-001 | ⏳ Pendiente | — |
| INF-003 | ⏳ Pendiente | — |
| INF-005 | ⏳ Pendiente | — |
| INF-006 | ⏳ Pendiente | — |

---

## INF-002: Hook `useSupabaseQuery`

### Archivo creado
`src/hooks/useSupabaseQuery.ts`

### Descripción
Hook genérico con TypeScript que encapsula el patrón repetido de fetch desde Supabase:

```typescript
function useSupabaseQuery<T>(
  query: () => Promise<{ data: T | null; error: PostgrestErrorLike | null }>,
  deps: React.DependencyList = []
): UseSupabaseQueryResult<T>
```

### Funcionalidades
- ✅ **Loading state**: Inicia con `loading: true`, cambia a `false` al completar/fallar
- ✅ **Data state**: Almacena el resultado tipado como `T | null`
- ✅ **Error state**: Captura errores del query y excepciones, expone mensaje legible
- ✅ **Refetch**: `refetch()` incrementa un refreshKey que re-ejecuta el useEffect
- ✅ **Cleanup**: Flag `cancelled = false` en el closure del useEffect previene setState en componente desmontado
- ✅ **Genérico**: Tipado completo con `<T>`; el error se tipa como `PostgrestErrorLike { message: string }`
- ✅ **Sin `any`**: Se evitó el uso de `any` usando `React.DependencyList` y `PostgrestErrorLike`
- ✅ **Lint pass**: `pnpm lint` sin errores

### Uso esperado
```typescript
const { data: incomes, loading, error, refetch } = useSupabaseQuery(
  () => supabase.from('incomes').select('*').eq('user_id', user.id),
  [user]
)
```

### Nota
El hook está creado pero **no se usa aún** en las páginas. Un agente de código debe
refactorizar InicioPage, AprenderPage, MisFinanzasPage, RetosPage, PerfilPage para
usarlo, reemplazando los `useEffect` + `useState` manuales.

---

## INF-004: Assets básicos

### Archivos creados

#### `public/favicon.svg`
- Icono de cerdito (piggy bank) en SVG inline
- Tamaño: 32×32
- Color: violeta (#8B5CF6) con detalles en ámbar (#FBBF24) para la moneda
- Diseño plano, minimalista
- Incluye: cuerpo ovalado, cabeza redonda, orejas, hocico, ojos, moneda con "$", cola rizada

#### `public/og-image.svg`
- Imagen para Open Graph / redes sociales
- Tamaño: 1200×630 (estándar OG)
- Fondo gradiente oscuro (indigo → violeta → indigo) con círculos decorativos sutiles
- Icono de cerdito grande a la izquierda
- Título "Cash Capital" con gradiente violeta→rosa
- Subtítulo "Aprende finanzas jugando" en slate
- 3 features: Lecciones Interactivas, Desafíos y Logros, Gamificación Total
- Línea decorativa inferior

---

## INF-007: CI/CD Pipeline (GitHub Actions)

### Archivo creado
`.github/workflows/deploy.yml`

### Workflow: `CI/CD`

| Evento | Disparador |
|--------|-----------|
| `push` | `main` |
| `pull_request` | `main` |

### Jobs

**`quality`** (runs-on: ubuntu-latest):
1. `actions/checkout@v4` — clona el repo
2. `actions/setup-node@v4` — configura Node 22 con cache de pnpm
3. `corepack enable && corepack prepare pnpm@latest --activate` — prepara pnpm
4. `pnpm install --frozen-lockfile` — instala dependencias (garantiza lockfile)
5. `pnpm lint` — ejecuta ESLint
6. `pnpm build` — build de producción (tsc -b && vite build)
7. `actions/upload-pages-artifact@v3` — sube `dist/` como artifact (solo en push a main)

### Pendiente para producción
- Agregar deploy step (Vercel, Netlify, Cloudflare Pages, etc.)
- Agregar testing si se implementan tests
- Considerar matriz de versiones de Node

---

## INF-008: Versión de Node

### Archivo creado
`.nvmrc`

```
22
```

### Nota
Se eligió Node 22 por ser LTS y compatible con el stack actual (Vite 8, TypeScript 6).
Se recomienda agregar `"engines": { "node": ">=22.0.0" }` en `package.json` para
bloquear versiones incompatibles.

---

## Verificaciones

- ✅ `pnpm build` — exitoso (tsc -b y vite build sin errores)
- ✅ `pnpm lint` — exitoso (0 errores, 0 warnings)
- ✅ Los 4 archivos nuevos están en `.gitignore` fuera del alcance (no hay reglas que los excluyan)
- ✅ No se modificaron archivos existentes
- ✅ No se agregaron dependencias npm
- ✅ Hook no usado aún por diseño (se dejó intencionalmente para refactor posterior)

---

## Issues pendientes (no abordados)

| Issue | Título | Requiere |
|-------|--------|----------|
| INF-001 | Directorio supabase/ no existe | Crear migraciones SQL iniciales (DB_SCHEMA.md) |
| INF-003 | src/styles/ vacío | Decidir estrategia de estilos compartidos (@apply vs Tailwind inline) |
| INF-005 | Faltan seeds de BD | Crear seeds para challenges, achievements, streaks, quizzes |
| INF-006 | Sin schema de migraciones SQL | Generar migración inicial con Supabase CLI |

Estos 4 issues quedan pendientes para futuras iteraciones. El orden recomendado sería:
1. **INF-001 + INF-006**: Migraciones SQL (dependencia para todo lo demás)
2. **INF-005**: Seeds de BD (depende de migraciones)
3. **INF-003**: Estilos compartidos (baja prioridad, cosmético)

---

## Archivos creados (resumen)

```
cash-capital/
├── src/hooks/
│   └── useSupabaseQuery.ts          # 105 líneas — hook genérico Supabase
├── public/
│   ├── favicon.svg                   # 32×32 piggy bank SVG
│   └── og-image.svg                  # 1200×630 Open Graph image
├── .github/
│   └── workflows/
│       └── deploy.yml                # CI/CD pipeline
└── .nvmrc                            # Node 22
```
