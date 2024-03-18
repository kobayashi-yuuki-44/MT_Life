document.addEventListener("turbo:load", function() {
  const toggleButton = document.getElementById("toggle-memo");
  const memoContent = document.getElementById("content");

  if (toggleButton && memoContent) {
    toggleButton.addEventListener("click", function() {
      memoContent.style.display = memoContent.style.display === "none" ? "block" : "none";
      toggleButton.textContent = memoContent.style.display === "block" ? "メモを隠す" : "メモを見る";
    });
  }
});