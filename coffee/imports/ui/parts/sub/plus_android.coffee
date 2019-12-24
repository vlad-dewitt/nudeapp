import BGGradient from './bg_gradient'



PlusAndroid = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      plus_rotate: new Animated.Value 0
      plus_icon_scale: new Animated.Value 1
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

    Animated.spring(@state.icons_opacity, toValue: 1, speed: 40, useNativeDriver: yes).start()
    Animated.spring(@state.icons_scale, toValue: 1, speed: 40, useNativeDriver: yes).start()

  collapse: =>
    Animated.spring(@state.plus_rotate, toValue: 0, speed: 60, useNativeDriver: yes).start()
    Animated.spring(@state.plus_icon_scale, toValue: 1, speed: 60, useNativeDriver: yes).start()

    Animated.spring(@state.icons_opacity, toValue: 0, speed: 40, useNativeDriver: yes).start()
    Animated.spring(@state.icons_scale, toValue: 0, speed: 40, useNativeDriver: yes).start()



  render: =>
    plus_icon_rotation = @state.plus_rotate.interpolate
      inputRange: [0, 1]
      outputRange: ['0deg', '45deg']

    <View style={ Shape.Plus }>
      <TouchableOpacity style={ Shape.PlusButton } activeOpacity={ .9 } onPress={ @props.onPress.bind this, if @props.state is yes then no else yes }>
        <BGGradient colors={['#FD8D68', '#F9799A', '#F97072']} style={{ width: '100%', height: '100%', alignItems: 'center', justifyContent: 'center' }}>
          <Animated.View style={{ Shape.PlusIcon..., transform: [{ rotate: plus_icon_rotation }, { scaleX: @state.plus_icon_scale }, { scaleY: @state.plus_icon_scale }] }}>
            <Image source={ Assets.img.icons.plus } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
          </Animated.View>
        </BGGradient>
      </TouchableOpacity>
      <Animated.View style={{ Shape.Box..., opacity: @state.icons_opacity, transform: [{ scaleX: @state.icons_scale }, { scaleY: @state.icons_scale }] }}>
        <TouchableOpacity style={{ Shape.BoxIcon..., left: 0, top: 65 }} activeOpacity={ .6 } onPress={ @props.mediaAction }>
          <Image source={ Assets.img.icons.add_media } style={{ width: 36, height: 29, resizeMode: 'contain', marginBottom: 2 }}/>
          <Text style={[Typography.Medium, Typography.Little, Typography.DarkGrey]}>Add</Text>
        </TouchableOpacity>
        <TouchableOpacity style={{ Shape.BoxIcon..., left: 17.5, top: 0 }} activeOpacity={ .6 } onPress={ @props.cameraAction }>
          <Image source={ Assets.img.icons.camera } style={{ width: 28, height: 28, resizeMode: 'contain', marginBottom: 3 }}/>
          <Text style={[Typography.Medium, Typography.Little, Typography.DarkGrey]}>Camera</Text>
        </TouchableOpacity>
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
    right: 15
    borderRadius: 36
    alignItems: 'center'
    justifyContent: 'center'
    overflow: 'hidden'

  PlusIcon:
    width: 26
    height: 26
    alignItems: 'center'
    justifyContent: 'center'

  Box:
    position: 'absolute'
    width: 160
    height: 144
    right: 0
    bottom: 0

  BoxIcon:
    position: 'absolute'
    zIndex: 2
    width: 72
    height: 72
    alignItems: 'center'
    justifyContent: 'center'



export default Hybrid withNavigation PlusAndroid
