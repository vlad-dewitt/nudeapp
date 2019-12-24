import BGGradient from './sub/bg_gradient'



EnterEmail = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      email: ''



  typeEmail: (value) =>
    @setState
      email: value

  submit: =>
    email_address = @state.email.toLowerCase().replace /\s/g, ''
    email_test = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    email_valid = email_test.test email_address
    if email_valid
      Ambry.call 'setEmailAddress', email_address
      @skip()
    else
      Alert.alert 'Warning', 'Please enter a valid email address'

  skip: =>
    API.server.checkUser @state.email.toLowerCase().replace(/\s/g, ''), (res) =>
      if res.status is 'User Exists and email recognized' or res.status is 'User Exists and email not recognized'
        Ambry.call 'setRestoreUserMode', yes
        @finish()
      else if res.status is 'User doesn\'t exist and email recognized'
        Alert.alert 'Error', 'This email addres is already in use. Please try another one'
      else
        @finish()

  finish: =>
    { status: FS_permission_status } = await Permissions.getAsync Permissions.CAMERA_ROLL
    { status: Camera_permission_status } = await Permissions.getAsync Permissions.CAMERA
    if FS_permission_status isnt 'granted'
      @props.navigation.navigate 'AskAccessFS'
    else if Camera_permission_status isnt 'granted'
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
        <Text style={[Typography.SemiBold, Typography.Big, Shape.Text]}>Your PIN is:</Text>
        <Text style={[Typography.SemiBold, Shape.FullPin, Shape.Text]}>{ @props.app.user.full_pin }</Text>
        <Text style={[Typography.Medium, Typography.Regular, Shape.Text]}>Please Enter Email Address</Text>
        <TextInput style={[Typography.Medium, Typography.Regular, Shape.EmailInput]} onChangeText={ @typeEmail } value={ @state.email } placeholder='Email address...' placeholderTextColor='rgba(255,255,255,.5)' textContentType='emailAddress' autoCompleteType='email' keyboardType='email-address' underlineColorAndroid='transparent' autoCapitalize='none' blurOnSubmit={ yes } returnKeyType='done' onSubmitEditing={ @submit }/>
        <Text style={[Typography.Medium, Typography.Small, Shape.Text]}>{ "Your email address is used for passcode reset\nand communication purposes" }</Text>
        <View style={ Shape.ButtonsContainer }>
          <Theme.ButtonWhite style={{ width: Window.width - 80 }} text='FINISH' color='#F6C3B6' onPress={ @submit }/>
          <Text style={[Typography.Small, Typography.White, Shape.Skip]} onPress={ @skip }>SKIP</Text>
        </View>
      </View>
    </BGGradient>



Shape = StyleSheet.create
  Box:
    flex: 1
    marginTop: 70

  Text:
    textAlign: 'center'

  FullPin:
    marginTop: 15
    marginBottom: 40
    fontSize: 40
    lineHeight: 40
    letterSpacing: 2
    color: 'white'

  EmailInput:
    width: Window.width - 80
    marginVertical: 30
    marginHorizontal: 40
    paddingVertical: 14
    paddingHorizontal: 18
    borderWidth: 1
    borderColor: 'white'
    borderRadius: 32
    backgroundColor: 'rgba(255,255,255, .1)'
    alignItems: 'center'
    justifyContent: 'center'
    color: 'white'

  ButtonsContainer:
    alignItems: 'center'
    justifyContent: 'center'
    marginTop: 60

  Skip:
    padding: 20





export default Hybrid EnterEmail
