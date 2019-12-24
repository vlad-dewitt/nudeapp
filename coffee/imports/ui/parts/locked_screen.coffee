import NudeLogo from './sub/nude_logo'



LockedScreen = class extends PureComponent
  constructor: (props) ->
    super props



  componentDidMount: =>
    AppState.addEventListener 'check', @checkAppState
    API.global.startAppLockTimer()

  componentWillUnmount: =>
    AppState.removeEventListener 'change', @checkAppState



  checkAppState: (nextAppState) =>
    time_left = moment.duration(moment(moment new Date()).diff(@props.app.locked_at)).asMilliseconds()
    
    if time_left > 1000
      @props.navigation.navigate 'PinCodeVerification'
    else
      @props.navigation.goBack()

    API.global.clearAppLockTimer()



  render: =>
    <ImageBackground source={ Assets.img.pictures.nude_bg_leafs } style={ Shape.BGImage }>
      <View style={ Shape.Box }>
        <View style={ Shape.LogoBox }>
          <NudeLogo/>
        </View>
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
    bottom: 15
    alignItems: 'center'



export default Hybrid withNavigation LockedScreen
