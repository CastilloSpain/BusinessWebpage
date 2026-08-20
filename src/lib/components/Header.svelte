<script lang="ts">
  import { resolve } from '$app/paths';
  import { navItems } from '$lib/data/site';
  import CastleLogoIcon from '$lib/icons/CastleLogoIcon.svelte';
  import CloseIcon from '$lib/icons/CloseIcon.svelte';
  import FacebookIcon from '$lib/icons/FacebookIcon.svelte';
  import InstagramIcon from '$lib/icons/InstagramIcon.svelte';
  import MenuIcon from '$lib/icons/MenuIcon.svelte';
  import TwitterIcon from '$lib/icons/TwitterIcon.svelte';

  let { onMenuOpenChange }: { onMenuOpenChange?: (open: boolean) => void } = $props();
  let menuOpen = $state(false);
  let scrollY = $state(0);
  let activeSection = $state('#hero');

  $effect(() => {
    const sections = navItems
      .map((item) => document.querySelector<HTMLElement>(item.href))
      .filter((section): section is HTMLElement => section !== null);
    const observer = new IntersectionObserver(
      (entries) => {
        const visible = entries
          .filter((entry) => entry.isIntersecting)
          .sort((a, b) => b.intersectionRatio - a.intersectionRatio)[0];
        if (visible) activeSection = `#${visible.target.id}`;
      },
      { rootMargin: '-20% 0px -65% 0px', threshold: [0, 0.1] }
    );

    sections.forEach((section) => observer.observe(section));
    return () => observer.disconnect();
  });

  function closeMenu() {
    setMenuOpen(false);
  }

  function setMenuOpen(open: boolean) {
    menuOpen = open;
    onMenuOpenChange?.(open);
  }
</script>

<svelte:window bind:scrollY onkeydown={(event) => event.key === 'Escape' && closeMenu()} />

<header
  class={[
    'fixed inset-x-0 top-0 z-50 py-3.75 text-white transition-colors duration-500',
    scrollY > 100 && 'bg-black/80'
  ]}
>
  <div class="site-container flex items-center justify-between">
    <a href={resolve('/')} class="order-1 shrink-0" aria-label="Castillo Real Estate Group home">
      <CastleLogoIcon class="h-9 w-15 text-white" />
    </a>

    <nav class="order-3 xl:order-2" aria-label="Primary navigation">
      {#if menuOpen}
        <button
          type="button"
          class="fixed inset-0 z-30 cursor-default bg-black/30 xl:hidden"
          aria-label="Close navigation"
          onclick={closeMenu}
        ></button>
      {/if}
      <button
        type="button"
        class="relative z-50 grid size-9 place-items-center text-white xl:hidden"
        aria-label={menuOpen ? 'Close navigation' : 'Open navigation'}
        aria-expanded={menuOpen}
        aria-controls="primary-navigation-menu"
        onclick={() => setMenuOpen(!menuOpen)}
      >
        {#if menuOpen}
          <CloseIcon size={28} />
        {:else}
          <MenuIcon size={28} />
        {/if}
      </button>

      <div
        id="primary-navigation-menu"
        class={[
          'fixed inset-x-5 top-15 bottom-auto z-40 max-h-[calc(100vh-5rem)] overflow-y-auto rounded-md bg-white p-5 shadow-xl transition-all xl:static xl:block xl:max-h-none xl:overflow-visible xl:bg-transparent xl:p-0 xl:shadow-none',
          menuOpen ? 'visible opacity-100' : 'invisible opacity-0 xl:visible xl:opacity-100'
        ]}
      >
        <ul class="flex flex-col xl:flex-row xl:items-center">
          {#each navItems as item (item.href)}
            <li>
              <a
                href={resolve(`/${item.href}`)}
                class={[
                  'block px-5 py-3 font-nav text-[16px] whitespace-nowrap text-neutral-700 transition-colors hover:text-accent xl:px-3.75 xl:py-4.5 xl:text-white/60',
                  activeSection === item.href && 'text-accent!'
                ]}
                onclick={closeMenu}>{item.label}</a
              >
            </li>
          {/each}
        </ul>
      </div>
    </nav>

    <div
      class="order-2 ml-auto flex items-center gap-3 pr-3.75 text-white/60 xl:ml-0"
      aria-label="Social media"
    >
      <span title="X / Twitter"><TwitterIcon size={15} /></span>
      <span title="Facebook"><FacebookIcon size={15} /></span>
      <span title="Instagram"><InstagramIcon size={15} /></span>
    </div>
  </div>
</header>
