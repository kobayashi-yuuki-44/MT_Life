import { Turbo } from "@hotwired/turbo-rails"

document.addEventListener("turbo:load", setupCard);

function setupCard() {
  document.querySelectorAll('.flex.flex-col.md\\:flex-row').forEach((card) => {
    const showDefinitionButton = card.querySelector('.show-definition');
    const hideDefinitionButton = card.querySelector('.hide-definition');
    const definition = card.querySelector('.word-definition');

    if (showDefinitionButton && hideDefinitionButton && definition) {
      showDefinitionButton.addEventListener('click', () => {
        definition.classList.remove('hidden');
        showDefinitionButton.classList.add('hidden');
        hideDefinitionButton.classList.remove('hidden');
      });

      hideDefinitionButton.addEventListener('click', () => {
        definition.classList.add('hidden');
        showDefinitionButton.classList.remove('hidden');
        hideDefinitionButton.classList.add('hidden');
      });
    }
  });
}