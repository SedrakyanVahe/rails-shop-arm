import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
ActiveStorage.start()

document.addEventListener("turbolinks:load", function() {
  Turbolinks.start()
})