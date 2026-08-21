<script lang="ts">
  import type { Snippet } from 'svelte';

  type Props = {
    id: string;
    title: string;
    class?: string;
    intro?: Snippet;
    children: Snippet;
  };

  let { id, title, class: className = '', intro, children }: Props = $props();
</script>

<section {id} class={['page-section', className]}>
  <div class="site-container">
    <div class="section-title reveal">
      <h2>{title}</h2>
      {#if intro}{@render intro()}{/if}
    </div>
    {@render children()}
  </div>
</section>
