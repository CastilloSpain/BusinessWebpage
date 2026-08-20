<script lang="ts">
  import EmailIcon from '$lib/icons/EmailIcon.svelte';
  import LocationIcon from '$lib/icons/LocationIcon.svelte';
  import PhoneIcon from '$lib/icons/PhoneIcon.svelte';
  import Section from './Section.svelte';

  const mapUrl =
    'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3354.8687689652506!2d-96.78925592386341!3d32.7692164843838!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x864e98fb7cdb4a4d%3A0xc325a43211c8a96a!2s1615%20Seegar%20St%2C%20Dallas%2C%20TX%2075215!5e0!3m2!1sen!2sus!4v1728167453670!5m2!1sen!2sus';
</script>

<Section id="contact" title="Contact">
  {#snippet intro()}<p>Work with Us</p>{/snippet}
  <iframe
    class="reveal mb-10 h-67.5 w-full border-0"
    data-reveal-delay="200"
    title="Map showing 1615 Seegar Street in Dallas"
    src={mapUrl}
    loading="lazy"
    referrerpolicy="no-referrer-when-downgrade"
  ></iframe>

  <div class="grid gap-6 lg:grid-cols-3">
    <div class="contact-item reveal" data-reveal-delay="300">
      <span class="contact-icon"><LocationIcon size={22} /></span>
      <div>
        <h3>Address</h3>
        <p>1615 Seegar St, Dallas, TX 75215</p>
      </div>
    </div>
    <a class="contact-item reveal" data-reveal-delay="400" href="tel:+1234567890">
      <span class="contact-icon"><PhoneIcon size={22} /></span>
      <div>
        <h3>Call Us</h3>
        <p>+1 (123) 456-7890</p>
      </div>
    </a>
    <a
      class="contact-item reveal min-w-0"
      data-reveal-delay="500"
      href="mailto:castillorealestategroupholding@gmail.com"
    >
      <span class="contact-icon"><EmailIcon size={22} /></span>
      <div class="min-w-0">
        <h3>Email Us</h3>
        <p class="wrap-break-word">castillorealestategroupholding@gmail.com</p>
      </div>
    </a>
  </div>
</Section>
