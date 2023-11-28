import "./controllers"
import { Turbo } from "@hotwired/turbo-rails"
import "@turbo-boost/streams"
import * as bootstrap from "bootstrap"
import "trix"
import "@rails/actiontext"
import "chartkick/chart.js"

Turbo.setConfirmMethod((message, element, button) => {
  let modal = document.querySelector("#confirm")
  let confirmButton = modal.querySelector("#confirm-button")

  modal.querySelector("#confirm-text").textContent = element.dataset.turboConfirm

  new bootstrap.Modal(modal).show()

  return new Promise(resolve => {
    modal.addEventListener("hide.bs.modal", e => {
      resolve(e.explicitOriginalTarget == confirmButton)
    }, { once: true })
  })
})
