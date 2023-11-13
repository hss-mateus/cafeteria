import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "button", "form"]

  connect () {
    this.showButton()
  }

  showButton () {
    this.#setContainer(this.buttonTarget)
  }

  showForm () {
    this.#setContainer(this.formTarget)
  }

  #setContainer (el) {
    this.containerTarget.innerHTML = el.innerHTML
  }
}
