import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'
import router from 'router'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    token: null,
    uid: null,
    client: null,
    admin: null,
    questions: null,
    question: null,
    alertType: null,
    alertMessage: null,
    templates: null,
    template: null,
    samples: null,
    sample: null,
  },
  getters: {
    token: state => state.token,
    uid: state => state.uid,
    client: state => state.client,
    admin: state => state.admin,
    questions: state => state.questions,
    question: state => state.question,
    alertType: state => state.alertType,
    alertMessage: state => state.alertMessage,
    templates: state => state.templates,
    template: state => state.template,
    samples: state => state.samples,
    sample: state => state.sample,
  },
  mutations: {
    updateToken(state, token) {
      state.token = token
    },
    updateUid(state, uid) {
      state.uid = uid
    },
    updateclient(state, client) {
      state.client = client
    },
    updateAdmin(state, admin) {
      state.admin = admin
    },
    updateQuestions(state, questions) {
      state.questions = questions
    },
    updateQuestion(state, question) {
      state.question = question
    },
    updateAlertType(state, alertType) {
      state.alertType = alertType
    },
    updateAlertMessage(state, alertMessage) {
      state.alertMessage = alertMessage
    },
    updateTemplates(state, templates) {
      state.templates = templates
    },
    updateTemplate(state, template) {
      state.template = template
    },
    updateSamples(state, samples) {
      state.samples = samples
    },
    updateSample(state, sample) {
      state.sample = sample
    },
  },
  actions: {
    validateToken({ commit }) {
      const token = localStorage.getItem('token')
      const uid = localStorage.getItem('uid')
      const client = localStorage.getItem('client')
      axios.get('/api/auth/validate_token', {
        headers: {
          'access-token': token,
          uid: uid,
          client: client
        }
      }).then((response) => {
        const success = response.data.success
        if (!success) return
        commit('updateToken', token)
        commit('updateUid', uid)
        commit('updateclient', client)
        commit('updateAdmin', response.data.data.admin)
      })
    },
    login({ commit, dispatch }, authData) {
      axios.post('/api/auth/sign_in', {
        email: authData.email,
        password: authData.password,
      }).then(response => {
        commit('updateToken', response.headers['access-token'])
        commit('updateUid', response.headers['uid'])
        commit('updateclient', response.headers['client'])
        commit('updateAdmin', response.data.data.admin)
        localStorage.setItem('token', response.headers['access-token'])
        localStorage.setItem('uid', response.headers['uid'])
        localStorage.setItem('client', response.headers['client'])
        router.push('/home')
        dispatch('setAlert', {
          type: "success",
          message: "????????????????????????"
        })
      }).catch(() => {
        dispatch('setAlert', {
          type: "error",
          message: "?????????????????????????????????"
        })
      })
    },
    githubLogin({ dispatch }, oauthData) {
      localStorage.setItem('token', oauthData.token)
      localStorage.setItem('uid', oauthData.uid)
      localStorage.setItem('client', oauthData.client)
      dispatch('validateToken').then(() => {
        router.push('/')
        dispatch('setAlert', {
          type: "success",
          message: "????????????????????????"
        })
      }).catch(() => {
        dispatch('setAlert', {
          type: "error",
          message: "?????????????????????????????????"
        })
      })
    },
    googleLogin({ dispatch }, oauthData) {
      localStorage.setItem('token', oauthData.token)
      localStorage.setItem('uid', oauthData.uid)
      localStorage.setItem('client', oauthData.client)
      dispatch('validateToken').then(() => {
        router.push('/')
        dispatch('setAlert', {
          type: "success",
          message: "????????????????????????"
        })
      }).catch(() => {
        dispatch('setAlert', {
          type: "error",
          message: "?????????????????????????????????"
        })
      })
    },
    register({ commit, dispatch }, authData) {
      axios.post('/api/auth/', {
        email: authData.email,
        password: authData.password,
        password_confirmation: authData.password_confirmation
      }).then(response => {
        commit('updateToken', response.headers['access-token'])
        commit('updateUid', response.headers['uid'])
        commit('updateclient', response.headers['client'])
        router.push('/')
        dispatch('setAlert', {
          type: "success",
          message: "???????????????????????????????????????"
        })
      }).catch(() => {
        dispatch('setAlert', {
          type: "error",
          message: "???????????????????????????????????????"
        })
      })
    },
    logout({ commit, state, dispatch }) {
      axios.delete('api/auth/sign_out', {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        }
      }).then(() => {
        commit('updateToken', null)
        commit('updateUid', null)
        commit('updateclient', null)
        commit('updateAdmin', null)
        localStorage.removeItem('token')
        localStorage.removeItem('uid')
        localStorage.removeItem('client')
        router.replace('/login')
        dispatch('setAlert', {
          type: "success",
          message: "???????????????????????????"
        })
      })
    },
    saveQuestion({ state, dispatch }, questionData) {
      axios.post('/api/questions', {
        title: questionData.title,
        body: questionData.body,
        template_id: questionData.template_id,
      }, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        }
      }).then(() => {
        router.push('/')
      })
      dispatch('setAlert', {
        type: "success",
        message: "??????????????????"
      })
    },
    getQuestions({ commit, state }) {
      axios.get('api/questions.json', {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        }
      }).then(response => {
        commit('updateQuestions', response.data.questions)
      })
    },
    getQuestion({ commit, state }, id) {
      axios.get(`${id.questionId}.json`, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        },
        baseURL: '/api/questions/'
      }).then(response => {
        commit('updateQuestion', response.data)
      })
    },
    editQuestion({ state, dispatch }, editQuestionData) {
      axios.patch(`${editQuestionData.id}.json`, {
        title: editQuestionData.title,
        body: editQuestionData.body
      }, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        },
        baseURL: '/api/questions/'
      }).then(() => {
        router.push('/questions')
      })
      dispatch('setAlert', {
        type: "success",
        message: "???????????????????????????"
      })
    },
    deleteQuestion({ state, dispatch }, deleteQuestionData) {
      axios.delete(`${deleteQuestionData.id}.json`, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        },
        baseURL: '/api/questions/'
      }).then(() => {
        router.push('/questions')
      })
      dispatch('setAlert', {
        type: "success",
        message: "??????????????????"
      })
    },
    setAlert({ commit }, alertData) {
      commit('updateAlertType', alertData.type)
      commit('updateAlertMessage', alertData.message)
      setTimeout(() => {
        commit('updateAlertType', null)
        commit('updateAlertMessage', null)
      },3000)
    },
    getTemplates({ commit }) {
      axios.get('api/templates.json').then(response => {
        commit('updateTemplates', response.data.templates)
      })
    },
    passTemplate({ commit }, passData) {
      commit('updateTemplate', passData.template)
    },
    saveTemplate({ state, dispatch }, templateData) {
      axios.post('/api/templates', {
        title: templateData.title,
        body: templateData.body
      }, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        }
      }).then(() => {
        router.push('/templates')
      })
      dispatch('setAlert', {
        type: "success",
        message: "??????????????????"
      })
    },
    editTemplate({ commit, state, dispatch }, editTemplateData) {
      axios.patch(`${editTemplateData.id}.json`, {
        title: editTemplateData.title,
        body: editTemplateData.body
      }, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        },
        baseURL: '/api/templates/'
      }).then((response) => {
        commit('updateTemplate', response.data.template)
        router.push('/templates')
      })
      dispatch('setAlert', {
        type: "success",
        message: "???????????????????????????"
      })
    },
    deleteTemplate({ commit, state, dispatch }, deleteTemplateData) {
      axios.delete(`${deleteTemplateData.id}.json`, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        },
        baseURL: '/api/templates/'
      }).then(() => {
        commit('updateTemplate', null)
        router.push('/templates')
      })
      dispatch('setAlert', {
        type: "success",
        message: "??????????????????"
      })
    },
    getSamples({ commit, state }, getSamplesData) {
      axios.get(`${getSamplesData.template_id}/samples.json`, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        },
        baseURL: '/api/templates/'
      }).then(response => {
        commit('updateSamples', response.data.samples)
      })
    },
    saveSample({ state, dispatch }, saveSampleData) {
      axios.post(`${saveSampleData.template_id}/samples.json`, {
        title: saveSampleData.title,
        body: saveSampleData.body,
        template_id: saveSampleData.template_id
      }, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        },
        baseURL: '/api/templates/'
      }).then(() => {
        router.push(`/templates/${saveSampleData.template_id}/samples`)
      })
      dispatch('setAlert', {
        type: "success",
        message: "??????????????????"
      })
    },
    getSample({ commit, state }, getSampleData) {
      axios.get(`${getSampleData.template_id}/samples/${getSampleData.id}.json`, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        },
        baseURL: '/api/templates/'
      }).then(response => {
        commit('updateSample', response.data)
      })
    },
    editSample({ state, dispatch }, editSampleData) {
      axios.patch(`${editSampleData.template_id}/samples/${editSampleData.id}.json`, {
        title: editSampleData.title,
        body: editSampleData.body
      }, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        },
        baseURL: '/api/templates/'
      }).then(() => {
        router.push(`/templates/${editSampleData.template_id}/samples`)
      })
      dispatch('setAlert', {
        type: "success",
        message: "???????????????????????????"
      })
    },
    deleteSample({ state, dispatch }, deleteSampleData) {
      axios.delete(`${deleteSampleData.template_id}/samples/${deleteSampleData.id}.json`, {
        headers: {
          'access-token': state.token,
          uid: state.uid,
          client: state.client
        },
        baseURL: '/api/templates/'
      }).then(() => {
        router.push(`/templates/${deleteSampleData.template_id}/samples`)
      })
      dispatch('setAlert', {
        type: "success",
        message: "??????????????????"
      })
    },
  }
})
