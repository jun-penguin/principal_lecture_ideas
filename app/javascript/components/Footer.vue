<template>
  <div>
    <v-footer app bottom fixed padless>
      <div class="flex-grow-1"></div>
      <div>
        &copy; 2022 - {{ new Date().getFullYear() }} 校長講話アイディアボックス
      </div>
    </v-footer>
  </div>
</template>

<script>
export default {
  name: "Footer",
};
</script>

<style scoped>
</style>