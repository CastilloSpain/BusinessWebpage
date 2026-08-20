<script lang="ts">
  import ArrowUpIcon from '$lib/icons/ArrowUpIcon.svelte';

  let { hidden = false }: { hidden?: boolean } = $props();
  let scrollY = $state(0);
</script>

<svelte:window bind:scrollY />

<button
  type="button"
  {hidden}
  class={[
    'fixed right-3.75 bottom-3.75 z-50 grid size-10 place-items-center rounded bg-accent text-white transition-all hover:bg-accent/80',
    scrollY > 100 && !hidden ? 'visible opacity-100' : 'invisible translate-y-3 opacity-0'
  ]}
  aria-hidden={hidden}
  aria-label="Scroll to top"
  onclick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}><ArrowUpIcon size={22} /></button
>
