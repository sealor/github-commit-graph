<script setup>
import CommitInfoList from './components/CommitInfoList.vue';
</script>

<template>
  <div class="app-container">
    <svg class="graph" :viewBox="'0 0 ' + graph.width + ' ' + graph.height" style="background-color: #eeeeee;">
      <defs>
        <marker id="marker" markerWidth="8" markerHeight="8" refX="4" refY="4">
          <circle cx="4" cy="4" r="1" />
        </marker>
      </defs>
      <path v-for="path in graph.paths" :d="path.d" :class="'level' + path.level" stroke="blue" stroke-linecap="round" />
      <text v-for="text in graph.texts" :x="text.x" :y="text.y" font-size="12px">{{text.text}}</text>
    </svg>
    <CommitInfoList class="info" :commitItemList="commitItems" />
  </div>
</template>

<script>
var REST_API_COMMITS = "https://api.github.com/repos/sealor/junkie/commits";
REST_API_COMMITS = "commits"

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
    fetch(REST_API_COMMITS)
      .then(response => response.json())
      .then(data => { this.commitItems = data })
      .catch((error) => {
        console.error('Error:', error);
      });
  },
  computed: {
    graph() {
      let paths = []
      let positions = {};
      let childs = {};
      let texts = []
      let openShas = [];
      let maxLevel = 0;

      function resolvePosX(commitSha) {
        const idx = openShas.indexOf(commitSha);
        return idx === -1 ? 0 : idx;
      }

      for (const [num, commit] of this.commitItems.entries()) {
        const posX = resolvePosX(commit.sha);
        positions[commit.sha] = {x: posX, y: num};
        maxLevel = Math.max(maxLevel, posX);

        for (const parent of commit.parents) {
          if (!(parent.sha in childs)) {
            childs[parent.sha] = [];
          }
          childs[parent.sha].push(commit.sha);
        }

        if (!(commit.sha in childs)) {
          childs[commit.sha] = [];
        }

        for (const childSha of childs[commit.sha]) {
          const x1 = 12 * (positions[childSha].x + 0) + 6;
          const x2 = 12 * (positions[commit.sha].x + 0) + 6;
          const y1 = 24 * (positions[childSha].y) + 12;
          const y2 = 24 * (positions[commit.sha].y) + 12;

          paths.push({d: `M ${x1},${y1} L ${x2},${y2}`, level: positions[commit.sha].x});
          texts.push({x: x2 + 1, y: y2, text: commit.sha.substring(0, 8)})
        }
        openShas = openShas.filter((openCommit) => openCommit != commit.sha);
        openShas = openShas.concat(commit.parents.map((commit) => commit.sha));
      };

      const width = (maxLevel + 1) * 12;
      const height = (this.commitItems.length + 0) * 24;

      return {paths, texts: [], width, height};
    },
  },
}
</script>

<style scoped>
div.app-container {
  display: grid;
  grid-template-columns: min-content auto;
}

.graph {
  height: 100%;
  min-width: 100%;
}

.info {
  height: min-content;
}

path {
  stroke-width: 4px;
  marker-start: url(#marker);
  marker-end: url(#marker);
}

path.level0 {
  stroke: blue;
}

path.level1 {
  stroke: green;
}

path.level2 {
  stroke: red;
}

</style>
