document.addEventListener('turbo:load', function() {
  setupPageContentSave();
  setupImageUpload();
});

let lastCaretPosition = null;

function setupPageContentSave() {
  const editablePage = document.querySelector('.note-page');
  if (editablePage) {
    editablePage.addEventListener('input', function(e) {
      const pageId = e.target.dataset.pageId;
      const notebookId = e.target.dataset.notebookId;
      const content = editablePage.innerHTML;
      savePageContent(pageId, notebookId, content);
    });

    editablePage.addEventListener('click', saveCaretPosition);
    editablePage.addEventListener('keyup', saveCaretPosition);
  }
}

function saveCaretPosition() {
  const selection = window.getSelection();
  if (selection.rangeCount > 0) {
    lastCaretPosition = selection.getRangeAt(0);
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
  .then(response => response.json())
  .then(data => {
    if (data.status !== 'success') {
      console.error('保存に失敗しました');
    }
  })
  .catch(error => console.error('保存エラー', error));
}

function setupImageUpload() {
  const imageUpload = document.getElementById('imageUpload');
  const editablePage = document.querySelector('.note-page');

  if (imageUpload && editablePage) {
    imageUpload.addEventListener('change', async (event) => {
      const file = event.target.files[0];
      if (file && lastCaretPosition) {
        const formData = new FormData();
        formData.append('image', file);
        formData.append('page_id', editablePage.dataset.pageId);

        try {
          const response = await fetch(`/notebooks/${editablePage.dataset.notebookId}/pages/${editablePage.dataset.pageId}/upload_image`, {
            method: 'POST',
            headers: {
              'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").getAttribute('content')
            },
            body: formData
          });

          if (response.ok) {
            const data = await response.json();
            const imageUrl = data.url;
            const img = document.createElement('img');
            img.src = imageUrl;
            img.alt = 'uploaded image';
            img.classList.add('uploaded-image');
            img.style.maxWidth = '100%';
            img.style.height = 'auto';
            img.style.width = '600px';
            img.style.float = 'left';
            img.style.marginRight = '10px';

            if (lastCaretPosition) {
              lastCaretPosition.insertNode(img);
              lastCaretPosition.collapse(false);
            } else {
              editablePage.appendChild(img);
            }

            imageUpload.value = '';

            savePageContent(editablePage.dataset.pageId, editablePage.dataset.notebookId, editablePage.innerHTML);
          } else {
            console.error('画像のアップロードに失敗しました:', response.statusText);
          }
        } catch (error) {
          console.error('フェッチエラー:', error);
        }
      }
    });
  }
}