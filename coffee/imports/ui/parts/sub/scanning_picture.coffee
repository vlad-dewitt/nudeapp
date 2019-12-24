ScanningPicture = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      opacity: new Animated.Value .5



  componentDidMount: =>
    setInterval =>
      Animated.timing @state.opacity,
        toValue: 1
        duration: 1000
        useNativeDriver: yes
      .start()
      setTimeout () =>
        Animated.timing @state.opacity,
          toValue: .5
          duration: 1000
          useNativeDriver: yes
        .start()
      , 1000
    , 2000



  press: =>
    Ambry.call 'setModalScreen',
      visible: yes
      type: 'modal_scanning_process'



  render: =>
    if @props.app.scanning.active or @props.app.modal_screen.type is 'modal_scanning' or @props.app.modal_screen.type is 'modal_plus'
      <Animated.View style={{ opacity: @state.opacity }}>
        <TouchableOpacity onPress={ if not @props.untouchable then @press }>
          <Image source={ Assets.img.icons.scanning_picture } style={{ width: 72, height: 32, resizeMode: 'contain' }}/>
        </TouchableOpacity>
      </Animated.View>
    else
      null



export default Hybrid ScanningPicture
