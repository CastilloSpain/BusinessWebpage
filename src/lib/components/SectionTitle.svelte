<script lang="ts">
  import type { Snippet } from 'svelte';

  let { title, children }: { title: string; children?: Snippet } = $props();
</script>

<div class="section-title reveal">
  <h2>{title}</h2>
  {#if children}{@render children()}{/if}
</div>
