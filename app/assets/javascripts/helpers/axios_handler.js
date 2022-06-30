function axiosHandler(
  api_url,
  method,
  data,
  headers = { 'Content-Type': 'application/json' }
) {
  return axios({
    url: api_url,
    method,
    headers,
    data,
  })
    .then(function (response) {
      console.log(response);
      if (response.status >= 400) throw new Error(response);
      return response;
    })
    .catch((rej) => {
      return rej.response;
    });
}

function axiosGET(api_url) {
  return axiosHandler(api_url, 'get');
}

function axiosPOST(api_url, data, headers) {
  return axiosHandler(api_url, 'post', data, headers);
}

function axiosPATCH(api_url, data, headers) {
  return axiosHandler(api_url, 'patch', data, headers);
}

function axiosPUT(api_url, data, headers) {
  return axiosHandler(api_url, 'put', data, headers);
}

function axiosDELETE(api_url) {
  return axiosHandler(api_url, 'delete');
}