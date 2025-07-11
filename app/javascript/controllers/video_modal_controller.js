import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "video"]

  open(event) {
    const url = event.currentTarget.dataset.url
    if (url) {
      this.videoTarget.src = url
    }
    this.modalTarget.classList.remove('hidden')
  }

  close() {
    this.modalTarget.classList.add('hidden')
    this.videoTarget.pause()
  }
}
