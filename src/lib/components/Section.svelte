<script lang="ts">
  import type { Snippet } from 'svelte';
  import SectionTitle from './SectionTitle.svelte';

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
    <SectionTitle {title}>
      {#if intro}{@render intro()}{/if}
    </SectionTitle>
    {@render children()}
  </div>
</section>
