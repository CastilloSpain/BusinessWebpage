<script lang="ts">
  import { page } from '$app/state';
  import FallbackPage from '$lib/components/FallbackPage.svelte';
  import Layout from '$lib/components/Layout.svelte';
</script>

<svelte:head>
  <title>{page.status} — Castillo Real Estate Group Holdings LLC</title>
  <meta name="robots" content="noindex" />
</svelte:head>

<Layout class="bg-black" showScrollTop={false}>
  <FallbackPage status={page.status} />
</Layout>
