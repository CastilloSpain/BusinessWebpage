<script lang="ts">
  import { asset } from '$app/paths';
  import Section from './Section.svelte';
</script>

<Section id="about" title="About">
  <div class="reveal grid items-start gap-6 lg:grid-cols-2" data-reveal-delay="100">
    <img class="w-full" src={asset('/assets/img/about.jpg')} alt="Carl Castillo" />
    <div class="content-copy">
      <h3>Founder/CEO Carl Castillo</h3>
      <p>
        Carl is an unequivocally serial winner with a track record that includes higher education
        and professional accomplishments. Most recently Carl is the founder of Castillo Real Estate
        Group Holdings LLC, preeminent real estate holdings company operating in the State of Texas.
      </p>
      <p>
        Carl began his career working for Merrill (formerly Merrill Lynch LLP) for niche client net
        worth wealth and portfolio management. After exiting Merrill, Carl was recruited to work for
        PricewaterhouseCoopers (PwC) in advisory and legal services.
      </p>
    </div>
  </div>
</Section>
