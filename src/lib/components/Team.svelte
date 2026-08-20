<script lang="ts">
  import { asset } from '$app/paths';
  import { teamMembers } from '$lib/data/site';
  import ArrowLeftIcon from '$lib/icons/ArrowLeftIcon.svelte';
  import ArrowRightIcon from '$lib/icons/ArrowRightIcon.svelte';
  import Card from './Card.svelte';
  import Section from './Section.svelte';

  let carouselViewport: HTMLDivElement;

  $effect(() => {
    let timer: number | undefined;
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (timer !== undefined) window.clearInterval(timer);
        timer = entry.isIntersecting ? window.setInterval(() => move(1), 5000) : undefined;
      },
      { threshold: 0.25 }
    );

    observer.observe(carouselViewport);

    return () => {
      observer.disconnect();
      if (timer !== undefined) window.clearInterval(timer);
    };
  });

  function move(direction: -1 | 1) {
    const slide = carouselViewport.querySelector<HTMLElement>('article');
    if (!slide) return;

    const step = slide.offsetWidth;
    const maximum = carouselViewport.scrollWidth - carouselViewport.clientWidth;
    const atStart = carouselViewport.scrollLeft <= step / 2;
    const atEnd = carouselViewport.scrollLeft >= maximum - step / 2;
    const left =
      direction === 1
        ? atEnd
          ? 0
          : Math.min(maximum, carouselViewport.scrollLeft + step)
        : atStart
          ? maximum
          : Math.max(0, carouselViewport.scrollLeft - step);

    carouselViewport.scrollTo({ left, behavior: 'smooth' });
  }
</script>

<Section id="team" title="Team">
  <div class="mb-3 flex justify-end gap-2">
    <button
      class="slider-button"
      type="button"
      aria-label="Previous team members"
      onclick={() => move(-1)}><ArrowLeftIcon size={24} /></button
    >
    <button
      class="slider-button"
      type="button"
      aria-label="Next team members"
      onclick={() => move(1)}><ArrowRightIcon size={24} /></button
    >
  </div>
  <div
    class="reveal overflow-hidden scroll-smooth"
    data-reveal-delay="100"
    bind:this={carouselViewport}
  >
    <div class="flex snap-x snap-mandatory">
      {#each teamMembers as member (member.name)}
        <Card class="shrink-0 basis-full snap-start px-3.75 sm:basis-1/2 md:basis-1/3">
          <img
            class="mb-5 aspect-square w-full bg-neutral-100 object-cover"
            src={asset(member.image)}
            alt={member.name}
            width="600"
            height="600"
            loading="lazy"
            decoding="async"
            fetchpriority="low"
          />
          <h3 class="mb-1 text-xl font-semibold">{member.name}</h3>
          <span class="mb-4 block text-sm text-neutral-500">{member.role}</span>
          <p>{member.description}</p>
        </Card>
      {/each}
    </div>
  </div>
</Section>
