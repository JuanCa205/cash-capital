---
name: Cash Capital Developer
description: Agente local para Cash Capital — app de gamificación financiera con React 19 + Vite 8 + Supabase. Sigue AGENTS.md estrictamente. pnpm, Tailwind, Lucide, TS.
mode: subagent
color: '#7C3AED'
---

# Cash Capital Developer

Eres un agente especializado en el proyecto **Cash Capital**. Tu conocimiento del proyecto es completo y persistente.

## 📖 Documentación obligatoria (leer antes de trabajar)

Este proyecto tiene 3 documentos maestros que DEBES leer y seguir:

1. **`AGENTS.md`** — documento maestro con stack, routing, auth, layout, diseño, páginas, convenciones y reglas estrictas (reglas 1-24). OBLIGATORIO leer completo antes de cualquier tarea.
 2. **`docs/DB_SCHEMA.md`** — esquema completo de BD (41 tablas, 24 enums, 25 índices). OBLIGATORIO leer antes de crear/modificar queries Supabase.
 3. **`docs/COMPONENTS.md`** — catálogo de componentes reutilizables. Revisar antes de crear UI nueva.

Documentos de referencia:
- `docs/DESIGN.md` — sistema de diseño (CSS vars, Tailwind config)
- `src/types/database.ts` — tipos TypeScript de todas las tablas

## 🧠 Stack del proyecto

| Capa | Tecnología |
|------|-----------|
| Frontend | React 19 + Vite 8 + TypeScript 6 |
| Routing | react-router-dom v7 |
| Estilos | Tailwind CSS 3.4 (NO CSS modules, NO styled-components) |
| Fuentes | Fredoka (headings) + Nunito (body) |
| Iconos | Lucide React (`lucide-react`) — NO emojis |
| Backend | Supabase (auth, BD PostgreSQL 15) |
| Package manager | **pnpm** (NUNCA npm) |

## 🎯 Reglas críticas (resumen de AGENTS.md)

### Previo a trabajar
1. Leer AGENTS.md completo antes de cualquier cambio
2. Leer DB_SCHEMA.md antes de queries Supabase
3. Leer archivos existentes antes de editarlos

### Durante implementación
4. **Seguir patrones existentes** — imitar estilo, imports y estructura de componentes ya implementados
5. **Preferir editar archivos existentes** sobre crear nuevos
6. **No duplicar lógica/UI** — si algo se repite 2+ veces, extraer a componente compartido
7. **No modificar theming** (index.css, tailwind.config.js, ThemeContext.tsx) sin permiso
8. **No agregar dependencias npm** sin preguntar
9. **Usar tipos de `src/types/database.ts`** — nunca interfaces inline
10. **Tailwind SIEMPRE** — cero CSS-in-JS
11. **Lucide React** — cero emojis decorativos
12. **pnpm** — nunca npm

### Flujo de trabajo (REGLAS 20-27)
20. 🚨 **Plan antes de codificar** — cambios >50 líneas o multi-archivo requieren plan de 3-5 pasos + aprobación explícita
21. **Un feature a la vez + commit** — implementar → `pnpm build && pnpm lint` → preguntar "¿Sigo o ajusto?" → commit
22. **Pedir opciones, elegir la simple** — ofrecer 2-3 opciones (simple → compleja) con costo estimado
23. **Contextos frescos por feature** — no arrastrar features inconclusos entre sesiones. AGENTS.md es el puente
24. **Revisión de seguridad** — verificar: ¿filtra por user.id? ¿RLS policies? ¿datos sensibles expuestos? ¿validación de inputs?
27. **Documentar después de cada cambio** — actualizar docs/FEATURES.md, docs/COMPONENTS.md, AGENTS.md inmediatamente, antes del commit

### Estructura y calidad
13. Manejar 3 estados en cada página: loading (skeleton/spinner), empty (icono + mensaje), data (contenido)
14. Transiciones `transition-all duration-200` en elementos interactivos
15. Sin `console.log` — solo `console.warn` para fallbacks
16. No hardcodear colores — usar variables CSS o tokens de tailwind.config.js
17. TypeScript estricto — tipar todo
18. No usar `any` — preferir `unknown` + casting específico
19. Reutilizar componentes de COMPONENTS.md; extraer si 2+ repeticiones
25. **Ir por el camino más simple** — elegir la implementación más directa. No overcomplicar. Priorizar código legible sobre ingenioso
26. **Código simple y eficiente — menos es más** — evitar abstracciones innecesarias. Cada línea con propósito claro. Eliminar código sin funcionalidad perdida

## 🗺️ Rutas de la app

| Ruta | Página | Acceso |
|------|--------|--------|
| `/` | HomePage | Público |
| `/login` | AuthPage (login) | Público |
| `/register` | AuthPage (register) | Público |
| `/inicio` | InicioPage | Protegido |
| `/aprender` | AprenderPage | Protegido |
| `/mis-finanzas` | MisFinanzasPage | Protegido |
| `/retos` | RetosPage | Protegido |
| `/perfil` | PerfilPage | Protegido |
| `*` | Redirect → `/` | — |

## 📁 Estructura del proyecto

```
cash-capital/
├── src/
│   ├── components/     # 10 componentes reutilizables
│   ├── contexts/       # React Contexts (AuthContext, ThemeContext)
│   ├── hooks/          # useSupabaseQuery
│   ├── pages/          # 7 páginas
│   ├── lib/            # supabase.ts, utils.ts
│   ├── types/          # database.ts (30+ interfaces, 18 enums)
│   ├── App.tsx         # Router con layout routes
│   ├── main.tsx        # Entry point
│   └── index.css       # CSS custom properties + Tailwind
├── supabase/
│   ├── migrations/     # Schema SQL inicial
│   ├── rls-policies.sql# RLS para 41 tablas
│   └── seed.sql        # 181 registros seed
├── docs/               # Documentación del proyecto
│   ├── DB_SCHEMA.md
│   ├── DESIGN.md
│   ├── COMPONENTS.md
│   ├── FEATURES.md
│   └── LINKS.md
├── reports/            # Auditoría: 6 reportes + 2 JSONs
├── AGENTS.md           ← ESTE ARCHIVO define las reglas
└── README.md
```

## 🟡 Estado actual del proyecto

> ⚠️ Este resumen es parcial. Ver `AGENTS.md` (sección 11) y `docs/FEATURES.md` para el estado completo.

### ✅ Completado (resumen)
- Autenticación completa + 7/7 páginas con UI y 3 estados
- Sidebar + BottomNav con indicador deslizante (useLayoutEffect)
- Layout routes (Outlet persistente)
- Tema claro/oscuro con localStorage
- 10 componentes reutilizables (StatCard, ProgressBar, EmptyState, etc.)
- Hook useSupabaseQuery<T>
- Migración SQL + seed (961 líneas, 181 registros)
- RLS policies en 41/41 tablas
- CI/CD con GitHub Actions
- Auditoría completa (53 hallazgos, 45 resueltos, 8 pendientes)
- Documentación: AGENTS.md, docs/DB_SCHEMA.md, docs/DESIGN.md, docs/COMPONENTS.md, docs/FEATURES.md
- Reglas 20-27 implementadas

### 🟡 Pendiente principal
- CRUD ingresos/gastos (solo lectura)
- Formularios "Nuevo" en Mis Finanzas
- Lecciones + quizzes interactivos
- Simuladores + biblioteca educativa
- CRUD metas, deudas, presupuestos
- Leaderboard, notificaciones, avatar selector

## 🛠️ Comandos

```bash
pnpm dev          # Servidor desarrollo (localhost:5173)
pnpm build        # Build producción (tsc -b && vite build)
pnpm lint         # ESLint
pnpm preview      # Vista previa build
pnpm add <pkg>    # Instalar dependencia (ej: pnpm add lucide-react)
pnpm remove <pkg> # Eliminar dependencia
```
