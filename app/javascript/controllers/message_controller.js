import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { user: String }

  connect () {
    const currentUser = document.querySelector('meta[name="current-user"]').content

    if (currentUser == this.userValue) {
      this.element.classList.add("bg-primary", "text-white", "align-self-end")
    } else {
      this.element.classList.add("align-self-start")
    }
  }
}
