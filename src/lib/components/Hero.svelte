<script lang="ts">
  import { asset } from '$app/paths';
</script>

<section
  id="hero"
  class="dark-section relative flex min-h-screen items-center justify-center overflow-hidden bg-repeat px-4 py-20 text-center"
  style:background-image={`url('${asset('/assets/img/hero-bg.png')}')`}
>
  <div class="reveal relative z-10 mx-auto max-w-330" data-reveal="zoom-out">
    <img
      class="mx-auto mb-3 w-1/4 max-w-80 min-w-40"
      src={asset('/assets/img/logo.svg')}
      alt="Castillo Real Estate Group logo"
    />
    <h1 class="mb-7.5 text-[30px] leading-tight font-bold text-white md:text-5xl">
      Castillo Real Estate Group Holdings LLC
    </h1>
    <a
      class="inline-block rounded bg-accent px-10 py-3 text-[15px] font-normal tracking-[1px] text-white uppercase hover:bg-[#8bcd85]"
      href="#about">Get Started</a
    >
  </div>
</section>
