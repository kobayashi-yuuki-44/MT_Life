console.log('Toggle memo script loaded');
document.addEventListener("turbo:load", function() {
  console.log("turbo:load event triggered");
  const toggleButton = document.getElementById("toggle-memo");
  const memoContent = document.getElementById("content");
  console.log({ toggleButton, memoContent });

  if (toggleButton && memoContent) {
    console.log("Adding event listener");
    toggleButton.addEventListener("click", function() {
      console.log("Toggle button clicked");
      memoContent.style.display = memoContent.style.display === "none" ? "block" : "none";
      toggleButton.textContent = memoContent.style.display === "block" ? "メモを隠す" : "メモを見る";
    });
  }
});