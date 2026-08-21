<script lang="ts">
  import About from '$lib/components/About.svelte';
  import CallToAction from '$lib/components/CallToAction.svelte';
  import Contact from '$lib/components/Contact.svelte';
  import Hero from '$lib/components/Hero.svelte';
  import Properties from '$lib/components/Properties.svelte';
  import Proposals from '$lib/components/Proposals.svelte';
  import SectionDivider from '$lib/components/SectionDivider.svelte';
  import Team from '$lib/components/Team.svelte';
</script>

<main>
  <Hero />
  <About />
  <CallToAction />
  <Properties />
  <Proposals />
  <Team />
  <SectionDivider />
  <Contact />
</main>
