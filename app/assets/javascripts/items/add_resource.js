let exists_item_resources_list = document.getElementById('exists_item_resources_list')
let item_resources_list = document.getElementById('item_resources_list')
let exists_link_radio = document.getElementsByClassName('exists_link_radio')
let exists_document_radio = document.getElementsByClassName('exists_document_radio')
let exists_link_input = document.getElementsByClassName('exists_resource_type_link')
let exists_document_input = document.getElementsByClassName('exists_resource_type_document')
let current_resources_type = document.getElementsByClassName('exists_item_resource_type')
let resource_index = 0;
 
// Checking if the exists_item_resources_list exists. If it does, it will add the number of children to the resource_index.
exists_item_resources_list ? resource_index += exists_item_resources_list.childElementCount / 2 : 0

// Call functions when click button: 'Add resource'
document.getElementById('add_resource_btn').onclick = function () {
  add_resource();
  counter_increment();
  hide_field()
};

// Adding a new resource to the form.
function add_resource() {
  let code_block = `<div class='new_item_resource_box' style='background: #f8f7f7; border-radius: 10px;'>
    <div class='form-group row mb-2'>
      <legend class='col-form-label col-sm-2 pt-0'>Resource Name</legend>
      <div class='col-sm-10'>
          <input class='form-control' name='item[item_resources_attributes][${resource_index}][name]' placeholder='Resource name'>
      </div>
    </div>
    <div class='row mb-2'>
      <legend class='col-form-label col-sm-2 pt-0'>Resource Type</legend>
      <div class='col-sm-10'>
          <div class='form-check'>
            <input checked='' class='link_radio gridRadios1 form-check-input' name='item[item_resources_attributes][${resource_index}][resource_type]' type='radio' value='link'>
            Link
          </div>
          <div class='form-check'>
            <input class='document_radio gridRadios1 form-check-input' name='item[item_resources_attributes][${resource_index}][resource_type]' type='radio' value='document'>
            Document
          </div>
      </div>
    </div>
    <div class='resource_type_link form-group row mb-2'>
      <legend class='col-form-label col-sm-2 pt-0'>Resource Link</legend>
      <div class='col-sm-10'>
          <input class='form-control' name='item[item_resources_attributes][${resource_index}][url]' placeholder='Resource url'>
      </div>
    </div>
    <div class='resource_type_document form-group row mb-2 d-none'>
      <label class='col-sm-2 col-form-label'>Recource Document</label>
      <div class='col-sm-10'>
          <input class='form-control' name='item[item_resources_attributes][${resource_index}][file]' placeholder='Resource doc' type='file'>
      </div>
    </div>
    <hr>
  </div>`
  
  document.getElementById('item_resources_list').innerHTML += code_block;  
}

function counter_increment() {
  resource_index++;
}

// Adding an event listener to the radio buttons. When the radio button is clicked,
// it will toggle the class of the input field for exists resources.
for (let i = 0; i < exists_link_radio.length; i++) {
  toggle_class(current_resources_type[i].value, exists_link_input[i], exists_document_input[i], 'exists_')

  exists_link_radio[i].addEventListener('click', function () {  
    toggle_class(this.value, exists_link_input[i], exists_document_input[i], 'exists_')
    }
  )

  exists_document_radio[i].addEventListener('click', function () {  
    toggle_class(this.value, exists_link_input[i], exists_document_input[i], 'exists_')
    }
  )
}

// Adding an event listener to the radio buttons. When the radio button is clicked,
// it will toggle the class of the input field for new resources.
function hide_field() {
  let link_radio = document.getElementsByClassName('link_radio');
  let document_radio = document.getElementsByClassName('document_radio');
  let link_input = document.getElementsByClassName('resource_type_link');
  let document_input = document.getElementsByClassName('resource_type_document');

  for (let i = 0; i < link_radio.length; i++) {
    link_radio[i].addEventListener('click', function () {  
      toggle_class(this.value, link_input[i], document_input[i])
    });

    document_radio[i].addEventListener('click', function () {  
      toggle_class(this.value, link_input[i], document_input[i])
    });
  }
}

// Toggling the class of the input field.
function toggle_class(radio, link, doc, exists = '') {
  if (radio == 'link') {
    link.className = `${exists}resource_type_link form-group row mb-2`;
    doc.className = `${exists}resource_type_document d-none`;
  } else if (radio == 'document') {
    link.className = `${exists}resource_type_link d-none`;
    doc.className = `${exists}resource_type_document form-group row mb-2`;
  }
}
