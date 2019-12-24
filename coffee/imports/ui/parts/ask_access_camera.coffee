import BGGradient from './sub/bg_gradient'



AskAccessCamera = class extends PureComponent
  constructor: (props) ->
    super props



  openLink: (link) =>
    Linking.openURL "#{ WebsiteAddress }/#{link}"

  submit: =>
    await Permissions.askAsync Permissions.CAMERA
    @next()

  next: =>
    API.global.checkConnection (connected) =>
      if connected
        await API.global.storeUser()
        API.global.syncUserLocally (res) =>
          @props.navigation.navigate 'Home'
      else
        Alert.alert 'Connection Error', 'Please check your internet connection'



  render: =>
    <BGGradient colors={['#FC85AE', '#574B90']}>
      <View style={ Shape.Box }>
        <View style={ Shape.IconBox }>
          <Image source={ Assets.img.icons.camera_access } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
        </View>
        <Text style={[Typography.SemiBold, Typography.Big, Shape.Text, Shape.Title]}>{ "Nude needs access to\nyour camera" }</Text>
        <Text style={[Typography.Medium, Typography.Regular, Shape.Text]}>{ "This allows you to take pictures of yourself and those trying to break-in" }</Text>
        <View style={ Shape.ButtonsContainer }>
          <Theme.ButtonWhite style={{ width: Window.width - 100 }} text='Grant Access' color='#733E9C' onPress={ @submit }/>
          <Text style={[Typography.Small, Typography.White, Shape.Skip]} onPress={ @next }>Cancel</Text>
        </View>
        <Text style={[ Typography.Medium, Typography.Small, Shape.AgreeTerms ]}>By tapping the button above, you agree to the <Text style={{ textDecorationLine: 'underline' }} onPress={ @openLink.bind this, 'terms-of-service' }>Terms & Conditions</Text> and <Text style={{ textDecorationLine: 'underline' }} onPress={ @openLink.bind this, 'privacy-policy' }>Privacy Policy</Text></Text>
      </View>
    </BGGradient>



Shape = StyleSheet.create
  Box:
    flex: 1
    alignItems: 'center'
    justifyContent: 'center'

  IconBox:
    width: 86
    height: 86
    alignItems: 'center'

  Text:
    width: Window.width - 130
    textAlign: 'left'

  Title:
    marginVertical: 30

  ButtonsContainer:
    alignItems: 'center'
    justifyContent: 'center'
    marginTop: 40

  Skip:
    padding: 20

  AgreeTerms:
    position: 'absolute'
    width: Window.width - 60
    bottom: 30
    textAlign: 'center'
    opacity: .5



export default Hybrid AskAccessCamera
