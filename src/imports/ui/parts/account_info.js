// Generated by CoffeeScript 2.4.1
var AccountInfo, Shape, _class,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };

AccountInfo = _class = class extends PureComponent {
  constructor(props) {
    super(props);
    this.componentDidMount = this.componentDidMount.bind(this);
    this.typeEmail = this.typeEmail.bind(this);
    this.submit = this.submit.bind(this);
    this.goToDeleteAccount = this.goToDeleteAccount.bind(this);
    this.render = this.render.bind(this);
    this.state = {
      email: this.props.app.user.data.emails[0].address || ''
    };
  }

  componentDidMount() {
    boundMethodCheck(this, _class);
    return this.props.navigation.closeDrawer();
  }

  typeEmail(value) {
    boundMethodCheck(this, _class);
    return this.setState({
      email: value
    });
  }

  submit() {
    var email_address, email_test, email_valid;
    boundMethodCheck(this, _class);
    email_address = this.state.email.toLowerCase().replace(/\s/g, '');
    email_test = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    email_valid = email_test.test(email_address);
    if (email_valid) {
      if (email_address !== this.props.app.user.data.emails[0].address) {
        return API.global.checkConnection((connected) => {
          if (connected) {
            return API.global.addEmail(email_address, () => {
              return this.props.navigation.navigate({
                routeName: 'Success',
                params: {
                  next_route: 'AccountInfo'
                }
              });
            });
          } else {
            return Alert.alert('Connection Error', 'Please check your internet connection');
          }
        });
      }
    } else {
      return Alert.alert('Warning', 'Please enter a valid email address');
    }
  }

  goToDeleteAccount() {
    boundMethodCheck(this, _class);
    return Alert.alert('We’re sad to see you go', 'Deleting your account will automatically export your photos back to your phone’s photostream and delete the existing photos on nude.', [
      {
        text: 'Cancel',
        style: 'cancel'
      },
      {
        text: 'Export & Delete',
        onPress: () => {
          return API.global.deleteUser(() => {
            return this.props.navigation.navigate('Welcome');
          });
        }
      }
    ]);
  }

  render() {
    boundMethodCheck(this, _class);
    return <View style={Shape.Box}>
      <View style={Shape.TopBox}>
        <Text style={[Typography.Medium, Typography.Regular, Typography.DarkGrey, Shape.TopBoxText]}>PRIMARY EMAIL</Text>
        <TextInput style={[Typography.Medium, Typography.Regular, Typography.DarkGrey, Shape.EmailInput]} onChangeText={this.typeEmail} value={this.state.email} placeholder={!this.state.email ? "You don't have any email address yet" : void 0} placeholderTextColor='rgba(0,0,0,.2)' textContentType='emailAddress' autoCompleteType='email' keyboardType='email-address' underlineColorAndroid='transparent' autoCapitalize='none' onSubmitEditing={this.submit} />
      </View>
      <TouchableOpacity style={Shape.DeleteAccount} activeOpacity={.5} onPress={this.goToDeleteAccount}>
        <Text style={[Typography.Medium, Typography.Bigger]}>DELETE ACCOUNT</Text>
      </TouchableOpacity>
    </View>;
  }

};

Shape = StyleSheet.create({
  Box: {
    flex: 1,
    width: '100%',
    backgroundColor: '#F5F6F9'
  },
  TopBox: {
    marginVertical: 25,
    width: '100%'
  },
  TopBoxText: {
    marginHorizontal: 24
  },
  EmailInput: {
    width: Window.width,
    marginVertical: 14,
    paddingVertical: 16,
    paddingHorizontal: 24,
    borderWidth: 0,
    borderColor: 'transparent',
    borderRadius: 0,
    backgroundColor: 'white',
    alignItems: 'center',
    justifyContent: 'center'
  },
  DeleteAccount: {
    width: '100%',
    padding: 20,
    backgroundColor: '#B1B1B1',
    position: 'absolute',
    bottom: 0,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export default Hybrid(AccountInfo);

//# sourceMappingURL=account_info.js.map
