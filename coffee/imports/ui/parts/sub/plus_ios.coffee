import BGGradient from './bg_gradient'



PlusIOS = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      plus_rotate: new Animated.Value 0
      plus_icon_scale: new Animated.Value 1
      white_box_width: new Animated.Value 72
      white_box_margin: new Animated.Value (Window.width - 72) / 2
      icons_scale: new Animated.Value 0
      icons_opacity: new Animated.Value 0



  componentDidMount: =>
    Animated.spring(@state.icons_scale, toValue: 0, speed: 400, useNativeDriver: yes).start()
    Animated.spring(@state.icons_opacity, toValue: 0, speed: 400, useNativeDriver: yes).start()

  componentDidUpdate: (prevProps) =>
    if prevProps.state isnt @props.state
      if @props.state is yes
        @expand()
      else
        @collapse()




  expand: =>
    Animated.spring(@state.plus_rotate, toValue: 1, speed: 40, useNativeDriver: yes).start()
    Animated.spring(@state.plus_icon_scale, toValue: .7, speed: 60, useNativeDriver: yes).start()

    Animated.spring(@state.white_box_width, toValue: 260, speed: 30).start()
    Animated.spring(@state.white_box_margin, toValue: (Window.width - 260) / 2, speed: 30).start()

    Animated.spring(@state.icons_opacity, toValue: 1, speed: 40, useNativeDriver: yes, delay: 50).start()
    Animated.spring(@state.icons_scale, toValue: 1, speed: 40, useNativeDriver: yes, delay: 50).start()

  collapse: =>
    Animated.spring(@state.plus_rotate, toValue: 0, speed: 60, useNativeDriver: yes).start()
    Animated.spring(@state.plus_icon_scale, toValue: 1, speed: 60, useNativeDriver: yes).start()

    Animated.spring(@state.icons_opacity, toValue: 0, speed: 40, useNativeDriver: yes).start()
    Animated.spring(@state.icons_scale, toValue: 0, speed: 40, useNativeDriver: yes).start()

    Animated.spring(@state.white_box_width, toValue: 72, speed: 40, delay: 80).start()
    Animated.spring(@state.white_box_margin, toValue: (Window.width - 72) / 2, speed: 40, delay: 80).start()



  render: =>
    plus_icon_rotation = @state.plus_rotate.interpolate
      inputRange: [0, 1]
      outputRange: ['0deg', '45deg']

    <View style={ Shape.Plus }>
      <TouchableOpacity style={ Shape.PlusButton } activeOpacity={ .5 } onPress={ @props.onPress.bind this, if @props.state is yes then no else yes }>
        <BGGradient colors={['#FD8D68', '#F9799A', '#F97072']} style={{ width: '100%', height: '100%', alignItems: 'center', justifyContent: 'center' }}>
          <Animated.View style={{ Shape.PlusIcon..., transform: [{ rotate: plus_icon_rotation }, { scaleX: @state.plus_icon_scale }, { scaleY: @state.plus_icon_scale }] }}>
            <Image source={ Assets.img.icons.plus } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
          </Animated.View>
        </BGGradient>
      </TouchableOpacity>
      <Animated.View style={{ Shape.WhiteBox..., width: @state.white_box_width, marginHorizontal: @state.white_box_margin }}>
        <Animated.View style={{ opacity: @state.icons_opacity, transform: [{ scaleX: @state.icons_scale }, { scaleY: @state.icons_scale }] }}>
          <TouchableOpacity style={{ Shape.WhiteBoxIcon..., marginLeft: 34 }} activeOpacity={ .5 } onPress={ @props.mediaAction }>
            <Image source={ Assets.img.icons.add_media } style={{ width: 36, height: 29, resizeMode: 'contain', marginBottom: 2 }}/>
            <Text style={[Typography.Medium, Typography.Little, Typography.DarkGrey]}>Add</Text>
          </TouchableOpacity>
        </Animated.View>
        <Animated.View style={{ opacity: @state.icons_opacity, transform: [{ scaleX: @state.icons_scale }, { scaleY: @state.icons_scale }] }}>
          <TouchableOpacity style={{ Shape.WhiteBoxIcon..., marginRight: 30 }} activeOpacity={ .5 } onPress={ @props.cameraAction }>
            <Image source={ Assets.img.icons.camera } style={{ width: 28, height: 28, resizeMode: 'contain', marginBottom: 3 }}/>
            <Text style={[Typography.Medium, Typography.Little, Typography.DarkGrey]}>Camera</Text>
          </TouchableOpacity>
        </Animated.View>
      </Animated.View>
    </View>



Shape = StyleSheet.create
  Plus:
    position: 'absolute'
    width: '100%'
    height: '100%'
    bottom: 0

  PlusButton:
    position: 'absolute'
    zIndex: 2
    width: 72
    height: 72
    bottom: 15
    borderRadius: 36
    alignItems: 'center'
    justifyContent: 'center'
    overflow: 'hidden'
    marginHorizontal: (Window.width - 72) / 2

  PlusIcon:
    width: 26
    height: 26
    alignItems: 'center'
    justifyContent: 'center'

  WhiteBox:
    position: 'absolute'
    zIndex: 1
    height: 72
    bottom: 15
    borderRadius: 36
    alignItems: 'center'
    flexDirection: 'row'
    justifyContent: 'space-between'
    overflow: 'hidden'
    backgroundColor: '#EEEEEE'

  WhiteBoxIcon:
    alignItems: 'center'
    justifyContent: 'center'



export default Hybrid withNavigation PlusIOS
