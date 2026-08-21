<script lang="ts">
  import { resolve } from '$app/paths';
  import ChevronRightIcon from '$lib/icons/ChevronRightIcon.svelte';
  import SocialLinks from './SocialLinks.svelte';

  const year = new Date().getFullYear();
  const footerLinks = [
    { label: 'Home', href: '#hero' },
    { label: 'About us', href: '#about' },
    { label: 'Proposals', href: '#proposals' },
    { label: 'Terms of Service', href: '#hero' },
    { label: 'Privacy Policy', href: '#hero' }
  ] as const;
  const credits = [
    { prefix: 'Designed by', label: 'BootstrapMade', href: 'https://bootstrapmade.com/' },
    { prefix: 'Administered by', label: 'Adam Pala', href: 'https://adam-pala.com/' }
  ] as const;
  const CREDITS_SEPARATOR = ' | ';
</script>

<footer class="dark-section bg-black pt-12.5 text-sm">
  <div class="site-container grid gap-10 pb-10 md:grid-cols-2 lg:grid-cols-3">
    <div>
      <a class="font-heading text-[22px] font-bold text-white" href={resolve('/')}
        >Castillo Real Estate Group Holdings LLC</a
      >
      <div class="pt-5 leading-6">
        <p>1615 Seegar St</p>
        <p>Dallas, TX 75215</p>
        <p class="mt-3"><strong class="text-white">Phone:</strong> +1 (123) 456-7890</p>
        <p><strong class="text-white">Email:</strong> castillorealestategroupholding@gmail.com</p>
      </div>
    </div>
    <div>
      <h2 class="mb-4 text-base font-bold text-white">Useful Links</h2>
      <ul class="space-y-3">
        {#each footerLinks as link (link.label)}
          <li>
            <a class="footer-link" href={resolve(`/${link.href}`)}
              ><ChevronRightIcon size={15} />{link.label}</a
            >
          </li>
        {/each}
      </ul>
    </div>
    <div>
      <h2 class="mb-4 text-base font-bold text-white">Follow Us</h2>
      <SocialLinks class="flex gap-3" buttonStyle />
    </div>
  </div>
  <div class="site-container border-t border-white/10 py-6 text-center leading-6">
    <p>
      © Copyright {year} <strong class="text-white">Castillo Real Estate Group Holdings LLC</strong>
    </p>
    <p>All Rights Reserved</p>
    <p>
      {#each credits as credit, index (credit.href)}
        {#if index > 0}{CREDITS_SEPARATOR}{/if}
        <!-- eslint-disable-next-line svelte/no-navigation-without-resolve -- External credits are not app routes. -->
        {credit.prefix} <a href={credit.href} rel="noreferrer" target="_blank">{credit.label}</a>
      {/each}
    </p>
  </div>
</footer>
