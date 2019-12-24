import Carousel from '../../tools/carousel'



MediaViewer = class extends Component
  constructor: (props) ->
    super props
    @state =
      objects: []
      current_object: {}
      orientation: 'PORTRAIT'
    @zoom =
      scale: new Animated.Value 1
      position:
        x: 0
        y: 0
      translateX: new Animated.Value 0
      translateY: new Animated.Value 0
    @videos = {}



  componentDidMount: =>
    ScreenOrientation.unlockAsync()
    ScreenOrientation.addOrientationChangeListener @onOrientationChange
    @init()

  componentDidUpdate: =>
    @init()

  componentWillUnmount: =>
    Ambry.call 'clearMediaViewer'
    ScreenOrientation.removeOrientationChangeListeners()
    ScreenOrientation.lockAsync ScreenOrientation.Orientation.PORTRAIT



  init: =>
    if not _.isEqual @props.app.media_viewer.objects, @state.objects
      objects = []

      @props.app.media_viewer.objects.map (object, num) =>
        object.index = num
        objects.push object

      @setState
        objects: objects
        current_object: objects[@props.app.media_viewer.first]

  onOrientationChange: (e) =>
    orientation = if e.orientationInfo.orientation.includes 'PORTRAIT' then 'PORTRAIT' else 'LANDSCAPE'
    @setState
      orientation: orientation
    @changeObject @state.current_object.index

  changeObject: (number) =>
    if @videos[@state.current_object.id]
      @videos[@state.current_object.id].stopAsync()
    @setState
      current_object: @state.objects[number]

  videoPlaybackStatusChange: (status) =>
    if status.isPlaying
      playing = yes
    else
      playing = no

    if @state.current_object.isPlaying isnt playing
      @setState
        current_object: {
          @state.current_object...
          isPlaying: playing
        }
      , =>
        if playing
          @focus()

  focus: (value) =>
    if value isnt yes and value isnt no
      value = if @props.app.media_viewer.focus is yes then no else yes

    if @props.app.media_viewer.focus isnt value
      if @state.current_object.isPlaying
        Ambry.call 'setMediaViewerFocus', yes
      else
        Ambry.call 'setMediaViewerFocus', value

  pinch: ({ nativeEvent: event }) =>
    if event.state is GestureState.ACTIVE
      @focus yes
      if event.scale > 0.8 and event.scale < 3
        Animated.spring(@zoom.scale, toValue: event.scale, speed: 400, useNativeDriver: yes).start()
      Animated.spring(@zoom.translateX, toValue: event.focalX - @zoom.position.x, speed: 400, useNativeDriver: yes).start()
      Animated.spring(@zoom.translateY, toValue: event.focalY - @zoom.position.y, speed: 400, useNativeDriver: yes).start()

  pinchStateChange: ({ nativeEvent: event }) =>
    if event.state is GestureState.BEGAN
      @zoom.position =
        x: event.focalX
        y: event.focalY
    if event.state is GestureState.END
      @zoom.position =
        x: 0
        y: 0
      Animated.timing(@zoom.scale, toValue: 1, duration: 200, useNativeDriver: yes).start()
      Animated.timing(@zoom.translateX, toValue: 0, duration: 200, useNativeDriver: yes).start()
      Animated.timing(@zoom.translateY, toValue: 0, duration: 200, useNativeDriver: yes).start()

  share: =>
    Sharing.shareAsync @state.current_object.path

  export: =>
    Alert.alert "Export this files?", '',
      [
        {
          text: 'No'
          style: 'cancel'
        }
        {
          text: 'Yes'
          onPress: =>
            API.global.exportMedia [@state.current_object], => @cancel()
        }
      ]

  delete: =>
    Alert.alert 'Are you sure?', 'This action can\'t be undone',
      [
        {
          text: 'Cancel'
          style: 'cancel'
        }
        {
          text: 'Delete'
          onPress: =>
            API.global.removeMedia [@state.current_object]
            @cancel()
        }
      ]

  cancel: =>
    @props.navigation.goBack()



  render: =>
    <View style={{ Shape.Box..., height: Dimensions.get('window').height }}>
      {
        if @state.objects.length > 0
          <View style={ Shape.Content }>
            <Carousel pageStyle={{ Shape.MediaSlider..., height: Dimensions.get('window').height }} width={ Dimensions.get('window').width } pageWidth={ Dimensions.get('window').width } swipeThreshold={ .3 } sneak={ 0 } onPageChange={ @changeObject } currentPage={ @state.current_object.index }>
              {
                @state.objects.map (object, num) =>
                  if @state.current_object.index - 1 is num or @state.current_object.index is num or @state.current_object.index + 1 is num
                    <TouchableOpacity key={ num } style={ Shape.MediaSliderItem } activeOpacity={ 1 } onPress={ @focus }>
                      <View style={ width: '100%', height: '100%' }>
                        {
                          if object.type is 'image'
                            <PinchGestureHandler onGestureEvent={ @pinch } onHandlerStateChange={ @pinchStateChange }>
                              <Animated.Image source={{ uri: object.path }} style={{ width: '100%', height: '100%', resizeMode: 'contain', transform: [{ scale: @zoom.scale }, { translateX: 0 }, { translateY: 0 }] }}/>
                            </PinchGestureHandler>
                          else if object.type is 'video'
                            <Video ref={ (ref) => @videos[object.id] = ref } source={{ uri: object.path }} rate={ 1.0 } volume={ 1.0 } isMuted={ no } resizeMode='contain' shouldPlay={ no } useNativeControls isLooping={ no } style={{ width: '100%', height: '100%' }} onPlaybackStatusUpdate={ @videoPlaybackStatusChange }/>
                        }
                      </View>
                    </TouchableOpacity>
              }
            </Carousel>
            {
              if not @props.app.media_viewer.focus
                <View style={{ Shape.MediaMenu..., top: Dimensions.get('window').height - 56, paddingHorizontal: if @state.orientation is 'PORTRAIT' then Dimensions.get('window').width / 6 else Dimensions.get('window').width / 3 }}>
                  <StatusBar hidden={ no }/>
                  <TouchableOpacity style={ Shape.MediaMenuIcon } activeOpacity={ .5 } onPress={ @share }>
                    <Image source={ Assets.img.icons.share_linear_icon } style={{ width: 20, height: 20, resizeMode: 'contain', marginBottom: 5 }}/>
                    <Text style={[Typography.Light, Typography.Little]}>Share</Text>
                  </TouchableOpacity>
                  <TouchableOpacity style={ Shape.MediaMenuIcon } activeOpacity={ .5 } onPress={ @export }>
                    <Image source={ Assets.img.icons.export_linear_icon } style={{ width: 20, height: 20, resizeMode: 'contain', marginBottom: 5 }}/>
                    <Text style={[Typography.Light, Typography.Little]}>Export</Text>
                  </TouchableOpacity>
                  <TouchableOpacity style={ Shape.MediaMenuIcon } activeOpacity={ .5 } onPress={ @delete }>
                    <Image source={ Assets.img.icons.trash_linear_icon } style={{ width: 20, height: 20, resizeMode: 'contain', marginBottom: 5 }}/>
                    <Text style={[Typography.Light, Typography.Little]}>Delete</Text>
                  </TouchableOpacity>
                </View>
              else
                <StatusBar hidden={ yes }/>
            }
          </View>
      }
    </View>



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'
    backgroundColor: 'black'

  Content:
    flex: 1
    alignItems: 'center'
    justifyContent: 'center'

  MediaSlider:
    alignItems: 'center'
    justifyContent: 'center'

  MediaSliderItem:
    flex: 1
    width: '100%'
    alignItems: 'center'
    justifyContent: 'center'
    overflow: 'hidden'

  MediaMenu:
    position: 'absolute'
    width: '100%'
    height: 56
    alignItems: 'center'
    flexDirection: 'row'
    justifyContent: 'space-between'
    backgroundColor: 'rgba(0,0,0,.2)'

  MediaMenuIcon:
    alignItems: 'center'
    justifyContent: 'center'



export default Hybrid MediaViewer
