<script lang="ts">
  import { resolve } from '$app/paths';
  import ChevronRightIcon from '$lib/icons/ChevronRightIcon.svelte';
  import FacebookIcon from '$lib/icons/FacebookIcon.svelte';
  import InstagramIcon from '$lib/icons/InstagramIcon.svelte';
  import TwitterIcon from '$lib/icons/TwitterIcon.svelte';

  const year = new Date().getFullYear();
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
        <li>
          <a class="footer-link" href={resolve('/#hero')}><ChevronRightIcon size={15} />Home</a>
        </li>
        <li>
          <a class="footer-link" href={resolve('/#about')}><ChevronRightIcon size={15} />About us</a
          >
        </li>
        <li>
          <a class="footer-link" href={resolve('/#proposals')}
            ><ChevronRightIcon size={15} />Proposals</a
          >
        </li>
        <li>
          <a class="footer-link" href={resolve('/#hero')}
            ><ChevronRightIcon size={15} />Terms of Service</a
          >
        </li>
        <li>
          <a class="footer-link" href={resolve('/#hero')}
            ><ChevronRightIcon size={15} />Privacy Policy</a
          >
        </li>
      </ul>
    </div>
    <div>
      <h2 class="mb-4 text-base font-bold text-white">Follow Us</h2>
      <div class="flex gap-3" aria-label="Social media">
        <span class="social-button" title="X / Twitter"><TwitterIcon /></span>
        <span class="social-button" title="Facebook"><FacebookIcon /></span>
        <span class="social-button" title="Instagram"><InstagramIcon /></span>
      </div>
    </div>
  </div>
  <div class="site-container border-t border-white/10 py-6 text-center leading-6">
    <p>
      © Copyright {year} <strong class="text-white">Castillo Real Estate Group Holdings LLC</strong>
    </p>
    <p>All Rights Reserved</p>
    <p>
      Designed by <a href="https://bootstrapmade.com/" rel="noreferrer" target="_blank"
        >BootstrapMade</a
      >
    </p>
    <p>
      Administered by <a href="https://adam-pala.com/" rel="noreferrer" target="_blank">Adam Pala</a
      >
    </p>
  </div>
</footer>
