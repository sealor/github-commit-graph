<script setup>
import { ref } from 'vue';

var response = ref(null);

fetch("https://api.github.com/repos/sealor/junkie/commits")
  .then(response => response.json())
  .then(data => { response.value = data })
  .catch((error) => {
    console.error('Error:', error);
  });
</script>

<template>
  <div v-for="item of response" :key="item.sha" class="container">
    <div>{{ item.sha }}</div>
    <div>{{ item.commit.author.name }}</div>
    <div>{{ item.commit.author.email }}</div>
  </div>
</template>

<style scoped>
div.container {
  display: grid;
  grid-gap: 0.2em 1em;
  grid-template-columns: repeat(3, fit-content(33%));
}

div {
  font-family: monospace;
}
</style>
