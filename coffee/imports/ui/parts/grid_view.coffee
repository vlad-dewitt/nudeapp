GridView = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      objects: []



  componentDidMount: =>
    @props.navigation.addListener 'willFocus', @setSelectModeAvailable
    @props.navigation.addListener 'willBlur', @setSelectModeUnavailable
    @init()

  componentDidUpdate: (prevProps) =>
    if @props.app.select_mode.selected_objects isnt prevProps.app.select_mode.selected_objects
      @init()
    else if @props.objects.length isnt prevProps.objects.length
      @init()



  setSelectModeAvailable: =>
    Ambry.call 'setSelectMode',
      available: yes
      active: no
      selected_objects: []

  setSelectModeUnavailable: =>
    Ambry.call 'setSelectMode',
      available: no
      active: no
      selected_objects: []

  init: =>
    objects = @props.objects
    selected_objects = @props.app.select_mode.selected_objects

    @setState
      objects: objects
      selected_objects: selected_objects

  selectObject: (object, number) =>
    if @props.app.select_mode.active
      selected_objects = @props.app.select_mode.selected_objects
      if not _.findWhere selected_objects, { id: object.id }
        selected_objects.push object
      else
        selected_objects = _.without selected_objects, _.findWhere selected_objects, { id: object.id }
      Ambry.call 'setSelectMode',
        available: yes
        active: yes
        selected_objects: selected_objects
    else
      @openMedia number

  openMedia: (number) =>
    Ambry.call 'fillMediaViewer', { objects: @state.objects, first: number }
    @props.navigation.navigate 'MediaViewer'

  longPress: (object, { nativeEvent: event }) =>
    if not @props.app.select_mode.active
      if event.state is GestureState.ACTIVE
        Ambry.call 'setSelectMode',
          available: yes
          active: yes
          selected_objects: [object]



  render: =>
    <View style={ Shape.Box }>
      <ScrollView style={ Shape.ScrollBox }>
        {
          if @state.objects.length is 0
            <View style={ Shape.Empty }>
              <Image source={ Assets.img.icons.image } style={{ width: 96, height: 96, resizeMode: 'contain', marginRight: 10 }}/>
              <Text style={[Typography.Medium, Typography.Big, Typography.Grey, Shape.EmptyText]}>{ "No Media Yet" }</Text>
            </View>
          else
            <View style={ Shape.List }>
              {
                @state.objects.map (object, num) =>
                  selected = _.findWhere @state.selected_objects, { id: object.id }
                  <TouchableOpacity key={ num } style={ Shape.ListItem } activeOpacity={ .7 } onPress={ @selectObject.bind this, object, num }>
                    <View>
                      {
                        if object.type is 'image'
                          <Image source={{ uri: object.path }} style={{ width: '100%', height: '100%', resizeMode: 'cover' }}/>
                        else if object.type is 'video'
                          <Video source={{ uri: object.path }} rate={ 1.0 } volume={ 0 } isMuted={ no } resizeMode='cover' shouldPlay={ no } isLooping={ no } style={{ width: '100%', height: '100%' }}/>
                      }
                      {
                        if object.type is 'video'
                          <View style={ Shape.ListItemInfo }>
                            <View style={{ position: 'absolute', top: 0, left: 0, bottom: 0, right: 0 }} pointerEvents='box-none'>
                              <Image source={ Assets.img.pictures.dark_bottom_gradient } style={{ width: '100%', height: '100%', resizeMode: 'stretch' }}/>
                            </View>
                            <Image source={ Assets.img.icons.video_linear_icon } style={{ width: 14, height: 14, resizeMode: 'contain' }}/>
                            <Text style={[Typography.Medium, Typography.Little]}>{ if object.duration > 3599999 then moment(moment.duration(object.duration * 1000)._data).format 'h:mm:ss' else moment(moment.duration(object.duration * 1000)._data).format 'm:ss' }</Text>
                          </View>
                      }
                      {
                        if @props.app.select_mode.active
                          if selected
                            <View style={ Shape.ListItemSelection }>
                              <Image source={ Assets.img.icons.selected } style={{ width: 72, height: 72, resizeMode: 'contain' }}/>
                            </View>
                      }
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

  ListItem:
    width: Window.width / 3
    height: Window.width / 3
    borderWidth: .5
    borderColor: '#F5F6F9'
    borderRadius: 4
    overflow: 'hidden'

  ListItemInfo:
    position: 'absolute'
    bottom: 0
    left: 0
    zIndex: 3
    width: '100%'
    height: 26
    flexDirection: 'row'
    alignItems: 'center'
    justifyContent: 'space-between'
    paddingHorizontal: 8

  ListItemSelection:
    position: 'absolute'
    zIndex: 10
    top: 0
    left: 0
    bottom: 0
    right: 0
    backgroundColor: 'rgba(250, 217, 217, .8)'
    alignItems: 'center'
    justifyContent: 'center'



export default Hybrid withNavigation GridView
