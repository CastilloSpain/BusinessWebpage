<script lang="ts">
  let { size = 20 }: { size?: number } = $props();
</script>

<svg
  viewBox="0 0 24 24"
  width={size}
  height={size}
  fill="none"
  stroke="currentColor"
  stroke-width="1.8"
  stroke-linecap="round"
  stroke-linejoin="round"
  aria-hidden="true"
>
  <path d="M18 3h3l-6.6 7.5L22 21h-6l-4.7-6.2L5.8 21H3l6.9-7.9L2.6 3h6.1l4.2 5.6Z" />
</svg>
