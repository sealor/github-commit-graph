<script setup>
import { ref } from 'vue';
import CommitInfoList from './components/CommitInfoList.vue';

var response = ref([]);

fetch("https://api.github.com/repos/sealor/junkie/commits")
  .then(response => response.json())
  .then(data => { response.value = data })
  .catch((error) => {
    console.error('Error:', error);
  });
</script>

<template>
  <CommitInfoList :commitItemList="response" />
</template>

<script>
export default {
  components: {
    CommitInfoList,
  },
}
</script>

<style scoped>
</style>
