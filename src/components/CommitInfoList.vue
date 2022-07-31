<script setup>
import CommitInfo from './CommitInfo.vue';
</script>

<script>
export default {
  name: "CommitInfoList",
  components: {
    CommitInfo,
  },
  props: ["commitItemList"],
}
</script>

<template>
  <div class="commit-infos-container">
    <CommitInfo v-for="item of commitItemList" :key="item.sha" :commitItem="item" />
  </div>
</template>

<style scoped>
div.commit-infos-container {
  display: grid;
  grid-gap: 0.2em 1em;
  grid-template-columns: repeat(4, fit-content(25%));
  align-items: center;
}
</style>
