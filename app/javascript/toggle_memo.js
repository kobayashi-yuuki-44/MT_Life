console.log('Toggle memo script loaded');
document.addEventListener("turbo:load", function() {
  console.log("turbo:load event triggered");
  const toggleButton = document.getElementById("toggle-memo");
  const memoContent = document.getElementById("content");
  const editableMemo = document.getElementById("editable-memo");

  console.log({ toggleButton, memoContent });

  if (toggleButton && memoContent) {
    console.log("Adding event listener");
    toggleButton.addEventListener("click", function() {
      console.log("Toggle button clicked");
      memoContent.style.display = memoContent.style.display === "none" ? "block" : "none";
      toggleButton.textContent = memoContent.style.display === "block" ? "メモを隠す" : "メモを見る";
      adjustMemoContentHeight();
    });
  }
  
  if (editableMemo) {
    const questionId = editableMemo.getAttribute('data-question-id');
    const memoId = editableMemo.getAttribute('data-memo-id');
  
    editableMemo.addEventListener('blur', function() {
      const content = getSanitizedContent(editableMemo);
      console.log("Edited content:", content);
      
      const memoUpdateUrl = `/questions/${questionId}/memos/${memoId}`;
      fetch(memoUpdateUrl, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('[name=csrf-token]').content
        },
        body: JSON.stringify({ memo: { content: content } })
      })
      .then(response => response.json())
      .then(data => {
        console.log('Success:', data);
      })
      .catch((error) => {
        console.error('Error:', error);
      });
    });
  }

  const MAX_HEIGHT = 400;
  const textareas = document.querySelectorAll("textarea.auto-resize");
  
  textareas.forEach(textarea => {
    textarea.style.height = "auto";
    textarea.style.overflowY = "hidden";
    adjustTextareaHeight(textarea);

    textarea.addEventListener("input", event => {
      adjustTextareaHeight(event.target);
    });
  });

  function adjustTextareaHeight(textarea) {
    textarea.style.height = "auto";
    if (textarea.scrollHeight > MAX_HEIGHT) {
      textarea.style.height = `${MAX_HEIGHT}px`;
      textarea.style.overflowY = "scroll";
    } else {
      textarea.style.height = `${textarea.scrollHeight}px`;
      textarea.style.overflowY = "hidden";
    }
  }

  function adjustMemoContentHeight() {
    if (memoContent) {
      if (memoContent.scrollHeight > MAX_HEIGHT) {
        memoContent.style.height = `${MAX_HEIGHT}px`;
        memoContent.style.overflowY = "scroll";
      } else {
        memoContent.style.height = "auto";
        memoContent.style.overflowY = "hidden";
      }
    }
  }
});


document.addEventListener('turbo:submit-end', formSubmitHandler);

function getSanitizedContent(element) {
  let content = element.innerHTML
    .replace(/<div><br><\/div>/g, "\n")
    .replace(/<div>/g, "\n")
    .replace(/<\/div>/g, "")
    .replace(/<br>/g, "\n");
  console.log("Sanitized Content:", content);
  return content.trim();
}

function sanitizeContent(content) {
  return content.trim();
}

function formSubmitHandler(event) {
  const form = event.target;
  const textArea = form.querySelector('textarea[name="memo[content]"]');
  if (textArea) {
    textArea.value = sanitizeContent(textArea.value);
  }
}