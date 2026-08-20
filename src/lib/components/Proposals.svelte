<script lang="ts">
  import { proposals } from '$lib/data/site';
  import Card from './Card.svelte';
  import Section from './Section.svelte';
</script>

<Section id="proposals" title="Proposals" class="dark-section bg-black">
  <div class="grid gap-6 lg:grid-cols-3">
    {#each proposals as proposal (proposal.title)}
      <Card
        class="reveal proposal-card h-full bg-neutral-900 p-10 text-center"
        data-reveal="zoom-in"
        data-reveal-delay="100"
      >
        <h3 class="mb-5 text-xl font-semibold text-white">{proposal.title}</h3>
        <p>{proposal.description}</p>
      </Card>
    {/each}
  </div>
</Section>
