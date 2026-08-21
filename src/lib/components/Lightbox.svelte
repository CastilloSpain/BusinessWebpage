<script lang="ts">
  import { asset } from '$app/paths';
  import ArrowLeftIcon from '$lib/icons/ArrowLeftIcon.svelte';
  import ArrowRightIcon from '$lib/icons/ArrowRightIcon.svelte';
  import CloseIcon from '$lib/icons/CloseIcon.svelte';

  type LightboxItem = {
    title: string;
    image: string;
  };

  type Props = {
    item: LightboxItem | null;
    onclose: () => void;
    onmove: (direction: -1 | 1) => void;
  };

  const controls = [
    {
      direction: -1,
      label: 'Previous image',
      class: 'absolute left-3 cursor-pointer text-white/80 hover:text-white md:left-8'
    },
    {
      direction: 1,
      label: 'Next image',
      class: 'absolute right-3 cursor-pointer text-white/80 hover:text-white md:right-8'
    }
  ] as const;

  let { item, onclose, onmove }: Props = $props();
</script>

{#snippet directionalIcon(direction: -1 | 1)}
  {#if direction === -1}
    <ArrowLeftIcon size={38} />
  {:else}
    <ArrowRightIcon size={38} />
  {/if}
{/snippet}

{#if item}
  <div
    class="fixed inset-0 z-1000 grid place-items-center bg-black/95 p-4"
    role="dialog"
    aria-modal="true"
    aria-label={`${item.title} image preview`}
  >
    <button
      class="absolute top-5 right-5 cursor-pointer text-white/80 hover:text-white"
      type="button"
      aria-label="Close preview"
      onclick={onclose}><CloseIcon size={34} /></button
    >
    {#each controls as control (control.direction)}
      <button
        class={control.class}
        type="button"
        aria-label={control.label}
        onclick={() => onmove(control.direction)}
      >
        {@render directionalIcon(control.direction)}
      </button>
    {/each}
    <figure class="max-h-[90vh] max-w-5xl text-center">
      <img
        class="max-h-[82vh] max-w-full object-contain"
        src={asset(item.image)}
        alt={`${item.title}, Dallas`}
      />
      <figcaption class="mt-3 font-heading text-white">{item.title}</figcaption>
    </figure>
  </div>
{/if}
