# Cash Capital 💰

> App web de gamificación financiera — aprende finanzas personales mientras juegas.

**Stack**: React 19 + Vite 8 + TypeScript 6 + Tailwind CSS 3.4 + Supabase

---

## Requisitos

- **Node.js 22** (`.nvmrc` configurado)
- **pnpm** (`corepack enable && corepack prepare pnpm@latest --activate`)

## Inicio rápido

```bash
# Instalar dependencias
pnpm install

# Copiar variables de entorno
cp .env.example .env
# Editar .env con VITE_SUPABASE_URL y VITE_SUPABASE_ANON_KEY

# Iniciar servidor de desarrollo
pnpm dev
# → http://localhost:5173
```

## Comandos

| Comando | Descripción |
|---------|-------------|
| `pnpm dev` | Servidor de desarrollo (localhost:5173) |
| `pnpm build` | Build de producción (`tsc -b && vite build`) |
| `pnpm lint` | ESLint sobre todo el proyecto |
| `pnpm preview` | Vista previa del build de producción |

## Scripts disponibles

```bash
pnpm dev       # → http://localhost:5173
pnpm build     # Build de producción
pnpm lint      # ESLint
pnpm preview   # Vista previa del build
pnpm add <pkg> # Instalar dependencia
```

## Estructura del proyecto

```
src/
├── components/     # 10 componentes reutilizables (Sidebar, ProgressBar, etc.)
├── contexts/       # ThemeContext + AuthContext
├── hooks/          # useSupabaseQuery
├── pages/          # 7 páginas (Home, Auth, Inicio, Aprender, MisFinanzas, Retos, Perfil)
├── lib/            # Cliente Supabase + utilidades
└── types/          # Interfaces TS para 41 tablas BD
```

## Documentación

| Documento | Contenido |
|-----------|-----------|
| `AGENTS.md` | Documento maestro — stack, routing, auth, layout, reglas |
| `docs/DB_SCHEMA.md` | Esquema completo de BD (41 tablas, enums, índices) |
| `docs/DESIGN.md` | Sistema de diseño (CSS vars, Tailwind, principios) |
| `docs/COMPONENTS.md` | Catálogo de componentes reutilizables |
| `docs/FEATURES.md` | Mapa de 147 funcionalidades (completadas y pendientes) |

## Links de navegación

Abre estas URLs mientras el servidor de desarrollo esté corriendo (`pnpm dev`):

| Página | URL | Descripción |
|--------|-----|-------------|
| Inicio | http://localhost:5173/ | Landing page principal |
| Login | http://localhost:5173/login | Iniciar sesión |
| Registro | http://localhost:5173/register | Crear cuenta nueva |

## Equipo

- **Diego Alejandro Calderon Veloza** — [@DiegoCalderonV](https://github.com/DiegoCalderonV)
- **Juan David Carreño Gomez** — [@JuanCa205](https://github.com/JuanCa205)
- **Juan Sebastian Coy Duarte** — [@JuanCoyDuarte](https://github.com/JuanCoyDuarte)

## Licencia

MIT — ver [LICENSE](LICENSE).
