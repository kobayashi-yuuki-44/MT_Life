import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["image"];

  preview() {
    const input = this.imageTarget;
    if (input.files && input.files[0]) {
      const reader = new FileReader();

      reader.onload = (event) => {
        this.previewImage.src = event.target.result;
      };

      reader.readAsDataURL(input.files[0]);
    }
  }

  get previewImage() {
    return document.getElementById('preview');
  }
}
