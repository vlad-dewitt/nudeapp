ListView = class extends PureComponent
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

    @setState
      objects: objects

  openMedia: (number) =>
    Ambry.call 'fillMediaViewer', { objects: @state.objects, first: number }
    @props.navigation.navigate 'MediaViewer'

  share: (object) =>
    Sharing.shareAsync object.path

  delete: (object) =>
    Alert.alert 'Are you sure?', 'This action can\'t be undone',
      [
        {
          text: 'Cancel'
          style: 'cancel'
        }
        {
          text: 'Delete'
          onPress: =>
            API.global.removeMedia [object]
        }
      ]



  render: =>
    <View style={ Shape.Box }>
      {
        if @state.objects.length is 0
          <ScrollView style={ Shape.ScrollBox }>
            <View style={ Shape.Empty }>
              <Image source={ Assets.img.icons.image } style={{ width: 96, height: 96, resizeMode: 'contain', marginRight: 10 }}/>
              <Text style={[Typography.Medium, Typography.Big, Typography.Grey, Shape.EmptyText]}>{ "No Media Yet" }</Text>
            </View>
          </ScrollView>
        else
          <FlatList data={ @state.objects } numColumns={ 1 } initialNumToRender={ 4 } onEndReachedThreshold={ .5 } renderItem={ ({ item, index }) =>
            <ListItem object={ item } index={ index } last={ @state.objects.length - 1 is index } openMedia={ @openMedia } share={ @share } delete={ @delete }/>
          } keyExtractor={ (path, index) => index.toString() }/>
      }
    </View>



ListItem = class extends PureComponent
  constructor: (props) ->
    super props

  render: =>
    if not @props.object
      null
    else
      object = @props.object
      num = @props.index
      <View style={{ Shape.ListItem..., marginBottom: if @props.last then 125 else 15 }}>
        <TouchableOpacity style={{ width: '100%', height: Window.width / 1.6 }} activeOpacity={ .5 } onPress={ @props.openMedia.bind this, num }>
          {
            if object.type is 'image'
              <Image source={{ uri: object.path }} style={{ width: '100%', height: '100%', resizeMode: 'cover' }}/>
            else if object.type is 'video'
              <Video source={{ uri: object.path }} rate={ 1.0 } volume={ 1.0 } isMuted={ no } resizeMode='cover' shouldPlay={ no } isLooping={ no } style={{ width: '100%', height: '100%' }}/>
          }
          {
            if object.type is 'video'
              <View style={ Shape.ListItemInfo }>
                <View style={{ position: 'absolute', top: 0, left: 0, bottom: 0, right: 0 }} pointerEvents='box-none'>
                  <Image source={ Assets.img.pictures.dark_bottom_gradient } style={{ width: '100%', height: '100%', resizeMode: 'stretch' }}/>
                </View>
                <Image source={ Assets.img.icons.video_linear_icon } style={{ width: 18, height: 18, resizeMode: 'contain' }}/>
                <Text style={[Typography.Medium, Typography.Small]}>{ if object.duration > 3599999 then moment(moment.duration(object.duration * 1000)._data).format 'h:mm:ss' else moment(moment.duration(object.duration * 1000)._data).format 'm:ss' }</Text>
              </View>
          }
        </TouchableOpacity>
        <View style={ Shape.ListItemFooter }>
          <Text style={[Typography.Medium, Typography.Small, Typography.DarkGrey]}>{ moment(object.date).fromNow() }</Text>
          <View style={ Shape.ListItemFooterRight }>
            <TouchableOpacity style={ Shape.ListItemFooterRightIcon } activeOpacity={ .5 } onPress={ @props.delete.bind this, object }>
              <Image source={ Assets.img.icons.trash_linear_icon } style={{ width: 20, height: 20, resizeMode: 'contain' }}/>
            </TouchableOpacity>
            <TouchableOpacity style={ Shape.ListItemFooterRightIcon } activeOpacity={ .5 } onPress={ @props.share.bind this, object }>
              <Image source={ Assets.img.icons.share_linear_icon } style={{ width: 20, height: 20, resizeMode: 'contain' }}/>
            </TouchableOpacity>
          </View>
        </View>
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

  ListItem:
    width: Window.width - 20
    height: Window.width / 1.6 + 52
    backgroundColor: 'white'
    marginHorizontal: 10
    marginBottom: 15
    borderRadius: 4
    overflow: 'hidden'

  ListItemInfo:
    position: 'absolute'
    bottom: 0
    left: 0
    zIndex: 3
    width: '100%'
    height: 38
    flexDirection: 'row'
    alignItems: 'center'
    justifyContent: 'space-between'
    paddingHorizontal: 16

  ListItemFooter:
    width: '100%'
    height: 52
    paddingHorizontal: 18
    backgroundColor: 'white'
    flexDirection: 'row'
    alignItems: 'center'
    justifyContent: 'space-between'

  ListItemFooterRight:
    flexDirection: 'row'
    alignItems: 'center'
    justifyContent: 'center'

  ListItemFooterRightIcon:
    alignItems: 'center'
    justifyContent: 'center'
    marginLeft: 18



export default Hybrid withNavigation ListView
