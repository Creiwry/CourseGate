import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("EditToggleController connected");
  }

  toggleEdit(event) {
    event.preventDefault();

    const target = event.currentTarget;
    const editPartial = target.nextElementSibling;
    editPartial.classList.toggle("hidden");
  }
}
