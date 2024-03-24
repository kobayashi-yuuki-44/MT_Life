import { Turbo } from "@hotwired/turbo-rails"

document.addEventListener("turbo:load", setupFlashcard);

function setupFlashcard() {
  document.querySelectorAll('.word-card').forEach((card) => {
    const showDefinitionButton = card.querySelector('.show-definition');
    const definition = card.querySelector('.word-definition');

    showDefinitionButton.addEventListener('click', () => {
      definition.classList.remove('hidden'); // 意味を表示
      showDefinitionButton.classList.add('hidden'); // ボタンを非表示
    });
  });
}