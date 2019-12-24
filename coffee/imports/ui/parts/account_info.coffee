AccountInfo = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      email: @props.app.user.data.emails[0].address or ''



  componentDidMount: =>
    @props.navigation.closeDrawer()



  typeEmail: (value) =>
    @setState
      email: value

  submit: =>
    email_address = @state.email.toLowerCase().replace /\s/g, ''
    email_test = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
    email_valid = email_test.test email_address
    if email_valid
      if email_address isnt @props.app.user.data.emails[0].address
        API.global.checkConnection (connected) =>
          if connected
            API.global.addEmail email_address, =>
              @props.navigation.navigate
                routeName: 'Success'
                params: { next_route: 'AccountInfo' }
          else
            Alert.alert 'Connection Error', 'Please check your internet connection'
    else
      Alert.alert 'Warning', 'Please enter a valid email address'

  goToDeleteAccount: =>
    Alert.alert 'We’re sad to see you go', 'Deleting your account will automatically export your photos back to your phone’s photostream and delete the existing photos on nude.',
      [
        { text: 'Cancel', style: 'cancel' }
        {
          text: 'Export & Delete'
          onPress: =>
            API.global.deleteUser =>
              @props.navigation.navigate 'Welcome'
        }
      ]



  render: =>
    <View style={ Shape.Box }>
      <View style={ Shape.TopBox }>
        <Text style={[Typography.Medium, Typography.Regular, Typography.DarkGrey, Shape.TopBoxText]}>PRIMARY EMAIL</Text>
        <TextInput style={[Typography.Medium, Typography.Regular, Typography.DarkGrey, Shape.EmailInput]} onChangeText={ @typeEmail } value={ @state.email } placeholder={ if not @state.email then "You don't have any email address yet" } placeholderTextColor='rgba(0,0,0,.2)' textContentType='emailAddress' autoCompleteType='email' keyboardType='email-address' underlineColorAndroid='transparent' autoCapitalize='none' onSubmitEditing={ @submit }/>
      </View>
      <TouchableOpacity style={ Shape.DeleteAccount } activeOpacity={ .5 } onPress={ @goToDeleteAccount }>
        <Text style={[Typography.Medium, Typography.Bigger]}>DELETE ACCOUNT</Text>
      </TouchableOpacity>
    </View>



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'
    backgroundColor: '#F5F6F9'

  TopBox:
    marginVertical: 25
    width: '100%'

  TopBoxText:
    marginHorizontal: 24

  EmailInput:
    width: Window.width
    marginVertical: 14
    paddingVertical: 16
    paddingHorizontal: 24
    borderWidth: 0
    borderColor: 'transparent'
    borderRadius: 0
    backgroundColor: 'white'
    alignItems: 'center'
    justifyContent: 'center'

  DeleteAccount:
    width: '100%'
    padding: 20
    backgroundColor: '#B1B1B1'
    position: 'absolute'
    bottom: 0
    alignItems: 'center'
    justifyContent: 'center'



export default Hybrid AccountInfo
