import PlusIOS from './plus_ios'
import PlusAndroid from './plus_android'



HomePlus = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      plus_expanded: no
      camera_access: no
      fs_access: no
      picker_options:
        mediaTypes: ImagePicker.MediaTypeOptions.All
        allowsEditing: no
        base64: no
        exif: no



  componentDidMount: =>
    Permissions.getAsync(Permissions.CAMERA, Permissions.CAMERA_ROLL).then (res) =>
      @setState
        camera_access: res.permissions.camera.status is 'granted'
        fs_access: res.permissions.cameraRoll.status is 'granted'




  toggle: (expanded) =>
    @setState
      plus_expanded: expanded

  addMedia: =>
    if not @state.fs_access
      Permissions.askAsync(Permissions.CAMERA_ROLL).then (res) =>
        if res.status is 'granted'
          @setState
            fs_access: yes
        else
          Alert.alert 'Error', 'Nude requires access to your phone storage to add photos'
    else
      @props.navigation.navigate 'ImageSelector'
      @toggle no

  addFromCamera: =>
    if not @state.camera_access
      Permissions.getAsync(Permissions.CAMERA).then (res) =>
        if res.status is 'granted'
          @setState
            camera_access: yes
        else
          Alert.alert 'Error', 'Nude requires access to your camera to take pictures'
    else
      Ambry.call 'setLockLock', yes
      setTimeout =>
        ImagePicker.launchCameraAsync(@state.picker_options).then (res) =>
          if res.cancelled isnt yes
            API.global.addMedia { import: no }, [res]
          Ambry.call 'setLockLock', no
      , 200

      @toggle no




  render: =>
    <View style={ Shape.Box }>
      <View pointerEvents='box-none'>
        <Image source={ Assets.img.pictures.white_bottom_gradient } style={{ width: '100%', height: '100%', resizeMode: 'stretch' }}/>
      </View>
      {
        if Platform.OS is 'ios'
          <PlusIOS state={ @state.plus_expanded } onPress={ @toggle } cameraAction={ @addFromCamera } mediaAction={ @addMedia }/>
        else
          <PlusAndroid state={ @state.plus_expanded } onPress={ @toggle } cameraAction={ @addFromCamera } mediaAction={ @addMedia }/>
      }
    </View>



Shape = StyleSheet.create
  Box:
    width: '100%'
    height: '100%'



export default Hybrid withNavigation HomePlus
