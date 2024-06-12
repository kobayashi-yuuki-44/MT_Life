document.addEventListener('DOMContentLoaded', function() {
  setupPageContentSave();
  initializeImages();
});

document.addEventListener('turbo:load', function() {
  setupPageContentSave();
  setupImageUpload();
  initializeImages();
});

function setupPageContentSave() {
  const editablePage = document.querySelector('.note-page');
  if (editablePage) {
    editablePage.addEventListener('input', function(e) {
      const pageId = e.target.dataset.pageId;
      const notebookId = e.target.dataset.notebookId;
      const content = editablePage.innerHTML;
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

function setupImageUpload() {
  const imageUpload = document.getElementById('imageUpload');
  const editablePage = document.querySelector('.note-page');

  if (imageUpload && editablePage) {
    imageUpload.addEventListener('change', async (event) => {
      const file = event.target.files[0];
      if (file) {
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
            img.style.width = '300px';
            img.style.float = 'left';
            img.style.marginRight = '10px';
            editablePage.appendChild(img);

            imageUpload.value = '';

            savePageContent(editablePage.dataset.pageId, editablePage.dataset.notebookId, editablePage.innerHTML);
          } else {
            console.error('Image upload failed:', response.statusText);
          }
        } catch (error) {
          console.error('Fetch error:', error);
        }
      }
    });
  }
}

function initializeImages() {
  document.querySelectorAll('.uploaded-image').forEach((img) => {
    const width = img.getAttribute('width');
    const height = img.getAttribute('height');

    if (width && height) {
      img.style.width = `${width}px`;
      img.style.height = `${height}px`;
    }
  });
}