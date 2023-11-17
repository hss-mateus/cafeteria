import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { starCount: Number }
  static targets = ["template"]

  connect () {
    this.#addAnimations()
  }

  #addAnimations () {
    let links = this.element.querySelectorAll("a")
    let count = this.starCountValue || 0

    links.forEach((link, i) => {
      link.addEventListener("mouseenter", () => this.#fillCount(i+1))
      link.addEventListener("mouseleave", () => this.#fillCount(count))
    })
  }

  #fillCount (count) {
    let iconsToFill = this.#icons.slice(0, count)
    let iconsToEmpty = this.#icons.slice(count)

    iconsToFill.forEach(this.#fillIcon.bind(this))
    iconsToEmpty.forEach(this.#emptyIcon.bind(this))
  }

  #fillIcon (icon) {
    icon.classList.remove("bi-star")
    icon.classList.add("bi-star-fill")
  }

  #emptyIcon (icon) {
    icon.classList.remove("bi-star-fill")
    icon.classList.add("bi-star")
  }

  get #icons () {
    return Array.from(this.element.querySelectorAll("i.bi"))
  }
}
