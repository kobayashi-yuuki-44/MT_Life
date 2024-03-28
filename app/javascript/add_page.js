document.addEventListener('DOMContentLoaded', setupNewPageButton);
document.addEventListener('turbo:load', setupNewPageButton);

function setupNewPageButton() {
  const addButton = document.querySelector('.add-page-btn');
  if (addButton) {
    addButton.addEventListener('click', (e) => {
      e.preventDefault();
      const notebookId = addButton.dataset.notebookId;

      fetch(`/notebooks/${notebookId}/pages`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").getAttribute('content')
        },
        body: JSON.stringify({ page: { page_content: '新しいページの内容' } })
      })
      .then(response => {
        if (!response.ok) {
          return response.json().then(errorData => {
            throw new Error(`HTTP error! status: ${response.status} - ${errorData.errors}`);
          });
        }
        return response.json();
      })
      .then(data => {
        if (data && data.id) {
          window.location.href = `/notebooks/${notebookId}/pages/${data.id}`;
        } else {
          throw new Error('新しいページの作成に失敗しました。');
        }
      })
      .catch(error => {
        console.error('Error:', error);
      });
    });
  }
}