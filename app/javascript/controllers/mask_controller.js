import { Controller } from "@hotwired/stimulus"
import IMask from "imask"

export default class extends Controller {
  static targets = ["input", "moneyInput"]

  initialize () {
    this.masks = {}
  }

  connect () {
    this.element.addEventListener("turbo:submit-start", this.unmask.bind(this))
  }

  inputTargetConnected (el) {
    this.maskInput(el)
  }

  moneyInputTargetConnected (el) {
    this.maskMoneyInput(el)
  }

  unmask (e) {
    this.inputTargets.forEach(el => this.unmaskFromRequest(el, e.detail))
    this.moneyInputTargets.forEach(el => this.unmaskFromRequest(el, e.detail, x => x * 100))
  }

  maskInput (el) {
    const maskId = Math.floor(Math.random() * Number.MAX_SAFE_INTEGER)
    el.dataset.maskId = maskId

    const mask = JSON.parse(el.dataset.patterns).map(mask => ({ mask }))

    this.masks[maskId] = IMask(el, { mask })
  }

  maskMoneyInput (el) {
    const maskId = Math.floor(Math.random() * Number.MAX_SAFE_INTEGER)
    const formatter = new Intl.NumberFormat("pt-BR")

    el.dataset.maskId = maskId
    el.value = formatter.format(parseInt(el.value) / 100)

    this.masks[maskId] = IMask(el, {
      mask: Number,
      padFractionalZeros: true
    })
  }

  unmaskFromRequest (el, detail, handleUnmaskedValue = x => x) {
    const unmasked = handleUnmaskedValue(this.masks[el.dataset.maskId].unmaskedValue)
    const { body } = detail.formSubmission.fetchRequest
    const { searchParams } = detail.formSubmission.location

    if (body.get(el.name)) {
      body.set(el.name, unmasked)
    }

    if (searchParams.get(el.name)) {
      searchParams.set(el.name, unmasked)
    }
  }
}
