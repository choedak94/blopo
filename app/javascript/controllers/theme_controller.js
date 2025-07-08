import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon"]

  connect() {
    const stored = localStorage.getItem("theme") || "light"
    this.applyTheme(stored)
  }

  toggle() {
    const isDark = document.documentElement.classList.contains("dark")
    this.applyTheme(isDark ? "light" : "dark")
  }

  applyTheme(theme) {
    if (theme === "dark") {
      document.documentElement.classList.add("dark")
      document.body.classList.add("dark")
      localStorage.setItem("theme", "dark")
      this.iconTargets.forEach(el => el.textContent = "☀")
    } else {
      document.documentElement.classList.remove("dark")
      document.body.classList.remove("dark")
      localStorage.setItem("theme", "light")
      this.iconTargets.forEach(el => el.textContent = "🌙")
    }
  }
}
