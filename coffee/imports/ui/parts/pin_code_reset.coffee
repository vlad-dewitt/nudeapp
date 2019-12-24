import BGGradient from './sub/bg_gradient'



PinCodeReset = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      code: ''
      symbols: ['', '', '', '', '', '']



  componentDidMount: =>
    @props.navigation.closeDrawer()
    @sendCode()



  cancel: =>
    @props.navigation.navigate 'PinCodeVerification'

  focusInputBox: =>
    if @InputBox then @InputBox.focus()

  typeCode: (value) =>
    @setState
      code: value
    , =>
      updated_symbols = ['', '', '', '', '', '']
      input_symbols = @state.code.split ''
      input_symbols.map (symbol, num) =>
        updated_symbols[num] = symbol
      @setState
        symbols: updated_symbols

  submit: =>
    full_code = @state.symbols.join ''
    API.server.confirmResetPinCode full_code, (res) =>
      if res
        if res.confirmed
          @props.navigation.navigate 'ChangePIN'
        else
          Alert.alert 'Error', 'You entered the wrong code',
            text: 'OK'
      else
        Alert.alert 'Error', 'Internal Server Error',
          text: 'OK'

  sendCode: =>
    API.global.checkConnection (connected) =>
      if connected
        API.server.resetPinCode()
      else
        Alert.alert 'Connection Error', 'Please check your internet connection',
          [
            {
              text: 'Go back'
              onPress: =>
                @cancel()
            }
          ]

  resendCode: =>
    @sendCode()



  render: =>
    <BGGradient colors={['#EDA9A9', '#FFD8C0']}>
      <StatusBar barStyle='light-content'/>
      <View style={ Shape.Header }>
        <TouchableOpacity style={ Shape.HeaderLeft } onPress={ @cancel }>
          <Image source={ Assets.img.icons.back_arrow } style={ width: 18, height: 18, resizeMode: 'contain' }/>
        </TouchableOpacity>
        <View style={ Shape.HeaderRight }></View>
      </View>
      <View style={ Shape.Box }>
        <Text style={[Typography.SemiBold, Typography.Bigger, Shape.Text]}>{ "Confirm your identity to reset\nyour PIN number" }</Text>
        <Text style={[Typography.Medium, Typography.Regular, Shape.Text]}>{ "We just sent an access code to your\nemail account. Please enter below." }</Text>
        <TouchableOpacity style={ Shape.InputBox } activeOpacity={ 1 } onPress={ @focusInputBox }>
          <TextInput ref={ (input) => @InputBox = input } style={[Typography.Medium, Typography.Regular, Shape.ShadowInput]} onChangeText={ @typeCode } value={ @state.code } placeholder='' maxLength={ 6 } contextMenuHidden={ yes } autoCompleteType='off' keyboardType='number-pad' underlineColorAndroid='transparent' autoCapitalize='none' blurOnSubmit={ yes } returnKeyType='done' onSubmitEditing={ @submit }/>
          {
            @state.symbols.map (symbol, num) =>
              if symbol.length is 0
                <View key={ num } style={ Shape.InputBoxItemHidden }/>
              else
                <Text key={ num } style={[Typography.SemiBold, Shape.InputBoxItem]}>{ symbol }</Text>
          }
        </TouchableOpacity>
        <View style={ Shape.ButtonsContainer }>
          <Theme.ButtonWhite style={{ width: Window.width - 80 }} text='CONFIRM' color='#F6C3B6' onPress={ @submit }/>
          <Text style={[Typography.Small, Typography.White, Shape.Resend]} onPress={ @resendCode }>Resend Code</Text>
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
    marginTop: 100

  Text:
    textAlign: 'center'
    marginBottom: 15

  InputBox:
    flexDirection: 'row'
    zIndex: 2
    left: 45
    alignItems: 'center'
    justifyContent: 'center'
    backgroundColor: 'rgba(255,255,255,.23)'
    borderWidth: 1
    borderColor: 'white'
    width: Window.width - 90
    height: 90
    marginVertical: 40
    borderRadius: 12

  ShadowInput:
    width: 0
    height: 0
    overflow: 'hidden'

  InputBoxItem:
    textAlign: 'center'
    width: 36
    marginTop: 6
    color: 'rgb(128, 128, 128)'
    fontSize: 32
    lineHeight: 32

  InputBoxItemHidden:
    height: 16
    width: 16
    marginHorizontal: 10
    borderRadius: 8
    backgroundColor: 'rgba(255, 255, 255, .4)'

  ButtonsContainer:
    alignItems: 'center'
    justifyContent: 'center'
    marginTop: 15

  Resend:
    marginTop: 20





export default Hybrid PinCodeReset
