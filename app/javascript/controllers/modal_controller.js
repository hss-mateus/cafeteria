import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

export default class extends Controller {
  connect() {
    this.modal = new Modal(this.element)
  }

  open() {
    if (!this.modal.isOpened) {
      this.modal.show()
    }
  }

  close(event) {
    if (event.detail.success) {
      this.modal.hide()
    }
  }
}
