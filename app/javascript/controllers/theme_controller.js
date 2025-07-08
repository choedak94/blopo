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
      localStorage.setItem("theme", "dark")
      if (this.hasIconTarget) this.iconTarget.textContent = "☀"
    } else {
      document.documentElement.classList.remove("dark")
      localStorage.setItem("theme", "light")
      if (this.hasIconTarget) this.iconTarget.textContent = "🌙"
    }
  }
}
