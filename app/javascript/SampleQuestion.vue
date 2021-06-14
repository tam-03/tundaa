<template>
  <v-container>
    <v-tabs
      v-model="tab"
      background-color="transparent"
      color="orange lighten-1 accent-4"
      grow
    >
      <v-tab
        v-for="sample in samples"
        :key="sample.id"
        :class="`sample-${sample.id}`"
      >
        例文{{ sample.id }}
      </v-tab>
    </v-tabs>

    <v-tabs-items v-model="tab">
      <v-tab-item
        v-for="sample in samples"
        :key="sample.id"
      >
        <v-card
          flat
        >
          <v-card-title>
            {{ sample.title }}
          </v-card-title>
          <v-card-text>
            <markdown-it-vue
              class="md-body"
              :content="sample.body"
            />
          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </v-container>
</template>

<script>
import MarkdownItVue from 'markdown-it-vue'
import 'markdown-it-vue/dist/markdown-it-vue.css'

export default {
  components: {
    MarkdownItVue,
  },
  data () {
    return {
      tab: null,
    }
  },
  computed: {
    samples() {
      return this.$store.getters.samples
    }
  },
  created() {
    this.getSample()
  },
  methods: {
    getSample() {
      this.$store.dispatch('getSamples', {
        template_id: this.$route.query.template
      })
    }
  },
}
</script>
