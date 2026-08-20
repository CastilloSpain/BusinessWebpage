<script lang="ts">
  import EmailIcon from '$lib/icons/EmailIcon.svelte';
  import LocationIcon from '$lib/icons/LocationIcon.svelte';
  import PhoneIcon from '$lib/icons/PhoneIcon.svelte';
  import Section from './Section.svelte';

  const mapUrl =
    'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3354.8687689652506!2d-96.78925592386341!3d32.7692164843838!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x864e98fb7cdb4a4d%3A0xc325a43211c8a96a!2s1615%20Seegar%20St%2C%20Dallas%2C%20TX%2075215!5e0!3m2!1sen!2sus!4v1728167453670!5m2!1sen!2sus';
  const contactItems = [
    {
      kind: 'location',
      title: 'Address',
      value: '1615 Seegar St, Dallas, TX 75215',
      delay: 300
    },
    {
      kind: 'phone',
      title: 'Call Us',
      value: '+1 (123) 456-7890',
      href: 'tel:+1234567890',
      delay: 400
    },
    {
      kind: 'email',
      title: 'Email Us',
      value: 'castillorealestategroupholding@gmail.com',
      href: 'mailto:castillorealestategroupholding@gmail.com',
      delay: 500
    }
  ] as const;
</script>

{#snippet contactContent(item: (typeof contactItems)[number])}
  <span class="contact-icon">
    {#if item.kind === 'location'}
      <LocationIcon size={22} />
    {:else if item.kind === 'phone'}
      <PhoneIcon size={22} />
    {:else}
      <EmailIcon size={22} />
    {/if}
  </span>
  <div class:min-w-0={item.kind === 'email'}>
    <h3>{item.title}</h3>
    <p class:wrap-break-word={item.kind === 'email'}>{item.value}</p>
  </div>
{/snippet}

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
    <!-- eslint-disable svelte/no-navigation-without-resolve -- External phone and email protocols are not app routes. -->
    {#each contactItems as item (item.kind)}
      {#if 'href' in item}
        <a
          class={['contact-item reveal', item.kind === 'email' && 'min-w-0']}
          data-reveal-delay={item.delay}
          href={item.href}
        >
          {@render contactContent(item)}
        </a>
      {:else}
        <div class="contact-item reveal" data-reveal-delay={item.delay}>
          {@render contactContent(item)}
        </div>
      {/if}
    {/each}
    <!-- eslint-enable svelte/no-navigation-without-resolve -->
  </div>
</Section>
