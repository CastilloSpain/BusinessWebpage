<script lang="ts">
  $effect(() => {
    const observer = new IntersectionObserver(
      (entries) => {
        for (const entry of entries) {
          if (!entry.isIntersecting) continue;
          entry.target.classList.add('reveal-visible');
          observer.unobserve(entry.target);
        }
      },
      { threshold: 0.1 }
    );

    const observeReveals = (root: ParentNode) => {
      root.querySelectorAll<HTMLElement>('.reveal:not(.reveal-visible)').forEach((element) => {
        observer.observe(element);
      });
    };

    observeReveals(document);
    const mutations = new MutationObserver((records) => {
      for (const record of records) {
        for (const node of record.addedNodes) {
          if (!(node instanceof HTMLElement)) continue;
          if (node.matches('.reveal:not(.reveal-visible)')) observer.observe(node);
          observeReveals(node);
        }
      }
    });

    mutations.observe(document.body, { childList: true, subtree: true });

    return () => {
      mutations.disconnect();
      observer.disconnect();
    };
  });
</script>
