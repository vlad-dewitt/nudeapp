HeaderIdentity = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      identity_hardware: @props.app.initial_data.identity_hardware
      identity_enabled: @props.app.user.data.settings.touch_id_enabled



  press: =>
    API.global.identify (identified) =>
      if identified
        @props.navigation.navigate 'Home'



  render: =>
    if @state.identity_hardware and @state.identity_enabled
      <TouchableOpacity onPress={ @press }>
        <Image source={ if @state.identity_hardware is 'FINGERPRINT' then Assets.img.icons.touch_id else Assets.img.icons.face_id } style={{ width: 36, height: 36, resizeMode: 'contain' }}/>
      </TouchableOpacity>
    else
      null



export default Hybrid withNavigation HeaderIdentity
