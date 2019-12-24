// Generated by CoffeeScript 2.4.1
var headers, makeRequest, server_url;

server_url = 'https://thenudeapp.com';

// server_url = 'http://192.168.1.6:3000'
// server_url = 'http://192.168.8.164:3000'
headers = new Headers({
  'content-type': 'application/json'
});

makeRequest = (request_url, data, end) => {
  if (Ambry.state().app.modal_screen.type === 'modal_loading' || Ambry.state().app.modal_screen.type === '') {
    Ambry.call('setModalScreen', {
      visible: true,
      type: 'modal_loading'
    });
  }
  return fetch(`${server_url}${request_url}`, {
    method: 'POST',
    headers: headers,
    body: JSON.stringify(data)
  }).then((res) => {
    return res.json();
  }).then((res) => {
    end(res);
    if (Ambry.state().app.modal_screen.type === 'modal_loading' || Ambry.state().app.modal_screen.type === '') {
      return Ambry.call('setModalScreen', {
        visible: false,
        type: ''
      });
    }
  });
};

export default {
  createUser: (data, callback) => {
    return makeRequest('/user/create', data, (res) => {
      return callback(res);
    });
  },
  checkUser: (email, callback) => {
    return makeRequest('/user/check_user', {
      email: email ? email : '',
      deviceInfo: Ambry.state().app.initial_data.device_id
    }, (res) => {
      return callback(res);
    });
  },
  resetEmail: (email_address, callback) => {
    return makeRequest('/user/reset_email', {
      newEmail: email_address,
      deviceInfo: Ambry.state().app.initial_data.device_id
    }, (res) => {
      return callback(res);
    });
  },
  resetPinCode: (callback) => {
    return makeRequest('/user/send_reset_passcode_token', {
      email: Ambry.state().app.user.data.emails[0].address,
      deviceInfo: Ambry.state().app.initial_data.device_id
    }, (res) => {
      if (callback) {
        return callback(res);
      }
    });
  },
  confirmResetPinCode: (token, callback) => {
    return makeRequest('/user/confirm_token', {
      token: token,
      deviceInfo: Ambry.state().app.initial_data.device_id
    }, (res) => {
      return callback(res);
    });
  },
  deleteUser: (callback) => {
    return makeRequest('/user/delete_account', {
      deviceInfo: Ambry.state().app.initial_data.device_id
    }, (res) => {
      return callback(res);
    });
  }
};

//# sourceMappingURL=server.js.map