# Cash Capital — Mapa de Funcionalidades

> Estado actual de todas las funcionalidades del proyecto.
> **✓** = Completada | **🔄** = En progreso | **⬜** = Pendiente | **–** = No aplica

---

## 1. AUTENTICACIÓN

| # | Funcionalidad | Estado | Página/Componente | Notas |
|---|---|---|---|---|
| 1.1 | Login con email+password | ✓ | `AuthPage.tsx` → `LoginForm` | `signInWithPassword`, ERROR_MAP con traducciones |
| 1.2 | Registro con email+password | ✓ | `AuthPage.tsx` → `RegisterForm` | Crea `user_profiles` + `user_settings` automáticamente |
| 1.3 | Logout | ✓ | `PerfilPage.tsx`, `MainLayout.tsx` | Limpia estado local, redirect a `/login` |
| 1.4 | Sesión persistente | ✓ | `AuthContext.tsx` | `onAuthStateChange` + `getSession` |
| 1.5 | Protección de rutas | ✓ | `App.tsx` → `ProtectedRoute` | Redirect a `/login` si no hay sesión |
| 1.6 | Redirección si autenticado | ✓ | `App.tsx` → `PublicRoute` | Redirect a `/inicio` si ya hay sesión |
| 1.7 | Loading state en auth | ✓ | `App.tsx` | Spinner mientras se verifica sesión |
| 1.8 | Recuperar contraseña | ⬜ | `AuthPage.tsx` | Botón "¿Olvidaste tu contraseña?" sin implementar |
| 1.9 | Rate limiting local | ⬜ | `AuthPage.tsx` | Cooldown progresivo en login |
| 1.10 | Confirmación de email | ⬜ | Supabase config | Depende de configuración server-side |

---

## 2. LAYOUT Y NAVEGACIÓN

| # | Funcionalidad | Estado | Componente | Notas |
|---|---|---|---|---|
| 2.1 | Sidebar desktop (md+) | ✓ | `Sidebar.tsx` | 5 íconos, expandible en hover (`w-16` → `w-56`) |
| 2.2 | BottomNav mobile | ✓ | `BottomNav.tsx` | 5 ítems, Inicio centrado |
| 2.3 | Indicador deslizante sidebar | ✓ | `Sidebar.tsx` | Indicador violeta se desliza al ítem activo |
| 2.4 | Indicador deslizante bottom nav | ✓ | `BottomNav.tsx` | Indicador horizontal se desliza al ítem activo |
| 2.5 | Header sticky | ✓ | `MainLayout.tsx` | Avatar, nombre, ThemeToggle, logout |
| 2.6 | Layout persistente (Outlet) | ✓ | `App.tsx` + `MainLayout.tsx` | Sidebar/header no se remontan al navegar |
| 2.7 | Transición sidebar sin salto inicial | ✓ | `Sidebar.tsx` | `useLayoutEffect` + mounted flag |
| 2.8 | Safe area en mobile | ✓ | `BottomNav.tsx` | `safe-area-bottom` para notch |

---

## 3. TEMA (CLARO/OSCURO)

| # | Funcionalidad | Estado | Archivo | Notas |
|---|---|---|---|---|
| 3.1 | Toggle claro/oscuro | ✓ | `ThemeToggle.tsx` + `ThemeContext.tsx` | Sun/Moon con transición |
| 3.2 | Persistencia en localStorage | ✓ | `ThemeContext.tsx` | Key `cash-capital-theme` |
| 3.3 | Fallback prefers-color-scheme | ✓ | `ThemeContext.tsx` | `getInitialTheme()` |
| 3.4 | CSS Custom Properties | ✓ | `index.css` | 16 variables por modo |
| 3.5 | Contraste WCAG AA en dark | ✓ | `index.css` | `#94a3b8` para texto terciario |

---

## 4. PÁGINAS PÚBLICAS

### 4.1 HomePage (`/`)

| # | Funcionalidad | Estado | Notas |
|---|---|---|---|
| 4.1.1 | Hero con gradiente | ✓ | Texto gradient violet→fuchsia |
| 4.1.2 | 3 feature cards | ✓ | Lecciones, Desafíos, Gamificación |
| 4.1.3 | CTA "Comienza Gratis" | ✓ | Navega a `/register` |
| 4.1.4 | ThemeToggle en landing | ✓ | Flotante en header |

### 4.2 AuthPage (`/login`, `/register`)

| # | Funcionalidad | Estado | Notas |
|---|---|---|---|
| 4.2.1 | Toggle slider Login/Register | ✓ | Slider animado 300ms |
| 4.2.2 | Formulario login | ✓ | Email + password + recordarme |
| 4.2.3 | Formulario registro | ✓ | Nombre + email + password + confirmar + términos |
| 4.2.4 | Mostrar/ocultar password | ✓ | Eye/EyeOff iconos |
| 4.2.5 | Traducción errores Supabase | ✓ | ERROR_MAP con 9 entradas |
| 4.2.6 | Loading state en botones | ✓ | Loader2 + texto "Ingresando..." / "Creando cuenta..." |
| 4.2.7 | Validación de inputs | ✓ | `sanitizeInput()` en utils |
| 4.2.8 | Aceptar términos obligatorio | ✓ | Botón deshabilitado hasta aceptar |
| 4.2.9 | Focus visible en inputs | ✓ | `focus-visible:ring-2` |

---

## 5. PÁGINAS PROTEGIDAS

### 5.1 InicioPage (`/inicio`) — Dashboard

| # | Funcionalidad | Estado | Notas |
|---|---|---|---|
| 5.1.1 | Saludo personalizado | ✓ | "¡Hola, {nombre}!" con fallback "Financiero" |
| 5.1.2 | Stat cards (4) | ✓ | Puntos, Racha, Ingresos, Gastos |
| 5.1.3 | Nivel actual con barra de progreso | ✓ | `ProgressBar` con gradiente |
| 5.1.4 | Actividad reciente | ✓ | 5 últimas actividades con `timeAgo` |
| 5.1.5 | Tip del día | ✓ | Desde `daily_tips` |
| 5.1.6 | Retos activos (hasta 3) | ✓ | Con barra de progreso |
| 5.1.7 | Loading state con skeletons | ✓ | Skeletons por sección |
| 5.1.8 | Empty states | ✓ | Actividad y retos vacíos |
| 5.1.9 | Nivel por defecto si falta | ✓ | Fallback a level_number=1 |
| 5.1.10 | Cálculo ingresos/gastos del mes | ✓ | Filtro por mes actual |

### 5.2 AprenderPage (`/aprender`) — Módulos Educativos

| # | Funcionalidad | Estado | Notas |
|---|---|---|---|
| 5.2.1 | Listado de módulos | ✓ | Con orden, solo activos |
| 5.2.2 | Accordion expandible por módulo | ✓ | Chevron animado |
| 5.2.3 | Barra de progreso global | ✓ | Lecciones completadas / totales |
| 5.2.4 | Badge de dificultad | ✓ | `DifficultyBadge` componente |
| 5.2.5 | Estado de cada lección | ✓ | CheckCircle/Play/Clock |
| 5.2.6 | Contador de lecciones por módulo | ✓ | "3/5" |
| 5.2.7 | Loading state (skeletons) | ✓ | 3 skeleton cards |
| 5.2.8 | Empty state | ✓ | "No hay módulos disponibles aún" |
| 5.2.9 | Placeholder simuladores | ✓ | "Próximamente" |
| 5.2.10 | Placeholder biblioteca | ✓ | "Accede a artículos, videos..." |
| 5.2.11 | **Ver contenido de lección** | ⬜ | Nueva ruta `/aprender/:id` pendiente |
| 5.2.12 | **Marcar lección completada** | ⬜ | Actualizar `lesson_progress` |
| 5.2.13 | **Tomar quizzes** | ⬜ | Tablas con seeds, sin UI |
| 5.2.14 | **Simuladores interactivos** | ⬜ | savings, debt, compound_interest, budget, investment |
| 5.2.15 | **Biblioteca de recursos** | ⬜ | articles, videos, pdfs, links |

### 5.3 MisFinanzasPage (`/mis-finanzas`) — Control Financiero

| # | Funcionalidad | Estado | Notas |
|---|---|---|---|
| 5.3.1 | Resumen ingresos/gastos/balance | ✓ | 3 cards con color según signo |
| 5.3.2 | Últimos ingresos del mes (5) | ✓ | Solo lectura |
| 5.3.3 | Últimos gastos del mes (5) | ✓ | Solo lectura |
| 5.3.4 | Metas de ahorro activas (3) | ✓ | Solo lectura, con progreso |
| 5.3.5 | Deudas activas (3) | ✓ | Solo lectura |
| 5.3.6 | Presupuestos (3) | ✓ | Solo lectura |
| 5.3.7 | **Agregar ingreso** | ⬜ | Botón "+ Nuevo" sin implementar |
| 5.3.8 | **Agregar gasto** | ⬜ | Botón "+ Nuevo" sin implementar |
| 5.3.9 | **Editar/eliminar ingreso** | ⬜ | CRUD completo |
| 5.3.10 | **Editar/eliminar gasto** | ⬜ | CRUD completo |
| 5.3.11 | **CRUD metas de ahorro** | ⬜ | Crear, editar, eliminar |
| 5.3.12 | **CRUD deudas** | ⬜ | Crear, editar, eliminar |
| 5.3.13 | **CRUD presupuestos** | ⬜ | Crear, editar, eliminar |
| 5.3.14 | **Historial completo transacciones** | ⬜ | Con filtros y paginación |
| 5.3.15 | **Exportar CSV** | ⬜ | Ingresos/gastos |
| 5.3.16 | Loading state | ✓ | Skeletons |
| 5.3.17 | Empty states | ✓ | Para cada sección |

### 5.4 RetosPage (`/retos`) — Gamificación

| # | Funcionalidad | Estado | Notas |
|---|---|---|---|
| 5.4.1 | Stat cards (4) | ✓ | Retos activos, Logros, Racha, Puntos |
| 5.4.2 | Retos con barra de progreso | ✓ | Con badge de estado (activo/completado) |
| 5.4.3 | Logros (grid 2×2) | ✓ | Opacidad 50% si bloqueados |
| 5.4.4 | Insignias por rareza | ✓ | 4 colores: legendary, epic, rare, common |
| 5.4.5 | Rachas | ✓ | Current + best count |
| 5.4.6 | Historial de puntos | ✓ | Con `timeAgo()` |
| 5.4.7 | Loading state (skeletons reales) | ✓ | Skeletons con forma de card |
| 5.4.8 | Empty states | ✓ | Para cada sección |
| 5.4.9 | **Aceptar retos** | ⬜ | Unirse a retos disponibles |
| 5.4.10 | **Progreso automático de retos** | ⬜ | Actualizar `user_challenges` según acciones |
| 5.4.11 | **Notificaciones de logros** | ⬜ | Toast al desbloquear |
| 5.4.12 | **Leaderboard / ranking** | ⬜ | Comparativa entre usuarios |

### 5.5 PerfilPage (`/perfil`) — Perfil y Configuración

| # | Funcionalidad | Estado | Notas |
|---|---|---|---|
| 5.5.1 | Avatar con inicial | ✓ | Gradient + primera letra del nombre |
| 5.5.2 | Editar nombre/apellido inline | ✓ | Inputs con guardar/cancelar |
| 5.5.3 | Datos de perfil | ✓ | País, ciudad, teléfono, miembro desde |
| 5.5.4 | Toggle tema claro/oscuro | ✓ | Usa `toggleTheme()` |
| 5.5.5 | Configuración (solo lectura) | ✓ | Notificaciones, moneda, idioma |
| 5.5.6 | Metas financieras | ✓ | Solo lectura, con progreso |
| 5.5.7 | Cerrar sesión | ✓ | Link rojo con confirmación implícita |
| 5.5.8 | **Editar país, ciudad, teléfono** | ⬜ | Inline editing adicional |
| 5.5.9 | **Editar configuración** | ⬜ | Notificaciones, moneda, idioma editables |
| 5.5.10 | **Selector de avatar** | ⬜ | Elegir entre avatares disponibles |
| 5.5.11 | **CRUD metas financieras** | ⬜ | Crear, editar, eliminar |
| 5.5.12 | Loading state | ✓ | Para goals |

---

## 6. COMPONENTES REUTILIZABLES

| # | Componente | Estado | Archivo | Props |
|---|---|---|---|---|
| 6.1 | `StatCard` | ✓ | `src/components/StatCard.tsx` | `icon, label, value, sub?, color?` |
| 6.2 | `SectionCard` | ✓ | `src/components/SectionCard.tsx` | `title, icon, children` |
| 6.3 | `ProgressBar` | ✓ | `src/components/ProgressBar.tsx` | `percent, size?, color?, className?` |
| 6.4 | `DifficultyBadge` | ✓ | `src/components/DifficultyBadge.tsx` | `difficulty` |
| 6.5 | `EmptyState` | ✓ | `src/components/EmptyState.tsx` | `icon, message, className?` |
| 6.6 | `MiniCard` | ✓ | `src/components/MiniCard.tsx` | `icon, title, items, empty` |
| 6.7 | **`FormModal`** | ⬜ | Pendiente | Modal genérico para CRUDs |
| 6.8 | **`Toast`** | ⬜ | Pendiente | Notificación temporal |

---

## 7. HOOKS

| # | Hook | Estado | Archivo | Notas |
|---|---|---|---|---|
| 7.1 | `useSupabaseQuery<T>` | ✓ | `src/hooks/useSupabaseQuery.ts` | Genérico con loading/data/error/refetch |
| 7.2 | **`useSupabaseMutation`** | ⬜ | Pendiente | Para operaciones insert/update/delete |
| 7.3 | **`useToast`** | ⬜ | Pendiente | Notificaciones temporales |

---

## 8. SEGURIDAD

| # | Funcionalidad | Estado | Notas |
|---|---|---|---|
| 8.1 | RLS policies (41/41 tablas) | ✓ | `supabase/rls-policies.sql` — policies creadas y aplicadas |
| 8.2 | Sanitización de inputs | ✓ | `sanitizeInput()` en utils + aplicada en Auth y Perfil |
| 8.3 | maybeSingle() en AuthContext | ✓ | `fetchProfile()` y `refreshProfile()` usan `maybeSingle()` |
| 8.4 | Validación de errores en register | ✓ | Verificación de firstLevel |
| 8.5 | Error mapping seguro | ✓ | ERROR_MAP sin exponer detalles internos |
| 8.6 | Rate limiting en login | ⬜ | Depende de configuración Supabase |
| 8.7 | Sesión con timeout | ⬜ | Depende de configuración Supabase |
| 8.8 | CSP headers | ⬜ | Para producción |
| 8.9 | Auditoría de accesos | ⬜ | Supabase Audit |

---

## 9. INFRAESTRUCTURA

| # | Funcionalidad | Estado | Archivo/Notas |
|---|---|---|---|
| 9.1 | Migración SQL inicial | ✓ | `supabase/migrations/20260525000000_initial_schema.sql` |
| 9.2 | Seed data completa | ✓ | `supabase/seed.sql` (961 líneas, 181 registros) |
| 9.3 | RLS policies SQL | ✓ | `supabase/rls-policies.sql` |
| 9.4 | CI/CD (GitHub Actions) | ✓ | `.github/workflows/deploy.yml` |
| 9.5 | Favicon SVG | ✓ | `public/favicon.svg` |
| 9.6 | OG image SVG | ✓ | `public/og-image.svg` |
| 9.7 | .nvmrc (Node 22) | ✓ | `.nvmrc` |
| 9.8 | Favicon enlazado en index.html | ✓ | `public/favicon.svg` linkeado en `<head>` |
| 9.9 | OG meta tags en index.html | ✓ | `public/og-image.svg` con og:title, og:description, og:image |
| 9.10 | Meta description/theme-color | ✓ | description + theme-color dark/light |
| 9.11 | README.md personalizado | ✓ | Describe Cash Capital con stack, comandos, docs |
| 9.12 | Vite proxy para Supabase | ⬜ | No configurado (usa fallback localhost:8000) |
| 9.13 | Tests unitarios | ⬜ | Sin cobertura |
| 9.14 | Hooks personalizados extra | ✓ | `useSupabaseQuery` existe (1/3 hooks planificados) |
| 9.15 | Directorio styles/ | ⬜ | Vacío (Tailwind cubre todo) |
| 9.16 | Directorio assets/ | ⬜ | Vacío |

---

## 10. REPORTES Y DOCUMENTACIÓN

| # | Funcionalidad | Estado | Archivo |
|---|---|---|---|
| 10.1 | AGENTS.md completo | ✓ | Documento maestro con 14 secciones, 24 reglas |
| 10.2 | DB_SCHEMA.md | ✓ | 41 tablas, enums, índices, relaciones |
| 10.3 | DESIGN.md | ✓ | Sistema de diseño, CSS vars, Tailwind |
| 10.4 | COMPONENTS.md | ✓ | Catálogo de componentes (actualizado con 4 nuevos) |
| 10.5 | FEATURES.md | ✓ | **← ESTE ARCHIVO** |
| 10.6 | audit-findings.json | ✓ | 53 hallazgos detallados |
| 10.7 | audit-progress.json | ✓ | Seguimiento de correcciones |
| 10.8 | 6 reportes de agente | ✓ | `reports/*.md` |

---

## RESUMEN

| Módulo | Total | ✓ Completadas | ⬜ Pendientes | % Avance |
|--------|-------|---------------|---------------|----------|
| Autenticación | 10 | 7 | 3 | 70% |
| Layout/Navegación | 8 | 8 | 0 | **100%** |
| Tema | 5 | 5 | 0 | **100%** |
| HomePage | 5 | 5 | 0 | **100%** |
| AuthPage | 9 | 9 | 0 | **100%** |
| InicioPage | 10 | 10 | 0 | **100%** |
| AprenderPage | 15 | 10 | 5 | 67% |
| MisFinanzasPage | 17 | 7 | 10 | 41% |
| RetosPage | 12 | 8 | 4 | 67% |
| PerfilPage | 12 | 7 | 5 | 58% |
| Componentes | 8 | 6 | 2 | 75% |
| Hooks | 3 | 1 | 2 | 33% |
| Seguridad | 9 | 5 | 4 | 56% |
| Infraestructura | 16 | 10 | 6 | 63% |
| Documentación | 8 | 8 | 0 | **100%** |
| **TOTAL** | **147** | **106** | **41** | **72%** |
