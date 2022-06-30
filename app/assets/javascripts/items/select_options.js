window.onload = function () {
  let category_options = Array.from(
    document.getElementById('item_category_id').options);
  let item_options = document.querySelectorAll('#options_id > div');
  let create_item_btn = document.getElementById('create_item_btn');

  for (let i = 0; i < category_options.length; i++) {
    category_options[i].addEventListener('click', function () { 
      item_options[i].className = this.selected == true ? 'd-block' : 'd-none';

      for (let i = 0; i < category_options.length; i++) {
        // Hide all options without selected
        if (category_options[i].selected != true) {
          item_options[i].style = 'display: none;';
          item_options[i].className = 'd-none;';

          // Remove not used options
          create_item_btn.addEventListener('click', function () {
            if (item_options[i].className != 'd-block') {
              item_options[i].remove();
            }
          });
        }
      }
    });
  }
};
