# Cash Capital — COMPONENTS.md

> Catálogo de componentes reutilizables. Leer cuando necesites crear o
> modificar UI. Referenciado desde `AGENTS.md` (regla 19).

---

## Componentes existentes

| Componente | Archivo | Props | Descripción |
|-----------|---------|-------|-------------|
| `ThemeToggle` | `src/components/ThemeToggle.tsx` | — | Botón Sun/Moon. Usa `useTheme().toggleTheme`. Dark → sol, Light → luna |
| `MainLayout` | `src/components/MainLayout.tsx` | `{ children: ReactNode }` | Shell completo: sidebar, header con avatar+ThemeToggle+logout, bottom nav. Wraps children en main con max-w-7xl |
| `Sidebar` | `src/components/Sidebar.tsx` | — | Nav lateral fija. `hidden md:flex`. 5 NavLinks con logo. Active: bg-violet-600 text-white |
| `BottomNav` | `src/components/BottomNav.tsx` | — | Nav inferior fija. `md:hidden`. Mismos ítems que Sidebar pero Inicio al centro. Active: círculo violeta |
| `StatCard` | `src/components/StatCard.tsx` | `{ icon, label, value, sub, color }` | Card de estadística con icono degradado, valor grande, label y sub. `color`: `'violet'\|'orange'\|'green'\|'red'` |
| `SectionCard` | `src/components/SectionCard.tsx` | `{ title, icon, children }` | Card contenedor con título e icono violeta decorativo. Agrupa secciones |
| `ProgressBar` | `src/components/ProgressBar.tsx` | `{ percent, size?, color?, className? }` | Barra de progreso reutilizable. `size`: `'sm'\|'md'\|'lg'`. `color`: `'violet'\|'emerald'\|'amber'\|'red'` |
| `DifficultyBadge` | `src/components/DifficultyBadge.tsx` | `{ difficulty }` | Badge de dificultad: básico (verde), intermedio (ámbar), avanzado (rojo). `difficulty`: `'basic'\|'intermediate'\|'advanced'` |
| `EmptyState` | `src/components/EmptyState.tsx` | `{ icon, message, className? }` | Estado vacío con icono grande y mensaje centrado |
| `MiniCard` | `src/components/MiniCard.tsx` | `{ icon, title, items, empty }` | Card con lista de items y barras de progreso. Usa ProgressBar internamente |

---

## Utilidades compartidas (`src/lib/utils.ts`)

| Función | Firma | Descripción |
|---------|-------|-------------|
| `timeAgo` | `(date: string) => string` | "hace 5m", "hace 2h", "hace 3d" |
| `formatCurrency` | `(amount: number) => string` | "$1,234" con toLocaleString |
| `formatActivity` | `(type: string, desc?: string \| null) => string` | Traduce activity_type a texto legible |

---

## Ejemplo de uso correcto

```typescript
// ✅ CORRECTO: usar componente existente
import { StatCard } from '../components/StatCard'
<StatCard icon={TrendingUp} label="Puntos" value="1,000" sub="Nivel 3" color="violet" />

// ❌ INCORRECTO: recrear markup manualmente
<div className="bg-theme-surface...">
  <TrendingUp className="..." />
  <p>1,000</p>
  <span>Puntos</span>
</div>
```

---

## Cómo contribuir al catálogo

1. Identificas un patrón visual que se repite 2+ veces en el código
2. Creas el componente en `src/components/NuevoComponente.tsx`
3. Lo importas y usas en lugar del código duplicado
4. Agregas la entrada a la tabla de componentes existentes (arriba)
5. Si extraes un patrón de una página, eliminas el código local y usas el componente compartido
