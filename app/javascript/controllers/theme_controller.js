import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sun", "moon"]

  connect() {
    this.loadTheme()
  }

  toggle() {
    if (document.documentElement.classList.contains('dark')) {
      this.setLight()
    } else {
      this.setDark()
    }
  }

  loadTheme() {
    const theme = localStorage.getItem('theme')
    if (theme === 'dark' || (!theme && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      this.setDark(false)
    } else {
      this.setLight(false)
    }
  }

  setDark(save = true) {
    document.documentElement.classList.add('dark')
    this.sunTarget.classList.add('hidden')
    this.moonTarget.classList.remove('hidden')
    if (save) localStorage.setItem('theme', 'dark')
  }

  setLight(save = true) {
    document.documentElement.classList.remove('dark')
    this.sunTarget.classList.remove('hidden')
    this.moonTarget.classList.add('hidden')
    if (save) localStorage.setItem('theme', 'light')
  }
}
