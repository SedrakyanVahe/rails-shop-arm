window.onload = function () {
  let close_btn = document.getElementById('close_message');

  function close_message() {
    close_btn.parentNode.className = 'd-none';
  }

  close_btn.addEventListener('click', close_message);
};
