<script lang="ts">
  import FacebookIcon from '$lib/icons/FacebookIcon.svelte';
  import InstagramIcon from '$lib/icons/InstagramIcon.svelte';
  import TwitterIcon from '$lib/icons/TwitterIcon.svelte';

  type SocialNetwork = 'twitter' | 'facebook' | 'instagram';

  const socialNetworks: { name: SocialNetwork; label: string }[] = [
    { name: 'twitter', label: 'X / Twitter' },
    { name: 'facebook', label: 'Facebook' },
    { name: 'instagram', label: 'Instagram' }
  ];

  let {
    class: className = '',
    iconSize,
    buttonStyle = false
  }: { class?: string; iconSize?: number; buttonStyle?: boolean } = $props();
</script>

{#snippet socialIcon(network: SocialNetwork)}
  {#if network === 'twitter'}
    <TwitterIcon size={iconSize} />
  {:else if network === 'facebook'}
    <FacebookIcon size={iconSize} />
  {:else}
    <InstagramIcon size={iconSize} />
  {/if}
{/snippet}

<div class={className} aria-label="Social media">
  {#each socialNetworks as network (network.name)}
    <span class={buttonStyle ? 'social-button' : undefined} title={network.label}>
      {@render socialIcon(network.name)}
    </span>
  {/each}
</div>
