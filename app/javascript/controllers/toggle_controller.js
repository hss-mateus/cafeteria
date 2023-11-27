import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["visible", "hidden", "toggler"]

  connect () {
    this.visibleTargets.forEach(el => el.classList.remove("d-none"))
    this.hiddenTargets.forEach(el => el.classList.add("d-none"))

    this.perform()
  }

  perform () {
    const checkCount = this.togglerTargets.filter(el => el.checked)

    this.visibleTargets.forEach(el => el.classList.toggle("d-none", checkCount > 0))
    this.hiddenTargets.forEach(el => el.classList.toggle("d-none", checkCount == 0))
  }
}
