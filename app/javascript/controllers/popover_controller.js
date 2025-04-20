import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu", "arrow"];

  connect() {
    // Close the menu when clicking outside
    document.addEventListener("click", this.closeOnClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnClickOutside.bind(this));
  }

  toggle(event) {
    event.stopPropagation();
    this.menuTarget.classList.toggle("hidden");
    this.arrowTarget.classList.toggle("rotate-180");
  }

  closeOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden");
      this.arrowTarget.classList.remove("rotate-180");
    }
  }
}
