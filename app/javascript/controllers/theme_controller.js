import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.loadTheme()
  }

  toggle() {
    if (document.documentElement.classList.contains('dark')) {
      this.setTheme('light')
    } else {
      this.setTheme('dark')
    }
  }

  loadTheme() {
    const stored = localStorage.getItem('theme')
    if (stored === 'dark' || (!stored && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      this.setTheme('dark', false)
    } else {
      this.setTheme('light', false)
    }
  }

  setTheme(theme, store = true) {
    document.documentElement.classList.toggle('dark', theme === 'dark')
    if (store) {
      localStorage.setItem('theme', theme)
    }
  }
}
