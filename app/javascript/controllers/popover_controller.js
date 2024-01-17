import { Controller } from "@hotwired/stimulus"
import "bootstrap"

export default class extends Controller {
  static targets = ["trigger", "template"]

  connect () {
    const content = document.createElement("div")
    content.innerHTML = this.templateTarget.innerHTML

    new bootstrap.Popover(this.triggerTarget, { content, trigger: "focus", html: true })
  }
}
