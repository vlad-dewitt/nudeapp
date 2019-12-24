import GridView from './grid_view'
import ListView from './list_view'
import GalleryView from './gallery_view'
import VideoView from './video_view'

import HomePlus from './sub/home_plus'
import ImportNotification from './sub/import_notification'



Home = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      objects: @props.app.data.media
      notification_position: new Animated.Value -64



  componentDidMount: =>
    # console.log 'Home mount'
    if @props.app.user.data.user_first_time
      Ambry.call 'setModalScreen',
        visible: yes
        type: 'modal_scanning'
    AppState.addEventListener 'change', @checkAppState
    # API.global.clearAppLockTimer()

  componentDidUpdate: (prevProps) =>
    if not _.isEqual @props.app.data.media, prevProps.app.data.media
      @setState
        objects: @props.app.data.media

  componentWillUnmount: =>
    AppState.removeEventListener 'change', @checkAppState



  checkAppState: (nextAppState) =>
    if @props.isFocused
      if Platform.OS is 'ios'
        if nextAppState isnt 'active'
          @props.navigation.navigate 'LockedScreen'
      else
        # if nextAppState isnt 'active'
        #   API.global.startAppLockTimer()
        # else
          # time_left = moment.duration(moment(moment new Date()).diff(@props.app.locked_at)).asMilliseconds()
        if nextAppState is 'active'
          if not @props.app.scanning.active and not @props.app.user.data.user_first_time and not @props.app.lock_lock
            @props.navigation.navigate 'PinCodeVerification'



  render: =>
    if @props.isFocused
      if @props.app.import_notification.visible is yes
        Animated.spring(@state.notification_position, toValue: 0, speed: 30, useNativeDriver: yes).start()
      else
        Animated.spring(@state.notification_position, toValue: -64, speed: 40, useNativeDriver: yes).start()
      <View style={ Shape.Box }>
        <View style={ Shape.View }>
          <StatusBar barStyle='light-content'/>
          <Animated.View style={{ Shape.Notification..., transform: [{ translateY: @state.notification_position }] }}>
            <ImportNotification/>
          </Animated.View>
          {
            if @props.view is 'grid'
              <GridView objects={ @state.objects }/>
            else if @props.view is 'list'
              <ListView objects={ @state.objects }/>
            else if @props.view is 'gallery'
              <GalleryView objects={ @state.objects }/>
            else if @props.view is 'video'
              <VideoView objects={ @state.objects }/>
          }
        </View>
        <View style={{ Shape.HomePlus..., height: if Platform.OS is 'ios' then 80 else 144 }} pointerEvents='box-none'>
          <HomePlus/>
        </View>
      </View>
    else
      null



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'

  Notification:
    position: 'absolute'
    zIndex: 2
    height: 64
    top: 0
    left: 0
    right: 0

  View:
    zIndex: 1
    flex: 1
    width: '100%'
    backgroundColor: '#F5F6F9'

  HomePlus:
    position: 'absolute'
    zIndex: 2
    bottom: 0
    width: '100%'



export default Hybrid withNavigationFocus withNavigation Home
