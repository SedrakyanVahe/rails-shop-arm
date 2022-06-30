let delete_resource_btn = document.getElementsByClassName('delete_resource')

for (let i = 0; i < delete_resource_btn.length; i++) {
  delete_resource_btn[i].addEventListener('click', function () {  
    delete_resource_btn[i].parentElement.parentElement.className = 'd-none'
  });
}