import BGGradient from './sub/bg_gradient'
import NudeLogo from './sub/nude_logo'
import HeaderIdentity from './sub/header_identity'



PinCode = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      hidden: if @props.status is 'create' or @props.status is 'change' then no else yes
      numbers: ['', '', '', '']
      keyboard: [
        { key: '1', image: Assets.img.pictures.keyboard.one }
        { key: '2', image: Assets.img.pictures.keyboard.two }
        { key: '3', image: Assets.img.pictures.keyboard.three }
        { key: '4', image: Assets.img.pictures.keyboard.four }
        { key: '5', image: Assets.img.pictures.keyboard.five }
        { key: '6', image: Assets.img.pictures.keyboard.six }
        { key: '7', image: Assets.img.pictures.keyboard.seven }
        { key: '8', image: Assets.img.pictures.keyboard.eight }
        { key: '9', image: Assets.img.pictures.keyboard.nine }
        { key: 'C', image: Assets.img.pictures.keyboard.c }
        { key: '0', image: Assets.img.pictures.keyboard.zero }
        { key: 'BACK', image: Assets.img.pictures.keyboard.back }
      ]
      cursor: 0



  componentDidMount: =>
    # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    # console.log "(((pinCode componentDidMount (@props):"
    # console.log @props
    # console.log 'pinCode componentDidMount)))'
    # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    if @props.navigation.getParam 'restore_user'
      Ambry.call 'setRestoreUserMode', yes
    else
      Ambry.call 'setRestoreUserMode', no

    if @props.status is 'check'
      if @props.app.initial_data.identity_hardware
        if @props.app.user.data.settings.touch_id_enabled
          API.global.identify (identified) =>
            if identified
              @props.navigation.navigate 'Home'



  keyboardPress: (key) =>
    if key is 'C'
      @setState
        numbers: ['', '', '', '']
        cursor: 0
    else if key is 'BACK'
      negativeCursor = @state.cursor - 1
      if negativeCursor >= 0
        updatedNumbers = @state.numbers
        updatedNumbers[negativeCursor] = ''
        @setState
          numbers: updatedNumbers
          cursor: negativeCursor
    else if @state.cursor <= 3
      updatedNumbers = @state.numbers
      updatedNumbers[@state.cursor] = key
      @setState
        numbers: updatedNumbers
        cursor: @state.cursor + 1
      , =>
        if @state.cursor > 3
          @complete()
    else
      @complete()

  complete: =>
    full_pin = @state.numbers.join ''

    finish = (callback) =>
      setTimeout =>
        callback()
      , 50

    if @props.status is 'create'
      Ambry.call 'setFullPin', full_pin
      if @props.app.user.email is ''
        finish =>
          @props.navigation.navigate 'EnterEmail'
      else
        { status: FS_permission_status } = await Permissions.getAsync Permissions.CAMERA_ROLL
        { status: Camera_permission_status } = await Permissions.getAsync Permissions.CAMERA
        if FS_permission_status isnt 'granted'
          finish =>
            @props.navigation.navigate 'AskAccessFS'
        else if Camera_permission_status isnt 'granted'
          finish =>
            @props.navigation.navigate 'AskAccessCamera'
        else
          API.global.checkConnection (connected) =>
          if connected
            await API.global.storeUser()
            API.global.syncUserLocally (res) =>
              finish =>
                @props.navigation.navigate 'Home'
          else
            finish =>
              Alert.alert 'Connection Error', 'Please check your internet connection'
    else if @props.status is 'change'
      if not @state.change
        @setState
          change:
            first_pin: full_pin
        , =>
          finish =>
            @keyboardPress 'C'
      else
        if full_pin is @state.change.first_pin
          API.global.changePIN full_pin
          finish =>
            @props.navigation.navigate
              routeName: 'Success'
              params: { next_route: 'Home' }
        else
          @setState
            change: undefined
          , =>
            finish =>
              @keyboardPress 'C'
          Alert.alert 'Warning', "PINs doesn't match, try again"
    else if @props.status is 'check'
      if full_pin isnt @props.app.user.data.pin
        { status: Camera_permission_status } = await Permissions.getAsync Permissions.CAMERA
        if Camera_permission_status is 'granted'
          if @camera
            photo = await @camera.takePictureAsync()
            breakin = {
              photo...
              pin: full_pin
            }
            API.global.addBreakIn breakin
        finish =>
          @setState
            incorrect_pin_entered: yes
          , =>
            @keyboardPress 'C'
      else
        finish =>
          @props.navigation.navigate 'Home'

  forgotPIN: =>
    Alert.alert 'Warning', 'We will send you an email with the PIN reset token.',
      [
        {
          text: 'Cancel'
        }
        {
          text: 'Submit'
          onPress: =>
            @props.navigation.navigate 'PinCodeReset'
        }
      ]



  render: =>
    <BGGradient colors={['#EDA9A9', '#FFD8C0']}>
      <StatusBar barStyle='light-content'/>
      {
        if @props.status is 'check'
          <View style={ Shape.Header }>
            <View style={{ position: 'absolute', width: 0, height: 0, top: -100, left: -100, overflow: 'hidden' }}>
              <Camera ref={ (ref) => @camera = ref } type={ Camera.Constants.Type.front } ratio='4:3' style={{ width: 100, height: 100 }}/>
            </View>
            <View style={ Shape.HeaderLeft }>
              {
                if @state.incorrect_pin_entered
                  if @props.app.user.data.emails[0].address.length > 0
                    <Text style={[Typography.Medium, Typography.Small]} onPress={ @forgotPIN }>Forgot PIN?</Text>
              }
            </View>
            <View style={ Shape.HeaderRight }>
              <HeaderIdentity/>
            </View>
          </View>
      }
      {
        if @props.status is 'create'
          <View style={ Shape.Box }>
            <Text style={[Typography.SemiBold, Typography.Bigger, Shape.Text]}>Hello! Let’s get you set up</Text>
            <Text style={[Typography.Medium, Typography.Regular, Shape.Text]}>First choose a 4 digit PIN</Text>
          </View>
        else
          <View style={ Shape.LogoBox }>
            <NudeLogo/>
          </View>
      }
      <View style={ Shape.BoxPinWithKeyboard }>
        {
          if not @state.hidden
            <View style={ Shape.InputBox }>
              {
                if @props.status is 'create' or @state.numbers[0] isnt ''
                  @state.numbers.map (number, num) =>
                    <Text key={ num } style={[Typography.SemiBold, Shape.InputBoxItem]}>{ number }</Text>
                else
                  <Text style={[Typography.Medium, Typography.Regular, Typography.Grey, Shape.Text]}>
                    {
                      if @state.change
                        'Re-enter new PIN'
                      else
                        'Please enter new PIN'
                    }
                  </Text>
              }
            </View>
          else
            <View style={ Shape.InputBox }>
              {
                @state.numbers.map (number, num) =>
                  <View key={ num } style={{ Shape.InputBoxItemHidden..., backgroundColor: if number is '' then 'transparent' else 'rgb(158, 158, 158)' }}/>
              }
            </View>
        }
        <View style={[Shape.InputBox, Shape.InputBoxShadow]}></View>
        <View style={ Shape.Keyboard }>
          {
            @state.keyboard.map (item, num) =>
              <TouchableOpacity key={ num } style={ Shape.KeyboardKey } activeOpacity={ .3 } onPress={ @keyboardPress.bind this, item.key }>
                <Image source={ item.image } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
              </TouchableOpacity>
          }
        </View>
      </View>
    </BGGradient>



Shape = StyleSheet.create
  Header:
    position: 'absolute'
    width: '100%'
    height: 68
    flexDirection: 'row'
    alignItems: 'center'
    justifyContent: 'space-between'
    paddingHorizontal: 16
    paddingTop: 32

  HeaderLeft:
    alignItems: 'center'
    justifyContent: 'center'

  HeaderRight:
    alignItems: 'center'
    justifyContent: 'center'

  Box:
    flex: 1
    marginTop: 70

  LogoBox:
    marginTop: 50
    left: (Window.width - 140) / 2
    width: 140
    height: 80
    alignItems: 'center'

  Text:
    textAlign: 'center'

  BoxPinWithKeyboard:
    position: 'absolute'
    bottom: 0
    left: 0
    right: 0
    top: 190
    backgroundColor: '#F5F6F9'

  InputBox:
    flexDirection: 'row'
    zIndex: 2
    top: -55
    left: 45
    alignItems: 'center'
    justifyContent: 'center'
    backgroundColor: 'white'
    width: Window.width - 90
    height: 110
    borderRadius: 12

  InputBoxItem:
    textAlign: 'center'
    width: 50
    marginTop: 10
    color: 'rgb(128, 128, 128)'
    fontSize: 40
    lineHeight: 40

  InputBoxItemHidden:
    height: 20
    width: 20
    marginHorizontal: 12
    borderRadius: 10

  InputBoxShadow:
    position: 'absolute'
    zIndex: 1
    top: -47.5
    left: 50
    backgroundColor: 'grey'
    opacity: .1

  Keyboard:
    top: -35
    flexDirection: 'row'
    flexWrap: 'wrap'
    paddingHorizontal: 25

  KeyboardKey:
    alignItems: 'center'
    justifyContent: 'center'
    width: (Window.width - 50) / 3
    height: 92.5
    overflow: 'hidden'



export default Hybrid withNavigation PinCode
