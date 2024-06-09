document.addEventListener('turbo:load', () => {
  console.log("turbo:load event triggered");
  setupModalEvents();
  setupConfirmEvents();
});

document.addEventListener('turbo:frame-load', () => {
  console.log("turbo:frame-load event triggered");
  setupModalEvents();
  setupConfirmEvents();
});

function setupModalEvents() {
  const modal = document.getElementById('newDiaryModal');
  if (!modal) return; // モーダルが存在しない場合は何もしない

  const toggleButtons = document.querySelectorAll('[data-modal-toggle="newDiaryModal"]');
  const closeButton = document.querySelectorAll('[data-modal-toggle="newDiaryModal"] + .btn');
  const cancelButton = modal.querySelector('.modal-action .btn:last-child'); // キャンセルボタンを取得

  toggleButtons.forEach(button => {
    button.addEventListener('click', () => {
      modal.classList.toggle('modal-open');
    });
  });

  closeButton.forEach(button => {
    button.addEventListener('click', () => {
      modal.classList.remove('modal-open');
    });
  });

  if (cancelButton) {
    cancelButton.addEventListener('click', () => {
      modal.classList.remove('modal-open');
    });
  }
}

function setupConfirmEvents() {
  document.querySelectorAll('form[data-confirm]').forEach((form) => {
    form.addEventListener('submit', (event) => {
      if (!confirm(form.dataset.confirm)) {
        event.preventDefault();
      }
    });
  });
}