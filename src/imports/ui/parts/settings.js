// Generated by CoffeeScript 2.4.1
var Settings, Shape, _class,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };

import BGGradient from './sub/bg_gradient';

Settings = _class = class extends PureComponent {
  constructor(props) {
    super(props);
    this.componentDidMount = this.componentDidMount.bind(this);
    this.setAutoNudeDetection = this.setAutoNudeDetection.bind(this);
    this.setTouchIdEnabled = this.setTouchIdEnabled.bind(this);
    this.openPage = this.openPage.bind(this);
    this.render = this.render.bind(this);
    this.state = {
      auto_nude_detection: this.props.app.user.data.settings.auto_nude_detection,
      touch_id_enabled: this.props.app.user.data.settings.touch_id_enabled
    };
  }

  componentDidMount() {
    boundMethodCheck(this, _class);
    return this.props.navigation.closeDrawer();
  }

  setAutoNudeDetection(value) {
    boundMethodCheck(this, _class);
    API.global.setAutoNudeDetection(value);
    return this.setState({
      auto_nude_detection: value
    });
  }

  setTouchIdEnabled(value) {
    boundMethodCheck(this, _class);
    API.global.setTouchIdEnabled(value);
    return this.setState({
      touch_id_enabled: value
    });
  }

  openPage(route) {
    boundMethodCheck(this, _class);
    return this.props.navigation.navigate(route);
  }

  render() {
    boundMethodCheck(this, _class);
    return <View style={Shape.Box}>
      <BGGradient colors={['#EDA9A9', '#FFD8C0']} style={{
        position: 'absolute',
        top: 0,
        width: '100%',
        height: 210,
        zIndex: -1
      }} />
      <View style={Shape.MainSettingsBox}>
        <View style={Shape.MainSettingsBoxItem}>
          <View style={{
        width: '94%'
      }}>
            <Text style={[Typography.Medium, Typography.Regular, Typography.DarkGrey, Shape.MainSettingsBoxItemText]}>Automatic Nude Detection</Text>
            <Text style={[Typography.Medium, Typography.Small, Typography.Grey, Shape.MainSettingsBoxItemText]}>
              {(Platform.OS === 'ios' ? "Automatically scans your Camera\nRoll for nude pictures" : "Automatically scans your Gallery\n for nude pictures")}
            </Text>
          </View>
          <View style={Shape.MainSettingsBoxItemSwitch}>
            <Switch trackColor={{
        false: 'rgb(230, 230, 230)',
        true: '#F2B9B1'
      }} thumbColor={Platform.OS === 'android' ? '#FFFFFF' : void 0} onValueChange={this.setAutoNudeDetection} value={this.state.auto_nude_detection} />
          </View>
        </View>
        <View style={Shape.MainSettingsBoxItemSeparator}></View>
        <View style={Shape.MainSettingsBoxItem}>
          <View style={{
        width: '94%'
      }}>
            <Text style={[Typography.Medium, Typography.Regular, Typography.DarkGrey, Shape.MainSettingsBoxItemText]}>
              {(this.props.app.initial_data.identity_hardware === 'FACIAL_RECOGNITION' ? Platform.OS === 'ios' ? 'Enable Face ID' : 'Enable Face Recognition' : Platform.OS === 'ios' ? 'Enable Touch ID' : 'Enable Fingerpring')}
            </Text>
            <Text style={[Typography.Medium, Typography.Small, Typography.Grey, Shape.MainSettingsBoxItemText]}>
              {(this.props.app.initial_data.identity_hardware === 'FACIAL_RECOGNITION' ? 'Use your face to access Nude' : 'Use your fingerprint to access Nude')}
            </Text>
          </View>
          <View style={Shape.MainSettingsBoxItemSwitch}>
            <Switch trackColor={{
        false: 'rgb(230, 230, 230)',
        true: '#F2B9B1'
      }} thumbColor={Platform.OS === 'android' ? '#FFFFFF' : void 0} onValueChange={this.setTouchIdEnabled} value={this.state.touch_id_enabled} disabled={this.props.app.initial_data.identity_hardware ? false : true} />
          </View>
        </View>
      </View>
      <View style={[Shape.MainSettingsBox, Shape.MainSettingsBoxShadow]}></View>
      <View style={Shape.OtherSettingsBox}>
        <TouchableOpacity style={Shape.OtherSettingsBoxItem} activeOpacity={.5} onPress={this.openPage.bind(this, 'AccountInfo')}>
          <Text style={[Typography.Medium, Typography.Bigger, Typography.Grey, Shape.OtherSettingsBoxItemText]}>Account Info</Text>
          <Image source={Assets.img.icons.forward_arrow} style={{
        width: 18,
        height: 18,
        resizeMode: 'contain'
      }} />
        </TouchableOpacity>
        <TouchableOpacity style={Shape.OtherSettingsBoxItem} activeOpacity={.5} onPress={this.openPage.bind(this, 'ChangePIN')}>
          <Text style={[Typography.Medium, Typography.Bigger, Typography.Grey, Shape.OtherSettingsBoxItemText]}>Change PIN</Text>
          <Image source={Assets.img.icons.forward_arrow} style={{
        width: 18,
        height: 18,
        resizeMode: 'contain'
      }} />
        </TouchableOpacity>
      </View>
    </View>;
  }

};

Shape = StyleSheet.create({
  Box: {
    flex: 1,
    width: '100%',
    backgroundColor: '#F5F6F9'
  },
  MainSettingsBox: {
    zIndex: 2,
    marginTop: 90,
    marginHorizontal: 16,
    marginBottom: 10,
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'white',
    width: Window.width - 32,
    height: 220,
    borderRadius: 12,
    padding: 20
  },
  MainSettingsBoxItem: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 10
  },
  MainSettingsBoxItemText: {
    marginVertical: 2.5,
    textAlign: 'left',
    letterSpacing: 0
  },
  MainSettingsBoxItemSwitch: {
    zIndex: 999,
    width: '6%',
    marginLeft: 10,
    alignItems: 'center',
    justifyContent: 'center'
  },
  MainSettingsBoxItemSeparator: {
    backgroundColor: 'rgb(225, 225, 225)',
    width: '100%',
    height: 1,
    marginVertical: 10
  },
  MainSettingsBoxShadow: {
    position: 'absolute',
    zIndex: 1,
    top: 4,
    left: 4,
    backgroundColor: 'grey',
    opacity: .1
  },
  OtherSettingsBox: {
    marginHorizontal: 16,
    width: Window.width - 32
  },
  OtherSettingsBoxItem: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    alignItems: 'center',
    justifyContent: 'space-between',
    marginVertical: 5,
    paddingVertical: 30,
    paddingHorizontal: 20,
    borderRadius: 12,
    backgroundColor: 'white'
  },
  OtherSettingsBoxItemText: {
    marginVertical: 2.5,
    textAlign: 'left',
    letterSpacing: 0
  }
});

export default Hybrid(Settings);

//# sourceMappingURL=settings.js.map
