import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

if (!supabaseUrl || !supabaseAnonKey) {
  console.warn(
    '⚠️  Supabase no configurado correctamente. Para que la app funcione:\n' +
    '   1. Crea un archivo .env en la raíz del proyecto\n' +
    '   2. Agrega VITE_SUPABASE_URL y VITE_SUPABASE_ANON_KEY\n' +
    '   3. Reinicia el servidor de desarrollo (pnpm dev)\n' +
    '   Ejemplo:\n' +
    '     VITE_SUPABASE_URL=http://localhost:8000\n' +
    '     VITE_SUPABASE_ANON_KEY=tu-anon-key-aqui\n' +
    '   Mientras tanto, se usará fallback a localhost:8000 (solo desarrollo local).'
  )
}

export const supabase = createClient(
  supabaseUrl || 'http://localhost:8000',
  supabaseAnonKey || ''
)
