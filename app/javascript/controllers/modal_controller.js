import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container"];

  connect() {
    console.log("Modal controller connected");
  }

  show() {
    this.containerTarget.classList.remove("hidden");
    document.body.classList.add("overflow-hidden");
  }

  close() {
    this.containerTarget.classList.add("hidden");
    document.body.classList.remove("overflow-hidden");
  }
}
