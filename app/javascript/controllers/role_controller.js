import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { required: String }

  connect () {
    const current_role = document.querySelector("meta[name=user-role]").content
    const required_role = this.requiredValue

    this.element.classList.toggle("invisible", current_role !== required_role)
  }
}
