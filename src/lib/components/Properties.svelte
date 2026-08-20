<script lang="ts">
  import { asset } from '$app/paths';
  import type { Attachment } from 'svelte/attachments';
  import { properties } from '$lib/data/site';
  import ZoomIcon from '$lib/icons/ZoomIcon.svelte';
  import Card from './Card.svelte';
  import Lightbox from './Lightbox.svelte';
  import Section from './Section.svelte';

  const filters = [
    { label: 'All', value: 'all' },
    { label: 'Cedars', value: 'cedars' },
    { label: 'Oak Lawn', value: 'oak' },
    { label: 'Bishop Arts District', value: 'bishop' },
    { label: 'West Dallas', value: 'west' }
  ] as const;
  const itemGap = 24;

  type Property = (typeof properties)[number];
  type Position = { x: number; y: number };
  type MasonryLayout = {
    columnWidth: number;
    height: number;
    positions: Record<string, Position>;
  };

  let activeFilter = $state<(typeof filters)[number]['value']>('all');
  let lightboxIndex = $state<number | null>(null);
  let masonryWidth = $state(0);
  let layoutReady = $state(false);
  let lightboxTrigger: HTMLButtonElement | null = null;
  let lightboxOpenedWithPointer = false;
  let visibleProperties = $derived(
    activeFilter === 'all'
      ? properties
      : properties.filter((property) => property.category === activeFilter)
  );
  let selectedProperty = $derived(lightboxIndex === null ? null : visibleProperties[lightboxIndex]);
  let columnCount = $derived(masonryWidth >= 992 ? 3 : masonryWidth >= 768 ? 2 : 1);
  let completeLayout = $derived(createMasonryLayout(properties, masonryWidth, columnCount));
  let filteredLayout = $derived(createMasonryLayout(visibleProperties, masonryWidth, columnCount));

  const observeMasonry: Attachment<HTMLDivElement> = (element) => {
    const updateWidth = () => {
      const width = element.getBoundingClientRect().width;
      masonryWidth = width;
      layoutReady = width > 0;
    };
    const observer = new ResizeObserver(updateWidth);

    updateWidth();
    observer.observe(element);

    return () => observer.disconnect();
  };

  function createMasonryLayout(
    items: readonly Property[],
    containerWidth: number,
    columns: number
  ): MasonryLayout {
    const columnWidth = containerWidth / columns;
    const imageWidth = Math.max(0, columnWidth - itemGap);
    const columnHeights = Array.from({ length: columns }, () => 0);
    const positions: Record<string, Position> = {};

    for (const property of items) {
      const column = columnHeights.indexOf(Math.min(...columnHeights));
      positions[property.title] = { x: column * columnWidth, y: columnHeights[column] };
      columnHeights[column] += imageWidth * (property.height / property.width) + itemGap;
    }

    return {
      columnWidth,
      height: Math.max(0, ...columnHeights) - (items.length > 0 ? itemGap : 0),
      positions
    };
  }

  function isVisible(property: Property) {
    return activeFilter === 'all' || property.category === activeFilter;
  }

  function getCardStyle(property: Property) {
    if (!layoutReady) return undefined;

    const visible = isVisible(property);
    const position = (visible ? filteredLayout.positions : completeLayout.positions)[
      property.title
    ] ?? { x: 0, y: 0 };

    return [
      `width:${filteredLayout.columnWidth}px`,
      `transform:translate3d(${position.x}px,${position.y}px,0) scale(${visible ? 1 : 0.001})`,
      `opacity:${visible ? 1 : 0}`,
      `pointer-events:${visible ? 'auto' : 'none'}`
    ].join(';');
  }

  function toggleFilter(filter: (typeof filters)[number]['value']) {
    activeFilter = activeFilter === filter ? 'all' : filter;
  }

  function openLightbox(event: MouseEvent, property: Property) {
    if (!(event.currentTarget instanceof HTMLButtonElement)) return;

    lightboxTrigger = event.currentTarget;
    lightboxOpenedWithPointer = event.detail > 0;
    lightboxIndex = visibleProperties.indexOf(property);
  }

  function closeLightbox() {
    if (lightboxOpenedWithPointer) {
      if (document.activeElement instanceof HTMLElement) document.activeElement.blur();
    } else {
      lightboxTrigger?.focus();
    }

    lightboxIndex = null;
    lightboxTrigger = null;
  }

  function moveLightbox(direction: -1 | 1) {
    if (lightboxIndex === null) return;
    lightboxIndex =
      (lightboxIndex + direction + visibleProperties.length) % visibleProperties.length;
  }

  function handleKeydown(event: KeyboardEvent) {
    if (!selectedProperty) return;
    if (event.key === 'Escape') closeLightbox();
    if (event.key === 'ArrowLeft') moveLightbox(-1);
    if (event.key === 'ArrowRight') moveLightbox(1);
  }
</script>

<svelte:window onkeydown={handleKeydown} />

<Section id="portfolio" title="Investment Properties">
  {#snippet intro()}
    <p>
      We invest with risk appetite and certainty. We are incredibly selective about the investment
      properties and prospective partnerships.
    </p>
    <p>See our focus areas below.</p>
  {/snippet}

  <div>
    <div
      class="reveal mb-5 flex flex-wrap justify-center"
      data-reveal-delay="100"
      role="group"
      aria-label="Filter properties"
    >
      {#each filters as filter (filter.value)}
        <button
          type="button"
          aria-pressed={activeFilter === filter.value}
          class={[
            'cursor-pointer rounded-full px-5 pt-2 pb-2.5 font-nav text-[15px] leading-none font-medium transition-colors max-[575px]:mb-2.5 max-[575px]:text-sm',
            activeFilter === filter.value
              ? 'bg-accent text-white'
              : 'text-neutral-700 hover:text-accent'
          ]}
          onclick={() => toggleFilter(filter.value)}>{filter.label}</button
        >
      {/each}
    </div>

    <div class="reveal" data-reveal-delay="200">
      <div
        class={[
          'portfolio-layout relative -mx-3 transition-[height,opacity] duration-500 ease-in-out',
          layoutReady
            ? 'opacity-100'
            : 'pointer-events-none grid grid-cols-1 opacity-0 min-[992px]:grid-cols-3 md:grid-cols-2'
        ]}
        class:overflow-hidden={layoutReady}
        style:height={layoutReady ? `${filteredLayout.height}px` : undefined}
        {@attach observeMasonry}
      >
        {#each properties as property (property.title)}
          <Card
            class={[
              'property-card group overflow-hidden px-3',
              layoutReady
                ? 'absolute top-0 left-0 origin-center transition-[transform,opacity] duration-500 ease-in-out will-change-transform'
                : 'relative self-start',
              !layoutReady && !isVisible(property) && 'hidden'
            ]}
            style={getCardStyle(property)}
            aria-hidden={!isVisible(property)}
            inert={!isVisible(property)}
          >
            <img
              class="block h-auto w-full"
              src={asset(property.image)}
              alt={`${property.title}, Dallas`}
              width={property.width}
              height={property.height}
              loading="lazy"
              decoding="async"
            />
            <div
              class="absolute inset-x-3 -bottom-full bg-white/90 p-3.75 opacity-0 transition-all duration-500 ease-in-out group-focus-within:bottom-0 group-focus-within:opacity-100 group-hover:bottom-0 group-hover:opacity-100"
            >
              <h3 class="pr-12 text-lg font-semibold">{property.title}</h3>
              <p class="pr-12 text-sm text-[#555]/70">{property.description}</p>
              <button
                type="button"
                class="absolute top-1/2 right-12 -translate-y-1/2 cursor-pointer leading-none text-[#555]/70 hover:text-accent"
                aria-label={`View larger image of ${property.title}`}
                onclick={(event) => openLightbox(event, property)}><ZoomIcon size={26} /></button
              >
            </div>
          </Card>
        {/each}
      </div>
    </div>
  </div>
  <Lightbox item={selectedProperty} onclose={closeLightbox} onmove={moveLightbox} />
</Section>
