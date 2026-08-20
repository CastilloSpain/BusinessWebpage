<script lang="ts">
  import { asset } from '$app/paths';
  import ScrollReveal from '$lib/components/ScrollReveal.svelte';
  import '../app.css';

  let { children } = $props();
</script>

<svelte:head>
  <link rel="icon" type="image/png" href={asset('/assets/img/favicon-48x48.png')} sizes="48x48" />
  <link rel="icon" type="image/svg+xml" href={asset('/assets/img/favicon.svg')} />
  <link rel="shortcut icon" href={asset('/assets/img/favicon.ico')} />
  <link rel="apple-touch-icon" sizes="180x180" href={asset('/assets/img/apple-touch-icon.png')} />
  <link rel="manifest" href={asset('/assets/img/site.webmanifest')} />
  <meta name="apple-mobile-web-app-title" content="CastilloREGH" />
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="anonymous" />
  <link
    href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&family=Poppins:wght@400;500&family=Roboto:wght@300;400;500;700&display=swap"
    rel="stylesheet"
  />
</svelte:head>
<ScrollReveal />
{@render children()}
