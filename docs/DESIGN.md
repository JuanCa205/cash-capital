# Cash Capital — DESIGN.md

> Sistema de diseño y tema visual. Leer cuando necesites modificar el tema
> o entender los tokens de diseño. Referenciado desde `AGENTS.md`.

---

## CSS Custom Properties

Definidas en `src/index.css`. `:root` = tema claro, `[data-theme="dark"]` = tema oscuro.

| Variable | 🌞 Light (`:root`) | 🌙 Dark (`[data-theme="dark"]`) |
|----------|-------------------|--------------------------------|
| `--gradient-from` | `#f8fafc` | `#0f172a` |
| `--gradient-via` | `#eef2ff` | `#1e1b4b` |
| `--gradient-to` | `#f8fafc` | `#0f172a` |
| `--theme-bg` | `#f8fafc` | `#0f172a` |
| `--theme-surface` | `rgba(255,255,255,0.8)` | `rgba(255,255,255,0.06)` |
| `--theme-border` | `#e2e8f0` | `rgba(255,255,255,0.08)` |
| `--theme-muted` | `#f1f5f9` | `rgba(255,255,255,0.05)` |
| `--theme-text` | `#0f172a` | `#f8fafc` |
| `--theme-text-secondary` | `#475569` | `#94a3b8` |
| `--theme-text-tertiary` | `#64748b` | `#64748b` |
| `--theme-input` | `#ffffff` | `rgba(255,255,255,0.05)` |
| `--theme-input-border` | `#cbd5e1` | `rgba(255,255,255,0.10)` |

---

## Tailwind Config (`tailwind.config.js`)

```javascript
darkMode: ['selector', '[data-theme="dark"]'],
theme: {
  extend: {
    fontFamily: {
      heading: ['Fredoka', 'sans-serif'],
      body: ['Nunito', 'sans-serif'],
    },
    colors: {
      theme: {
        bg: 'var(--theme-bg)',
        surface: 'var(--theme-surface)',
        border: 'var(--theme-border)',
        muted: 'var(--theme-muted)',
        text: 'var(--theme-text)',
        'text-secondary': 'var(--theme-text-secondary)',
        'text-tertiary': 'var(--theme-text-tertiary)',
        input: 'var(--theme-input)',
        'input-border': 'var(--theme-input-border)',
      },
    },
  },
}
```

---

## Principios de diseño

- **Estilo**: Glassmorphism (backdrop-blur, bordes translúcidos)
- **Tipografía**: Fredoka (headings) + Nunito (body)
- **Paleta primaria**: Violet (#7C3AED)
- **Transiciones**: `transition-all duration-200` en elementos interactivos
- **Tema**: Persistencia en localStorage (`cash-capital-theme`) con fallback a `prefers-color-scheme`
- **Iconos**: Lucide React (SVG, sin emojis)

---

## Patrones visuales de uso frecuente

> Estos patrones están también en `AGENTS.md` (sección 7) porque se usan constantemente.

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
| Skeleton loading | `bg-theme-muted rounded animate-pulse` |
| Estado vacío | Icono + "texto descriptivo" centrado |
