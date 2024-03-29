document.addEventListener('turbo:load', () => {
  document.querySelectorAll('.page-number-btn').forEach(button => {
    button.addEventListener('click', (e) => {
      e.preventDefault();
      const notebookId = e.target.dataset.notebookId;
      const pageNumber = e.target.dataset.pageNumber;

      fetch(`/notebooks/${notebookId}/pages/${pageNumber}`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        if (data && data.id) {
          window.location.href = `/notebooks/${notebookId}/pages/${pageNumber}`;
        } else {
          return fetch(`/notebooks/${notebookId}/pages`, {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").getAttribute('content')
            },
            body: JSON.stringify({ page: { page_content: '新しいページの内容', page_number: pageNumber } })
          });
        }
      })
      .then(response => {
        if (response.ok) {
          return response.json();
        }
      })
      .then(data => {
        if (data && data.page_number) {
          window.location.href = `/notebooks/${notebookId}/pages/${data.page_number}`;
        }
      })
      .catch(error => {
        console.error('Error:', error);
      });
    });
  });
});