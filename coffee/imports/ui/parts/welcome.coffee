import NudeLogo from './sub/nude_logo'



Welcome = class extends Component
  constructor: (props) ->
    super props
    @state =
      loaded: no
      logo_bottom: new Animated.Value -25
      welcome_box_opacity: new Animated.Value 0
      welcome_box_scale: new Animated.Value .7



  componentDidMount: =>
    if @props.screenProps.loaded
      @startRegistration()

  shouldComponentUpdate: (nextProps, nextState) =>
    if @props.screenProps.loaded isnt nextProps.screenProps.loaded or @state.loaded isnt nextState.loaded or @props.app.user.logged isnt nextProps.app.user.logged
      yes
    else
      no

  componentDidUpdate: (prevProps) =>
    if not @props.app.user.logged
      @startRegistration()
    else
      @props.navigation.navigate 'PinCodeVerification'
      # @props.navigation.navigate 'Home'



  startRegistration: =>
    console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    console.log "(((startRegistration)))"
    console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    @setState
      loaded: yes
    , =>
      Animated.spring(@state.logo_bottom, { toValue: -140, speed: 5, useNativeDriver: yes }).start()
      Animated.spring(@state.welcome_box_opacity, { toValue: 1, speed: 5, useNativeDriver: yes }).start()
      Animated.spring(@state.welcome_box_scale, { toValue: 1, speed: 5, useNativeDriver: yes }).start()

  enter: =>
    @props.navigation.navigate 'Cards'

  restore: =>
    API.global.checkConnection (connected) =>
      if connected
        API.server.checkUser null, (res) =>
          if res.device_id_found
            @props.navigation.navigate
              routeName: 'PinCodeCreate'
              params: { restore_user: yes }
          else
            Alert.alert 'Error', 'Sorry, but this device hasn\'t been registered before'
      else
        Alert.alert 'Connection Error', 'Please check your internet connection'



  render: =>
    <ImageBackground source={ Assets.img.pictures.nude_bg_leafs } style={ Shape.BGImage }>
      <View style={ Shape.Box }>
        <Animated.View style={{ Shape.LogoBox..., transform: [{ translateY: @state.logo_bottom }] }}>
          <NudeLogo/>
        </Animated.View>
        {
          if @state.loaded
            <Animated.View style={{ Shape.WelcomeBox..., position: 'absolute', width: '90%', top: '40%', justifyContent: 'center', alignItems: 'center', opacity: @state.welcome_box_opacity, transform: [{ scaleX: @state.welcome_box_scale }, { scaleY: @state.welcome_box_scale }] }}>
              <View style={ Shape.WelcomeBoxContent }>
                <Text style={[ Typography.Bold, Typography.Big, Shape.WelcomeBoxTopText ]}>Welcome to the nude app</Text>
                <Text style={[ Typography.Medium, Typography.Regular, Shape.WelcomeBoxText ]}>The safest & easiest way to store all your naughty photos and videos</Text>
              </View>
              <View style={ Shape.WelcomeBoxEnter }>
                <StatusBar barStyle='light-content'/>
                <Theme.CircleButton text='ENTER' onPress={ @enter }/>
              </View>
            </Animated.View>
        }
        {
          if @state.loaded
            <Text style={[ Typography.Medium, Typography.Small, Shape.WelcomeRestore]} onPress={ @restore }>Previously Registered? Restore <Text style={{ textDecorationLine: 'underline' }}>here</Text>.</Text>
        }
      </View>
    </ImageBackground>



Shape = StyleSheet.create
  BGImage:
    flex: 1
    width: '100%'
    resizeMode: 'contain'

  Box:
    flex: 1
    alignItems: 'center'
    justifyContent: 'center'

  LogoBox:
    width: 200
    height: 220
    alignItems: 'center'

  WelcomeBox:
    justifyContent: 'center'
    alignItems: 'center'
    paddingBottom: 43

  WelcomeBoxContent:
    width: '100%'
    height: '100%'
    borderWidth: 1
    borderColor: 'white'
    borderRadius: 16
    justifyContent: 'center'
    alignItems: 'center'
    paddingVertical: 20
    paddingHorizontal: 10

  WelcomeBoxTopText:
    marginVertical: 10
    textAlign: 'center'

  WelcomeBoxText:
    marginVertical: 10
    marginBottom: 50
    textAlign: 'center'

  WelcomeBoxEnter:
    position: 'absolute'
    bottom: 0

  WelcomeRestore:
    position: 'absolute'
    padding: 20
    bottom: 20
    opacity: .8



export default Hybrid Welcome
