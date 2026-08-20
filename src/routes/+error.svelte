<script lang="ts">
  import { page } from '$app/state';
  import FallbackPage from '$lib/components/FallbackPage.svelte';
</script>

<FallbackPage status={page.status} />
