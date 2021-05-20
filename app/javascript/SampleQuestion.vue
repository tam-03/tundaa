<template>
  <v-card color="basil">
    <v-tabs
      v-model="tab"
      background-color="transparent"
      color="basil"
      grow
    >
      <v-tab
        v-for="sample in samples"
        :key="sample.id"
        :class="`sample-${sample.id}`"
      >
        {{ sample.title }}
      </v-tab>
    </v-tabs>

    <v-tabs-items v-model="tab">
      <v-tab-item
        v-for="sample in samples"
        :key="sample"
      >
        <v-card
          color="basil"
          flat
        >
          <v-card-text>
            <markdown-it-vue
              class="md-body"
              :content="sample.body"
            />
          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </v-card>
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
        samples: [
          {id:1, title: "サンプル1", body: "サンプル1内容"},
          {id:2, title: "サンプル2", body: "サンプル2内容"},
          {id:3, title: "サンプル3", body: "サンプル3内容"},
        ]
      }
    },
}
</script>
