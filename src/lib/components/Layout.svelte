<script lang="ts">
  import type { Snippet } from 'svelte';
  import type { NavItem } from '$lib/data/site';
  import Footer from './Footer.svelte';
  import Header from './Header.svelte';
  import ScrollTop from './ScrollTop.svelte';

  type Props = {
    children: Snippet;
    class?: string;
    navItems?: readonly NavItem[];
    showScrollTop?: boolean;
  };

  let { children, class: className, navItems = [], showScrollTop = true }: Props = $props();
  let mobileMenuOpen = $state(false);
</script>

<div class={['flex min-h-screen flex-col', className]}>
  <Header {navItems} onMenuOpenChange={(open) => (mobileMenuOpen = open)} />
  {@render children()}
  <Footer />
  {#if showScrollTop}
    <ScrollTop hidden={mobileMenuOpen} />
  {/if}
</div>
