let close_btn = document.getElementById('close_message');

if (close_btn) {
  function close_message() {
    close_btn.parentNode.className = 'd-none';
  }

  close_btn.addEventListener('click', close_message);
}