document.addEventListener('DOMContentLoaded', function() {
  setupNewPageButton();
  setupPageContentSave();
});
document.addEventListener('turbo:load', function() {
  setupNewPageButton();
  setupPageContentSave();
});

function setupNewPageButton() {
  const addButton = document.querySelector('.add-page-btn');
  if (addButton) {
    addButton.addEventListener('click', (e) => {
      e.preventDefault();
      const notebookId = addButton.dataset.notebookId;
      console.log(notebookId);
      if (notebookId === "undefined") {
        console.error('notebookId is undefined');
        return;
      }

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
          window.location.href = `/notebooks/${notebookId}/pages/1`;
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

function setupPageContentSave() {
  const editablePage = document.querySelector('.note-page');
  if (editablePage) {
    editablePage.addEventListener('blur', function(e) {
      const pageId = e.target.dataset.pageId;
      const notebookId = e.target.dataset.notebookId;
      const content = e.target.innerHTML;
      savePageContent(pageId, notebookId, content);
    });
  }
}

function savePageContent(pageId, notebookId, content) {
  fetch(`/notebooks/${notebookId}/pages/${pageId}/save_content`, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").getAttribute('content')
    },
    body: JSON.stringify({ page: { content: content }, id: pageId })
  })
  .then(response => {
    if (!response.ok) {
      return response.json().then(errorData => {
        throw new Error(`保存に失敗しました: ${response.status} - ${errorData.errors}`);
      });
    }
    return response.json();
  })
  .then(data => {
    if (data && data.status === 'success') {
      console.log('保存成功！');
    } else {
      throw new Error('保存に失敗しました。');
    }
  })
  .catch(error => {
    console.error('保存エラー', error);
  });
}