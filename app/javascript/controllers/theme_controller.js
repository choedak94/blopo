import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.load()
  }

  toggle() {
    document.documentElement.classList.toggle('dark')
    const mode = document.documentElement.classList.contains('dark') ? 'dark' : 'light'
    localStorage.setItem('theme', mode)
  }

  load() {
    const saved = localStorage.getItem('theme')
    if (saved === 'dark') {
      document.documentElement.classList.add('dark')
    }
  }
}
