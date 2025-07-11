import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebar", "modal"]

  connect() {
    // restore theme
    if (localStorage.getItem('theme') === 'dark') {
      document.documentElement.classList.add('dark')
    }
  }

  toggleSidebar() {
    this.sidebarTarget.classList.toggle('-translate-x-full')
  }

  toggleTheme() {
    document.documentElement.classList.toggle('dark')
    if (document.documentElement.classList.contains('dark')) {
      localStorage.setItem('theme', 'dark')
    } else {
      localStorage.removeItem('theme')
    }
  }

  openModal(event) {
    const modalContent = event.currentTarget.dataset.video
    if (modalContent && this.hasModalTarget) {
      this.modalTarget.innerHTML = modalContent
      this.modalTarget.classList.remove('hidden')
    }
  }

  closeModal() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.add('hidden')
      this.modalTarget.innerHTML = ''
    }
  }
}
