<template>
    <div>{{ commit_hash }}</div>
    <div>{{ parent_commit_hashs }}</div>
    <div>{{ commitItem.commit.author.name }}</div>
    <div>{{ commitItem.commit.author.email }}</div>
</template>

<script>
export default {
    name: "CommitInfo",
    props: ["commitItem"],
    computed: {
        commit_hash() {
            return this.commitItem.sha.substring(0, 8)
        },
        parent_commit_hashs() {
            return this.commitItem.parents.map(
                val => val.sha.substring(0, 8)
            ).join(" ");
        },
    },
}
</script>

<style scoped>
div {
    font: 1.5em monospace;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>
