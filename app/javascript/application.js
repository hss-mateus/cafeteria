import "./controllers"
import "@hotwired/turbo-rails"
import * as bootstrap from "bootstrap"
import "trix"
import "@rails/actiontext"
import "chartkick/chart.js"

if (window.matchMedia("(prefers-color-scheme: dark)").matches) {
  document.documentElement.setAttribute("data-bs-theme", "dark")
}
