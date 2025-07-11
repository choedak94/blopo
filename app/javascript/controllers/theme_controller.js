import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon"]

  connect() {
    this.dark = (localStorage.getItem("theme") === "dark")
    if (this.dark) {
      document.documentElement.classList.add("dark")
    }
    this.updateIcon()
  }

  toggle() {
    this.dark = !this.dark
    document.documentElement.classList.toggle("dark", this.dark)
    localStorage.setItem("theme", this.dark ? "dark" : "light")
    this.updateIcon()
  }

  updateIcon() {
    this.iconTarget.innerHTML = this.dark ? this.sunIcon() : this.moonIcon()
  }

  sunIcon() {
    return `<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true"><path d="M10 3.5a.75.75 0 01.75-.75h.5a.75.75 0 010 1.5h-.5A.75.75 0 0110 3.5zM10 15.75a.75.75 0 01.75.75v.5a.75.75 0 01-1.5 0v-.5a.75.75 0 01.75-.75zM4.28 5.22a.75.75 0 011.06 0l.35.35a.75.75 0 11-1.06 1.06l-.35-.35a.75.75 0 010-1.06zM14.31 15.25a.75.75 0 011.06 0l.35.35a.75.75 0 11-1.06 1.06l-.35-.35a.75.75 0 010-1.06zM3.5 10a.75.75 0 01-.75-.75v-.5a.75.75 0 011.5 0v.5A.75.75 0 013.5 10zM16.25 10a.75.75 0 01-.75.75h-.5a.75.75 0 010-1.5h.5a.75.75 0 01.75.75zM5.22 14.28a.75.75 0 010 1.06l-.35.35a.75.75 0 11-1.06-1.06l.35-.35a.75.75 0 011.06 0zM15.25 4.31a.75.75 0 010 1.06l-.35.35a.75.75 0 11-1.06-1.06l.35-.35a.75.75 0 011.06 0zM10 6a4 4 0 100 8 4 4 0 000-8z"/></svg>`
  }

  moonIcon() {
    return `<svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" aria-hidden="true"><path d="M17.293 13.293A8 8 0 116.707 2.707a6 6 0 0010.586 10.586z"/></svg>`
  }
}
