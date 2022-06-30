window.onload = function () {
  let category_select = document.querySelectorAll('#category_select > select > option');
  let option_add = document.getElementById('option_add');
  let options_list = document.getElementById('options_list');
  let options_count = 1;

  // Disable categories greater than 1
  for (let i = 0; i < category_select.length; i++) {
    let option = category_select[i];
    let option_level = option.getAttribute('data-level'); 

    if (option_level > 1) {
      option.disabled = true;
    }
  }

  function counter_increment() {
    options_count++;

    if (options_count == 5) {
      option_add.className = 'd-none';
    }
  }

  option_add.onclick = function () {
    add_option();
    counter_increment();
  };

  // Adding an option to the options list.
  function add_option() {
    let code_block = `<input class="form-control mb-2" placeholder="Option ${
        options_count + 1}" type="text" value="" name="options[]"></input> `;
    options_list.innerHTML += code_block;
  }
};