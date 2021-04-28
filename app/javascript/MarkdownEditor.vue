<template>
  <div>
    <v-container
      fluid
      class="grey lighten-5"
    >
      <v-row
        no-gutters
      >
        <v-col>
          <v-card
            class="pa-2"
            outlined
            tile
          >
            <v-textarea
              v-model="content"
              name="input-7-4"
            />
          </v-card>
        </v-col>
        <v-col>
          <v-card
            class="pa-2"
            outlined
            tile
          >
            <markdown-it-vue
              class="md-body"
              :content="content"
            />
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import MarkdownItVue from 'markdown-it-vue'
import 'markdown-it-vue/dist/markdown-it-vue.css'

export default {
  components: {
    MarkdownItVue
  },
  data() {
    return {
      content: '# your markdown content'
    }
  }
}
</script>
