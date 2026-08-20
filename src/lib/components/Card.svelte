<script lang="ts">
  import type { Snippet } from 'svelte';
  import type { HTMLAttributes } from 'svelte/elements';

  let { children, ...attributes }: HTMLAttributes<HTMLElement> & { children: Snippet } = $props();
</script>

<article {...attributes}>
  {@render children()}
</article>
