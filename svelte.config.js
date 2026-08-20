import adapter from '@sveltejs/adapter-static';

const isDevelopment = process.argv.includes('dev');

/** @type {import('@sveltejs/kit').Config} */
const config = {
  compilerOptions: {
    // Force runes mode for application code. This can be removed in Svelte 6.
    runes: true
  },
  kit: {
    adapter: adapter({ fallback: '404.html' }),
    paths: {
      base: isDevelopment ? '' : (process.env.BASE_PATH ?? '')
    }
  }
};

export default config;
