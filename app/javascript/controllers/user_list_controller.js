import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { selected: String }
  static targets = ["user"]

  connect () {
    this.userTargets.forEach(el => {
      el.addEventListener("new-message", () => {
        el.querySelector(".unread-badge").classList.remove("d-none")
      })

      el.addEventListener("read-message", () => {
        el.querySelector(".unread-badge").classList.add("d-none")
      })
    })
  }

  selectedValueChanged(value, oldValue) {
    this.userTargets.forEach(el => {
      if (el.id == value || el.id == oldValue) {
        el.dispatchEvent(new Event("read-message"))
      }

      el.querySelector("a").classList.toggle("active", el.id == value)
    })
  }
}
