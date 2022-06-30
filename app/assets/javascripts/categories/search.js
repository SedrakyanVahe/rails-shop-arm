window.onload = function () {
  let categories_table = document.getElementById('categories_table');
  let categories_table_body = document.getElementById('categories_table_body');
  let categories_count = document.getElementById('categories_count');
  let categories_search = document.getElementById('categories_search');

  function render_categories(data) {
    let categories = data['result'];
    let categories_count_new = categories.length;

    // Show categories count
    if (categories_count_new < 1) {
      categories_table.className = 'd-none';
      categories_count.textContent = 'NO RESULT';
    } else {
      categories_count.textContent = `Total ${categories_count_new} categories`;
      categories_table.className = 'table table-striped';
    }

    // Hide elements
    for (let i = 0; i < categories_table_body.childNodes.length; i++) {
      categories_table_body.childNodes[i].className = 'd-none';
    }

    // Show searched categories
    for (let i = 0; i < categories_count_new; i++) {
      let category = categories[i];
      let row = categories_table.insertRow(1);
      row.className = 'link';
      let name = row.insertCell(0);
      let owner = row.insertCell(1);
      let options = row.insertCell(2);
      name.innerHTML = `<td><a href="categories/${category.id}"> ${category.name} </a> </td> `;
      owner.innerHTML = `<td>${category.owner.full_name}</td>`;
      options.id = 'options_list';
      options.innerHTML = `<td id="options_list"> 
        <select id="options" name="options">
        </select>
      </td> `;

      let options_list_select = document.querySelector('#options_list  select');
      let options_array = category.options;
      options_list_select.innerHTML = '';

      // Looping through the options and adding them to the select element.
      for (let j = 0; j < options_array.length; j++) {
        let opt = options_array[j];
        options_list_select.innerHTML += '<option value="' + opt + '">' + opt + '</option>';
      }
    }
  }

  if (categories_search) {
    let timeout = null;

    categories_search.addEventListener('keyup', function (event) {
      clearTimeout(timeout);

      timeout = setTimeout(function () {
        axiosGET('categories/search?query=' + event.target.value)
          .then((res) => render_categories(res['data']))
          .catch((error) => alert(error.message));
      }, 300);
    });
  }
};