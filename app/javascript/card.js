import { Turbo } from "@hotwired/turbo-rails"

document.addEventListener("turbo:load", setupCard);

function setupCard() {
  document.querySelectorAll('.word-card').forEach((card) => {
    const showDefinitionButton = card.querySelector('.show-definition');
    const hideDefinitionButton = card.nextElementSibling;
    const definition = card.querySelector('.word-definition');

    showDefinitionButton.addEventListener('click', () => {
      definition.classList.remove('hidden');
      showDefinitionButton.classList.add('hidden');
      hideDefinitionButton.classList.remove('hidden');
    });

    hideDefinitionButton.addEventListener('click', () => {
      definition.classList.add('hidden'); // 意味を非表示
      showDefinitionButton.classList.remove('hidden'); // 「意味を表示」ボタンを表示
      hideDefinitionButton.classList.add('hidden'); // 「隠す」ボタンを非表示
    });
  });
}