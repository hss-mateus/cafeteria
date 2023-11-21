import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "template"]

  add (e) {
    e.preventDefault()

    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    this.containerTarget.insertAdjacentHTML("beforeend", content)
  }

  remove (e) {
    e.preventDefault()

    const wrapper = e.target.closest(".nested-field-wrapper")

    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove()
    } else {
      wrapper.style.display = "none"
      wrapper.querySelector("input[name*='_destroy']").value = "1"
    }
  }
}
