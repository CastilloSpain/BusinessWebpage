<script lang="ts">
  import { asset, resolve } from '$app/paths';

  let { status = 404 }: { status?: number } = $props();
  let isNotFound = $derived(status === 404);
</script>

<main
  class="dark-section flex min-h-[70vh] flex-1 items-center bg-black bg-repeat px-4 pt-28 pb-20 text-center"
  style:background-image={`url('${asset('/assets/img/hero-bg.png')}')`}
>
  <div class="reveal mx-auto max-w-2xl" data-reveal="zoom-in">
    <p class="mb-4 font-heading text-7xl font-bold text-accent md:text-8xl">{status}</p>
    <h1 class="mb-5 text-3xl font-bold text-white md:text-5xl">
      {isNotFound ? 'Page not found' : 'Something went wrong'}
    </h1>
    <p class="mx-auto mb-8 max-w-xl text-lg leading-7 text-white/75">
      {isNotFound
        ? 'The page you requested does not exist or may have moved.'
        : 'We could not display this page. Please return home and try again.'}
    </p>
    <a
      class="inline-block rounded bg-accent px-10 py-3 font-nav text-[15px] tracking-[1px] text-white uppercase hover:bg-[#8bcd85]"
      href={resolve('/')}>Return Home</a
    >
  </div>
</main>
