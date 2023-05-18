
const textareas = document.querySelectorAll('textarea');

document.addEventListener('keydown', event => {
  if (event.key === 'Enter') {
    if (event.target === textareas[0] || event.target === textareas[1]) {
      event.preventDefault();
    }else{
        const textarea = event.target;
        const cursorPosition = textarea.selectionStart;
        const textBeforeCursor = textarea.value.substring(0, cursorPosition);
        const textAfterCursor = textarea.value.substring(cursorPosition);

        textarea.value = `${textBeforeCursor}* ${textAfterCursor}`;
        textarea.selectionStart = textarea.selectionEnd = cursorPosition + 2;
    }
  }
});