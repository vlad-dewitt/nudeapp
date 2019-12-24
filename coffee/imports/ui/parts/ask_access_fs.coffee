import BGGradient from './sub/bg_gradient'



AskAccessFS = class extends PureComponent
  constructor: (props) ->
    super props



  openLink: (link) =>
    Linking.openURL "#{ WebsiteAddress }/#{link}"

  submit: =>
    await Permissions.askAsync Permissions.CAMERA_ROLL
    @next()

  next: =>
    { status: Camera_permission_status } = await Permissions.getAsync Permissions.CAMERA
    if Camera_permission_status isnt 'granted'
      @props.navigation.navigate 'AskAccessCamera'
    else
      API.global.checkConnection (connected) =>
        if connected
          await API.global.storeUser()
          API.global.syncUserLocally (res) =>
            @props.navigation.navigate 'Home'
        else
          Alert.alert 'Connection Error', 'Please check your internet connection'



  render: =>
    <BGGradient colors={['#EDA9A9', '#FFD8C0']}>
      <View style={ Shape.Box }>
        <View style={ Shape.IconBox }>
          <Image source={ Assets.img.icons.fs_access } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
        </View>
        <Text style={[Typography.SemiBold, Typography.Big, Shape.Text, Shape.Title]}>{ "Nude needs access to\nyour file storage" }</Text>
        <Text style={[Typography.Medium, Typography.Regular, Shape.Text]}>{ "This allows Nude to access and\nencrypt your photos or videos" }</Text>
        <View style={ Shape.ButtonsContainer }>
          <Theme.ButtonWhite style={{ width: Window.width - 100 }} text='Grant Access' color='#E0BDBD' onPress={ @submit }/>
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
    opacity: .7



export default Hybrid AskAccessFS
