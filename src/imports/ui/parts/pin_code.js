// Generated by CoffeeScript 2.4.1
var PinCode, Shape, _class,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };

import BGGradient from './sub/bg_gradient';

import NudeLogo from './sub/nude_logo';

import HeaderIdentity from './sub/header_identity';

PinCode = _class = class extends PureComponent {
  constructor(props) {
    super(props);
    this.componentDidMount = this.componentDidMount.bind(this);
    this.keyboardPress = this.keyboardPress.bind(this);
    this.complete = this.complete.bind(this);
    this.forgotPIN = this.forgotPIN.bind(this);
    this.render = this.render.bind(this);
    this.state = {
      hidden: this.props.status === 'create' || this.props.status === 'change' ? false : true,
      numbers: ['', '', '', ''],
      keyboard: [
        {
          key: '1',
          image: Assets.img.pictures.keyboard.one
        },
        {
          key: '2',
          image: Assets.img.pictures.keyboard.two
        },
        {
          key: '3',
          image: Assets.img.pictures.keyboard.three
        },
        {
          key: '4',
          image: Assets.img.pictures.keyboard.four
        },
        {
          key: '5',
          image: Assets.img.pictures.keyboard.five
        },
        {
          key: '6',
          image: Assets.img.pictures.keyboard.six
        },
        {
          key: '7',
          image: Assets.img.pictures.keyboard.seven
        },
        {
          key: '8',
          image: Assets.img.pictures.keyboard.eight
        },
        {
          key: '9',
          image: Assets.img.pictures.keyboard.nine
        },
        {
          key: 'C',
          image: Assets.img.pictures.keyboard.c
        },
        {
          key: '0',
          image: Assets.img.pictures.keyboard.zero
        },
        {
          key: 'BACK',
          image: Assets.img.pictures.keyboard.back
        }
      ],
      cursor: 0
    };
  }

  componentDidMount() {
    boundMethodCheck(this, _class);
    // console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    // console.log "(((pinCode componentDidMount (@props):"
    // console.log @props
    // console.log 'pinCode componentDidMount)))'
    // console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    if (this.props.navigation.getParam('restore_user')) {
      Ambry.call('setRestoreUserMode', true);
    } else {
      Ambry.call('setRestoreUserMode', false);
    }
    if (this.props.status === 'check') {
      if (this.props.app.initial_data.identity_hardware) {
        if (this.props.app.user.data.settings.touch_id_enabled) {
          return API.global.identify((identified) => {
            if (identified) {
              return this.props.navigation.navigate('Home');
            }
          });
        }
      }
    }
  }

  keyboardPress(key) {
    var negativeCursor, updatedNumbers;
    boundMethodCheck(this, _class);
    if (key === 'C') {
      return this.setState({
        numbers: ['', '', '', ''],
        cursor: 0
      });
    } else if (key === 'BACK') {
      negativeCursor = this.state.cursor - 1;
      if (negativeCursor >= 0) {
        updatedNumbers = this.state.numbers;
        updatedNumbers[negativeCursor] = '';
        return this.setState({
          numbers: updatedNumbers,
          cursor: negativeCursor
        });
      }
    } else if (this.state.cursor <= 3) {
      updatedNumbers = this.state.numbers;
      updatedNumbers[this.state.cursor] = key;
      return this.setState({
        numbers: updatedNumbers,
        cursor: this.state.cursor + 1
      }, () => {
        if (this.state.cursor > 3) {
          return this.complete();
        }
      });
    } else {
      return this.complete();
    }
  }

  async complete() {
    var Camera_permission_status, FS_permission_status, breakin, finish, full_pin, photo;
    boundMethodCheck(this, _class);
    full_pin = this.state.numbers.join('');
    finish = (callback) => {
      return setTimeout(() => {
        return callback();
      }, 50);
    };
    if (this.props.status === 'create') {
      Ambry.call('setFullPin', full_pin);
      if (this.props.app.user.email === '') {
        return finish(() => {
          return this.props.navigation.navigate('EnterEmail');
        });
      } else {
        ({
          status: FS_permission_status
        } = (await Permissions.getAsync(Permissions.CAMERA_ROLL)));
        ({
          status: Camera_permission_status
        } = (await Permissions.getAsync(Permissions.CAMERA)));
        if (FS_permission_status !== 'granted') {
          return finish(() => {
            return this.props.navigation.navigate('AskAccessFS');
          });
        } else if (Camera_permission_status !== 'granted') {
          return finish(() => {
            return this.props.navigation.navigate('AskAccessCamera');
          });
        } else {
          API.global.checkConnection((connected) => {});
          if (connected) {
            await API.global.storeUser();
            return API.global.syncUserLocally((res) => {
              return finish(() => {
                return this.props.navigation.navigate('Home');
              });
            });
          } else {
            return finish(() => {
              return Alert.alert('Connection Error', 'Please check your internet connection');
            });
          }
        }
      }
    } else if (this.props.status === 'change') {
      if (!this.state.change) {
        return this.setState({
          change: {
            first_pin: full_pin
          }
        }, () => {
          return finish(() => {
            return this.keyboardPress('C');
          });
        });
      } else {
        if (full_pin === this.state.change.first_pin) {
          API.global.changePIN(full_pin);
          return finish(() => {
            return this.props.navigation.navigate({
              routeName: 'Success',
              params: {
                next_route: 'Home'
              }
            });
          });
        } else {
          this.setState({
            change: void 0
          }, () => {
            return finish(() => {
              return this.keyboardPress('C');
            });
          });
          return Alert.alert('Warning', "PINs doesn't match, try again");
        }
      }
    } else if (this.props.status === 'check') {
      if (full_pin !== this.props.app.user.data.pin) {
        ({
          status: Camera_permission_status
        } = (await Permissions.getAsync(Permissions.CAMERA)));
        if (Camera_permission_status === 'granted') {
          if (this.camera) {
            photo = (await this.camera.takePictureAsync());
            breakin = {
              ...photo,
              pin: full_pin
            };
            API.global.addBreakIn(breakin);
          }
        }
        return finish(() => {
          return this.setState({
            incorrect_pin_entered: true
          }, () => {
            return this.keyboardPress('C');
          });
        });
      } else {
        return finish(() => {
          return this.props.navigation.navigate('Home');
        });
      }
    }
  }

  forgotPIN() {
    boundMethodCheck(this, _class);
    return Alert.alert('Warning', 'We will send you an email with the PIN reset token.', [
      {
        text: 'Cancel'
      },
      {
        text: 'Submit',
        onPress: () => {
          return this.props.navigation.navigate('PinCodeReset');
        }
      }
    ]);
  }

  render() {
    boundMethodCheck(this, _class);
    return <BGGradient colors={['#EDA9A9', '#FFD8C0']}>
      <StatusBar barStyle='light-content' />
      {(this.props.status === 'check' ? <View style={Shape.Header}>
            <View style={{
        position: 'absolute',
        width: 0,
        height: 0,
        top: -100,
        left: -100,
        overflow: 'hidden'
      }}>
              <Camera ref={(ref) => {
        return this.camera = ref;
      }} type={Camera.Constants.Type.front} ratio='4:3' style={{
        width: 100,
        height: 100
      }} />
            </View>
            <View style={Shape.HeaderLeft}>
              {(this.state.incorrect_pin_entered ? this.props.app.user.data.emails[0].address.length > 0 ? <Text style={[Typography.Medium, Typography.Small]} onPress={this.forgotPIN}>Forgot PIN?</Text> : void 0 : void 0)}
            </View>
            <View style={Shape.HeaderRight}>
              <HeaderIdentity />
            </View>
          </View> : void 0)}
      {(this.props.status === 'create' ? <View style={Shape.Box}>
            <Text style={[Typography.SemiBold, Typography.Bigger, Shape.Text]}>Hello! Let’s get you set up</Text>
            <Text style={[Typography.Medium, Typography.Regular, Shape.Text]}>First choose a 4 digit PIN</Text>
          </View> : <View style={Shape.LogoBox}>
            <NudeLogo />
          </View>)}
      <View style={Shape.BoxPinWithKeyboard}>
        {(!this.state.hidden ? <View style={Shape.InputBox}>
              {(this.props.status === 'create' || this.state.numbers[0] !== '' ? this.state.numbers.map((number, num) => {
      return <Text key={num} style={[Typography.SemiBold, Shape.InputBoxItem]}>{number}</Text>;
    }) : <Text style={[Typography.Medium, Typography.Regular, Typography.Grey, Shape.Text]}>
                    {(this.state.change ? 'Re-enter new PIN' : 'Please enter new PIN')}
                  </Text>)}
            </View> : <View style={Shape.InputBox}>
              {this.state.numbers.map((number, num) => {
      return <View key={num} style={{
          ...Shape.InputBoxItemHidden,
          backgroundColor: number === '' ? 'transparent' : 'rgb(158, 158, 158)'
        }} />;
    })}
            </View>)}
        <View style={[Shape.InputBox, Shape.InputBoxShadow]}></View>
        <View style={Shape.Keyboard}>
          {this.state.keyboard.map((item, num) => {
      return <TouchableOpacity key={num} style={Shape.KeyboardKey} activeOpacity={.3} onPress={this.keyboardPress.bind(this, item.key)}>
                <Image source={item.image} style={{
          width: '100%',
          height: '100%',
          resizeMode: 'contain'
        }} />
              </TouchableOpacity>;
    })}
        </View>
      </View>
    </BGGradient>;
  }

};

Shape = StyleSheet.create({
  Header: {
    position: 'absolute',
    width: '100%',
    height: 68,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingTop: 32
  },
  HeaderLeft: {
    alignItems: 'center',
    justifyContent: 'center'
  },
  HeaderRight: {
    alignItems: 'center',
    justifyContent: 'center'
  },
  Box: {
    flex: 1,
    marginTop: 70
  },
  LogoBox: {
    marginTop: 50,
    left: (Window.width - 140) / 2,
    width: 140,
    height: 80,
    alignItems: 'center'
  },
  Text: {
    textAlign: 'center'
  },
  BoxPinWithKeyboard: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    top: 190,
    backgroundColor: '#F5F6F9'
  },
  InputBox: {
    flexDirection: 'row',
    zIndex: 2,
    top: -55,
    left: 45,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'white',
    width: Window.width - 90,
    height: 110,
    borderRadius: 12
  },
  InputBoxItem: {
    textAlign: 'center',
    width: 50,
    marginTop: 10,
    color: 'rgb(128, 128, 128)',
    fontSize: 40,
    lineHeight: 40
  },
  InputBoxItemHidden: {
    height: 20,
    width: 20,
    marginHorizontal: 12,
    borderRadius: 10
  },
  InputBoxShadow: {
    position: 'absolute',
    zIndex: 1,
    top: -47.5,
    left: 50,
    backgroundColor: 'grey',
    opacity: .1
  },
  Keyboard: {
    top: -35,
    flexDirection: 'row',
    flexWrap: 'wrap',
    paddingHorizontal: 25
  },
  KeyboardKey: {
    alignItems: 'center',
    justifyContent: 'center',
    width: (Window.width - 50) / 3,
    height: 92.5,
    overflow: 'hidden'
  }
});

export default Hybrid(withNavigation(PinCode));

//# sourceMappingURL=pin_code.js.map
