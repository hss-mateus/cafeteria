import { Controller } from "@hotwired/stimulus"
import "bootstrap"

export default class extends Controller {
  connect () {
    new bootstrap.Toast(this.element).show()
  }
}
