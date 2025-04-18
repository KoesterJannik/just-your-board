import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    // Show the notice with animation
    requestAnimationFrame(() => {
      this.element.classList.add("translate-y-0", "opacity-100");
    });

    // Auto-dismiss after 5 seconds
    setTimeout(() => {
      this.dismiss();
    }, 5000);
  }

  dismiss() {
    this.element.classList.remove("translate-y-0", "opacity-100");
    this.element.classList.add("translate-y-4", "opacity-0");

    // Remove the element after animation completes
    setTimeout(() => {
      this.element.remove();
    }, 300);
  }
}
