import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  connect() {
    // Close dropdown when clicking outside
    document.addEventListener("click", this.closeDropdown.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.closeDropdown.bind(this));
  }

  toggle(event) {
    event.stopPropagation();
    this.menuTarget.classList.toggle("hidden");
  }

  closeDropdown(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden");
    }
  }
}
