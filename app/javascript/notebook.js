document.addEventListener('turbo:load', () => {
  const notePage = document.querySelector('.note-page');
  if (!notePage) return;

  notePage.addEventListener('input', function() {
    const notebookId = notePage.dataset.notebookId; // HTML要素にdata-notebook-idが設定されていることを確認
    const pageId = notePage.dataset.pageId; // HTML要素にdata-page-idが設定されていることを確認
    const content = notePage.innerHTML;

    const postUrl = `/notebooks/${notebookId}/pages/${pageId}/save_content`;

    fetch(postUrl, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ page: { content: content } })
    })
    .then(response => {
      if (!response.ok) throw new Error('HTTP error! status: ${response.status}');
      return response.json();
    })
    .then(data => {
      console.log('保存成功:', data);
    })
    .catch(error => {
      console.error('保存失敗:', error);
    });
  });
});