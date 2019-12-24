server_url = 'https://thenudeapp.com'
# server_url = 'http://192.168.1.6:3000'
# server_url = 'http://192.168.8.164:3000'

headers = new Headers
  'content-type': 'application/json'



makeRequest = (request_url, data, end) =>
  if Ambry.state().app.modal_screen.type is 'modal_loading' or Ambry.state().app.modal_screen.type is ''
    Ambry.call 'setModalScreen', visible: yes, type: 'modal_loading'
  fetch "#{ server_url }#{ request_url }",
    method: 'POST'
    headers: headers
    body: JSON.stringify data
  .then (res) => res.json()
  .then (res) =>
    end res
    if Ambry.state().app.modal_screen.type is 'modal_loading' or Ambry.state().app.modal_screen.type is ''
      Ambry.call 'setModalScreen', visible: no, type: ''



export default

  createUser: (data, callback) =>
    makeRequest '/user/create', data, (res) =>
      callback res



  checkUser: (email, callback) =>
    makeRequest '/user/check_user',
      email: if email then email else ''
      deviceInfo: Ambry.state().app.initial_data.device_id
    , (res) =>
      callback res



  resetEmail: (email_address, callback) =>
    makeRequest '/user/reset_email',
      newEmail: email_address
      deviceInfo: Ambry.state().app.initial_data.device_id
    , (res) =>
      callback res



  resetPinCode: (callback) =>
    makeRequest '/user/send_reset_passcode_token',
      email: Ambry.state().app.user.data.emails[0].address
      deviceInfo: Ambry.state().app.initial_data.device_id
    , (res) =>
      if callback then callback res



  confirmResetPinCode: (token, callback) =>
    makeRequest '/user/confirm_token',
      token: token
      deviceInfo: Ambry.state().app.initial_data.device_id
    , (res) =>
      callback res



  deleteUser: (callback) =>
    makeRequest '/user/delete_account',
      deviceInfo: Ambry.state().app.initial_data.device_id
    , (res) =>
      callback res
