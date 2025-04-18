import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Show modal when content is loaded
    this.element.classList.remove("hidden");
  }

  close() {
    this.element.classList.add("hidden");
  }
}
