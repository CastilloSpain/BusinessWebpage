<script lang="ts">
  import type { Snippet } from 'svelte';
  import Footer from './Footer.svelte';
  import Header from './Header.svelte';
  import ScrollTop from './ScrollTop.svelte';

  type Props = {
    children: Snippet;
    class?: string;
    showScrollTop?: boolean;
  };

  let { children, class: className, showScrollTop = true }: Props = $props();
  let mobileMenuOpen = $state(false);
</script>

<div class={['flex min-h-screen flex-col', className]}>
  <Header onMenuOpenChange={(open) => (mobileMenuOpen = open)} />
  {@render children()}
  <Footer />
  {#if showScrollTop}
    <ScrollTop hidden={mobileMenuOpen} />
  {/if}
</div>
