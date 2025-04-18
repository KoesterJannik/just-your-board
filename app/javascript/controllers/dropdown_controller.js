import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  connect() {
    // Close dropdown when clicking outside
    document.addEventListener("click", this.hide.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.hide.bind(this));
  }

  toggle() {
    this.menuTarget.classList.toggle("hidden");
  }

  hide(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden");
    }
  }
}
