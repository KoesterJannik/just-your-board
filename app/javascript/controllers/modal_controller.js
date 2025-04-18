import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    // Initialize modal if needed
  }

  open() {
    this.modalTarget.classList.remove("hidden");
  }

  close() {
    this.modalTarget.classList.add("hidden");
  }

  // Close modal if clicking outside of modal content
  closeBackground(event) {
    if (event.target === this.modalTarget) {
      this.close();
    }
  }
}
