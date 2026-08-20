<script lang="ts">
  import About from '$lib/components/About.svelte';
  import CallToAction from '$lib/components/CallToAction.svelte';
  import Contact from '$lib/components/Contact.svelte';
  import Footer from '$lib/components/Footer.svelte';
  import Header from '$lib/components/Header.svelte';
  import Hero from '$lib/components/Hero.svelte';
  import Properties from '$lib/components/Properties.svelte';
  import Proposals from '$lib/components/Proposals.svelte';
  import ScrollTop from '$lib/components/ScrollTop.svelte';
  import SectionDivider from '$lib/components/SectionDivider.svelte';
  import Team from '$lib/components/Team.svelte';

  let mobileMenuOpen = $state(false);
</script>

<svelte:head>
  <title>Castillo Real Estate Group Holdings LLC</title>
  <meta name="author" content="Castillo Real Estate Group Holdings LLC" />
  <meta
    name="description"
    content="Business website for Castillo Real Estate Group Holdings LLC, a Dallas-based real estate venture."
  />
  <meta
    name="keywords"
    content="dallas real estate, castillo real estate group, castillo regh, carl castillo, real estate, dallas, dfw, cedars, bishop arts district, west dallas, oak lawn"
  />
  <meta
    property="og:title"
    content="Castillo Real Estate Group Holdings LLC - Dallas Real Estate"
  />
  <meta
    property="og:description"
    content="Business website for Castillo Real Estate Group Holdings LLC, a Dallas-based real estate venture."
  />
  <meta property="og:type" content="website" />
  <meta property="og:url" content="https://castillorealestategrouopholdings.com/" />
  <meta
    property="og:image"
    content="https://castillorealestategrouopholdings.com/assets/img/logo.svg"
  />
  <meta name="twitter:card" content="summary_large_image" />
  <meta
    name="twitter:title"
    content="Castillo Real Estate Group Holdings LLC - Dallas Real Estate"
  />
  <meta
    name="twitter:description"
    content="Business website for Castillo Real Estate Group Holdings LLC, a Dallas-based real estate venture."
  />
  <meta
    name="twitter:image"
    content="https://castillorealestategrouopholdings.com/assets/img/logo.svg"
  />
</svelte:head>

<Header onMenuOpenChange={(open) => (mobileMenuOpen = open)} />
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
<Footer />
<ScrollTop hidden={mobileMenuOpen} />
