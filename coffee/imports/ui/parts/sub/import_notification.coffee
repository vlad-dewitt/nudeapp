import BGGradient from './bg_gradient'



ImportNotification = class extends PureComponent
  constructor: (props) ->
    super props



  delete: =>
    objects = @props.app.import_notification.objects

    API.global.removeMediaFromLibrary objects, =>
      if Platform.OS is 'ios'
        Alert.alert 'ONE MORE THING', 'Don\'t forget to delete your photos from the "Recently Deleted" album in your Camera Roll 😉',
          [
            {
              text: 'Ok'
              onPress: => @cancel()
            }
          ]
      else
        @cancel()

  cancel: =>
    Ambry.call 'setImportNotification',
      visible: no
      objects: []

    API.global.lastScanning 'finish'



  render: =>
    <BGGradient colors={['#574B90', '#FC85AE']} style={{ width: '100%', height: '100%' }}>
      <View style={ Shape.Box }>
        <TouchableOpacity style={ Shape.Cancel } activeOpacity={ .7 } onPress={ @cancel }>
          <Image source={ Assets.img.icons.plus } style={{ width: 16, height: 16, resizeMode: 'contain' }}/>
        </TouchableOpacity>
        <Text style={[Typography.Medium, Typography.Small]}>
          {
            if Platform.OS is 'ios'
              "Import complete. Delete from\nCamera Roll?"
            else
              "Import complete. Delete from\nGallery?"
          }
        </Text>
        <TouchableOpacity style={ Shape.Delete } activeOpacity={ .7 } onPress={ @delete }>
          <Image source={ Assets.img.icons.trash_white } style={{ width: 24, height: 24, resizeMode: 'contain', marginBottom: 5 }}/>
          <Text style={[Typography.Light, Typography.Little]}>Delete</Text>
        </TouchableOpacity>
      </View>
    </BGGradient>



Shape = StyleSheet.create
  Box:
    alignItems: 'center'
    flexDirection: 'row'
    justifyContent: 'space-between'
    width: '100%'
    height: '100%'
    paddingVertical: 16
    paddingHorizontal: 24
    paddingLeft: 12

  Cancel:
    width: 36
    height: 36
    alignItems: 'center'
    justifyContent: 'center'
    transform: [
      { rotate: '45deg' }
    ]
    padding: 10

  Delete:
    height: 32
    alignItems: 'center'
    justifyContent: 'center'
    marginLeft: 5



export default Hybrid ImportNotification
