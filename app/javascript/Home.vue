<template>
  <v-container class="grey lighten-5">
    <h2>質問を作成する</h2>
    <v-row
      v-for="n in 1"
      :key="n"
      :class="n === 1 ? 'mb-6' : ''"
      no-gutters
    >
      <v-col
        v-for="card in cards"
        :key="card.title"
      >
        <v-card
          class="pa-2"
          elevation="2"
          outlined
          shaped
          tile
        >
          <v-card-title>{{ card.title }}</v-card-title>
          <v-spacer />
          <v-card-actions>
            <router-link to="/">
              <v-btn
                text
                color="teal accent-4"
              >
                作成
              </v-btn>
            </router-link>
          </v-card-actions>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data: () => ({
      cards: [
        { title: '何が分からないか分かっている' },
        { title: '何が分からないか分からない' },
        { title: 'もう何も分からない' },
      ],
    }),
    computed: {
    isAuthenticated() {
      return this.$store.getters.token !== null
    }
  }
}
</script>
