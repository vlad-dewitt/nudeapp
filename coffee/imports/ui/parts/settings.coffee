import BGGradient from './sub/bg_gradient'



Settings = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      auto_nude_detection: @props.app.user.data.settings.auto_nude_detection
      touch_id_enabled: @props.app.user.data.settings.touch_id_enabled



  componentDidMount: =>
    @props.navigation.closeDrawer()



  setAutoNudeDetection: (value) =>
    API.global.setAutoNudeDetection value
    @setState
      auto_nude_detection: value

  setTouchIdEnabled: (value) =>
    API.global.setTouchIdEnabled value
    @setState
      touch_id_enabled: value

  openPage: (route) =>
    @props.navigation.navigate route



  render: =>
    <View style={ Shape.Box }>
      <BGGradient colors={['#EDA9A9', '#FFD8C0']} style={{ position: 'absolute', top: 0, width: '100%', height: 210, zIndex: -1 }}/>
      <View style={ Shape.MainSettingsBox }>
        <View style={ Shape.MainSettingsBoxItem }>
          <View style={{ width: '94%' }}>
            <Text style={[Typography.Medium, Typography.Regular, Typography.DarkGrey, Shape.MainSettingsBoxItemText]}>Automatic Nude Detection</Text>
            <Text style={[Typography.Medium, Typography.Small, Typography.Grey, Shape.MainSettingsBoxItemText]}>
              {
                if Platform.OS is 'ios'
                  "Automatically scans your Camera\nRoll for nude pictures"
                else
                  "Automatically scans your Gallery\n for nude pictures"
              }
            </Text>
          </View>
          <View style={ Shape.MainSettingsBoxItemSwitch }>
            <Switch trackColor={ false: 'rgb(230, 230, 230)', true: '#F2B9B1'} thumbColor={ if Platform.OS is 'android' then '#FFFFFF' } onValueChange={ @setAutoNudeDetection } value={ @state.auto_nude_detection }/>
          </View>
        </View>
        <View style={ Shape.MainSettingsBoxItemSeparator }></View>
        <View style={ Shape.MainSettingsBoxItem }>
          <View style={{ width: '94%' }}>
            <Text style={[Typography.Medium, Typography.Regular, Typography.DarkGrey, Shape.MainSettingsBoxItemText]}>
              {
                if @props.app.initial_data.identity_hardware is 'FACIAL_RECOGNITION'
                  if Platform.OS is 'ios'
                    'Enable Face ID'
                  else
                    'Enable Face Recognition'
                else
                  if Platform.OS is 'ios'
                    'Enable Touch ID'
                  else
                    'Enable Fingerpring'
              }
            </Text>
            <Text style={[Typography.Medium, Typography.Small, Typography.Grey, Shape.MainSettingsBoxItemText]}>
              {
                if @props.app.initial_data.identity_hardware is 'FACIAL_RECOGNITION'
                  'Use your face to access Nude'
                else
                  'Use your fingerprint to access Nude'
              }
            </Text>
          </View>
          <View style={ Shape.MainSettingsBoxItemSwitch }>
            <Switch trackColor={ false: 'rgb(230, 230, 230)', true: '#F2B9B1'} thumbColor={ if Platform.OS is 'android' then '#FFFFFF' } onValueChange={ @setTouchIdEnabled } value={ @state.touch_id_enabled } disabled={ if @props.app.initial_data.identity_hardware then no else yes }/>
          </View>
        </View>
      </View>
      <View style={[Shape.MainSettingsBox, Shape.MainSettingsBoxShadow]}></View>
      <View style={ Shape.OtherSettingsBox }>
        <TouchableOpacity style={ Shape.OtherSettingsBoxItem } activeOpacity={ .5 } onPress={ @openPage.bind this, 'AccountInfo' }>
          <Text style={[Typography.Medium, Typography.Bigger, Typography.Grey, Shape.OtherSettingsBoxItemText]}>Account Info</Text>
          <Image source={ Assets.img.icons.forward_arrow } style={{ width: 18, height: 18, resizeMode: 'contain' }}/>
        </TouchableOpacity>
        <TouchableOpacity style={ Shape.OtherSettingsBoxItem } activeOpacity={ .5 } onPress={ @openPage.bind this, 'ChangePIN' }>
          <Text style={[Typography.Medium, Typography.Bigger, Typography.Grey, Shape.OtherSettingsBoxItemText]}>Change PIN</Text>
          <Image source={ Assets.img.icons.forward_arrow } style={{ width: 18, height: 18, resizeMode: 'contain' }}/>
        </TouchableOpacity>
      </View>
    </View>



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'
    backgroundColor: '#F5F6F9'

  MainSettingsBox:
    zIndex: 2
    marginTop: 90
    marginHorizontal: 16
    marginBottom: 10
    alignItems: 'center'
    justifyContent: 'center'
    backgroundColor: 'white'
    width: Window.width - 32
    height: 220
    borderRadius: 12
    padding: 20

  MainSettingsBoxItem:
    flexDirection: 'row'
    alignItems: 'center'
    padding: 10

  MainSettingsBoxItemText:
    marginVertical: 2.5
    textAlign: 'left'
    letterSpacing: 0

  MainSettingsBoxItemSwitch:
    zIndex: 999
    width: '6%'
    marginLeft: 10
    alignItems: 'center'
    justifyContent: 'center'

  MainSettingsBoxItemSeparator:
    backgroundColor: 'rgb(225, 225, 225)'
    width: '100%'
    height: 1
    marginVertical: 10

  MainSettingsBoxShadow:
    position: 'absolute'
    zIndex: 1
    top: 4
    left: 4
    backgroundColor: 'grey'
    opacity: .1

  OtherSettingsBox:
    marginHorizontal: 16
    width: Window.width - 32

  OtherSettingsBoxItem:
    flexDirection: 'row'
    flexWrap: 'wrap'
    alignItems: 'center'
    justifyContent: 'space-between'
    marginVertical: 5
    paddingVertical: 30
    paddingHorizontal: 20
    borderRadius: 12
    backgroundColor: 'white'

  OtherSettingsBoxItemText:
    marginVertical: 2.5
    textAlign: 'left'
    letterSpacing: 0



export default Hybrid Settings
