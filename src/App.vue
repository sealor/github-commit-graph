<script setup>
import CommitInfoList from './components/CommitInfoList.vue';
</script>

<template>
  <div class="app-container">
    <svg viewBox="0 0 15 100" height="100%">
      <defs>
        <marker id="marker" markerWidth="8" markerHeight="8" refX="4" refY="4">
          <circle cx="4" cy="4" r="1" />
        </marker>
      </defs>
      <path :d="points" />
    </svg>
    <CommitInfoList :commitItemList="commitItems" />
  </div>
</template>

<script>
export default {
  components: {
    CommitInfoList,
  },
  data() {
    return {
      commitItems: [],
    }
  },
  created() {
    fetch("https://api.github.com/repos/sealor/junkie/commits")
      .then(response => response.json())
      .then(data => { this.commitItems = data })
      .catch((error) => {
        console.error('Error:', error);
      });
  },
  computed: {
    points() {
      const pointCount = this.commitItems.length;

      var d = "";
      for (var i = 1; i <= pointCount; i++) {
        const type = i === 1 ? "M" : "L";
        const y = 100 / pointCount * (i - 0.5);
        const x = Math.round(Math.random() * 2) * 4 + 4;
        d += `${type}${x},${y} `
      }

      return d;
    },
  },
}
</script>

<style scoped>
div.app-container {
  display: grid;
  grid-template-columns: auto max-content;
}

path {
  fill: none;
  stroke: lightcoral;
  stroke-width: 0.8px;
  marker-start: url(#marker);
  marker-mid: url(#marker);
  marker-end: url(#marker);
}

polyline {
  stroke: #306f91;
  stroke-width: 3;
  fill: none;
  marker-start: url(#marker);
  marker-mid: url(#marker);
  marker-end: url(#marker);
}
</style>
