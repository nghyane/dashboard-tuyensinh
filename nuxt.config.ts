// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-05-15',
  devtools: { enabled: true },

  modules: [
    '@nuxt/ui-pro',
    '@nuxt/icon',
    '@nuxt/eslint',
    '@nuxt/fonts',
    '@nuxt/image'
  ],

  // Fix Tailwind CSS sourcemap warnings
  vite: {
    build: {
      sourcemap: false
    },
    css: {
      devSourcemap: false
    }
  },

  // Alternative: Configure CSS build options
  css: [],

  // Suppress Tailwind CSS warnings in production
  nitro: {
    esbuild: {
      options: {
        target: 'esnext'
      }
    }
  }
})