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
    questions: null,
    question: null,
    alertType: null,
    alertMessage: null,
    templates: null,
  },
  getters: {
    token: state => state.token,
    uid: state => state.uid,
    client: state => state.client,
    questions: state => state.questions,
    question: state => state.question,
    alertType: state => state.alertType,
    alertMessage: state => state.alertMessage,
    templates: state => state.templates,
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
        localStorage.setItem('token', response.headers['access-token'])
        localStorage.setItem('uid', response.headers['uid'])
        localStorage.setItem('client', response.headers['client'])
        router.push('/').catch(err => {
          console.info(err)
        })
        dispatch('setAlert', {
          type: "success",
          message: "ログインしました"
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
          message: "アカウント登録が完了しました"
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
        localStorage.removeItem('token')
        localStorage.removeItem('uid')
        localStorage.removeItem('client')
        router.replace('/login')
        dispatch('setAlert', {
          type: "success",
          message: "ログアウトしました"
        })
      })
    },
    saveQuestion({ state, dispatch }, questionData) {
      axios.post('/api/questions', {
        title: questionData.title,
        body: questionData.content
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
        message: "保存しました"
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
        message: "編集を保存しました"
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
        message: "削除しました"
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
  }
})
