VideoView = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      objects: []



  componentDidMount: =>
    @init()

  componentDidUpdate: (prevProps, prevState) =>
    if not _.isEqual @props.objects, prevProps.objects
      @init()
    else if not _.isEqual @state.objects, prevState.objects
      @init()



  init: =>
    objects = @props.objects

    objects = _.where objects, { type: 'video' }

    @setState
      objects: objects

  openMedia: (number) =>
    Ambry.call 'fillMediaViewer', { objects: @state.objects, first: number }
    @props.navigation.navigate 'MediaViewer'



  render: =>
    <View style={ Shape.Box }>
      <ScrollView style={ Shape.ScrollBox }>
        {
          if @state.objects.length is 0
            <View style={ Shape.Empty }>
              <Image source={ Assets.img.icons.video } style={{ width: 96, height: 96, resizeMode: 'contain', marginLeft: 5 }}/>
              <Text style={[Typography.Medium, Typography.Big, Typography.Grey, Shape.EmptyText]}>{ "No Videos Yet" }</Text>
            </View>
          else
            <View style={ Shape.List }>
              {
                @state.objects.map (object, num) =>
                  <TouchableOpacity key={ num } style={ Shape.ListItem } activeOpacity={ .7 } onPress={ @openMedia.bind this, num }>
                    <Video source={{ uri: object.path }} rate={ 1.0 } volume={ 1.0 } isMuted={ no } resizeMode='cover' shouldPlay={ no } isLooping={ no } style={{ width: '100%', height: '100%' }}/>
                    <View style={ Shape.ListItemInfo }>
                      <View style={{ position: 'absolute', top: 0, left: 0, bottom: 0, right: 0 }} pointerEvents='box-none'>
                        <Image source={ Assets.img.pictures.dark_bottom_gradient } style={{ width: '100%', height: '100%', resizeMode: 'stretch' }}/>
                      </View>
                      <Image source={ Assets.img.icons.video_linear_icon } style={{ width: 16, height: 16, resizeMode: 'contain' }}/>
                      <Text style={[Typography.Medium, Typography.Small]}>{ if object.duration > 3599999 then moment(moment.duration(object.duration * 1000)._data).format 'h:mm:ss' else moment(moment.duration(object.duration * 1000)._data).format 'm:ss' }</Text>
                    </View>
                  </TouchableOpacity>
              }
            </View>
        }
      </ScrollView>
    </View>



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'

  ScrollBox:
    flex: 1
    width: '100%'

  Empty:
    flex: 1
    marginTop: Window.height / 4
    alignItems: 'center'
    justifyContent: 'center'

  EmptyText:
    marginTop: 15
    textAlign: 'center'

  List:
    width: '100%'
    flexDirection: 'row'
    flexWrap: 'wrap'
    alignItems: 'center'
    marginBottom: 125
    paddingHorizontal: 2
    paddingTop: 2

  ListItem:
    width: (Window.width - 4) / 2
    height: (Window.width - 4) / 2
    borderWidth: 2
    borderColor: '#F5F6F9'
    borderRadius: 4
    overflow: 'hidden'

  ListItemInfo:
    position: 'absolute'
    bottom: 0
    left: 0
    zIndex: 3
    width: '100%'
    height: 32
    flexDirection: 'row'
    alignItems: 'center'
    justifyContent: 'space-between'
    paddingHorizontal: 10



export default Hybrid withNavigation VideoView
