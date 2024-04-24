import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['menu']; // Matches the target name in the HTML

  toggleMenu() {
    this.menuTarget.classList.toggle('hidden');
  }
}
