GalleryView = class extends PureComponent
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

    objects = _.where objects, { type: 'image' }

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
              <Image source={ Assets.img.icons.image } style={{ width: 96, height: 96, resizeMode: 'contain', marginRight: 10 }}/>
              <Text style={[Typography.Medium, Typography.Big, Typography.Grey, Shape.EmptyText]}>{ "No Images Yet" }</Text>
            </View>
          else
            <View style={ Shape.List }>
              {
                @state.objects.map (object, num) =>
                  <TouchableOpacity key={ num } style={ Shape.ListItem } activeOpacity={ .7 } onPress={ @openMedia.bind this, num }>
                    <Image source={{ uri: object.path }} style={{ width: '100%', height: '100%', resizeMode: 'cover' }}/>
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



export default Hybrid withNavigation GalleryView
