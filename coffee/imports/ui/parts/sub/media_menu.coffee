MediaMenu = class extends Component
  constructor: (props) ->
    super props
    @state =
      config:
        delete: no
        export: no
        share: no



  componentDidMount: =>
    @init()

  componentDidUpdate: (prevProps, prevState) =>
    if prevProps.app.select_mode isnt @props.app.select_mode
      @init()



  init: =>
    config = @state.config

    if @props.app.select_mode.selected_objects.length > 0
      config.delete = yes
      config.export = yes
    else
      config.delete = no
      config.export = no

    if @props.app.select_mode.selected_objects.length is 1
      config.share = yes
    else
      config.share = no

    @setState
      config: config

  delete: =>
    objects = @props.app.select_mode.selected_objects

    message = if objects.length < 2 then "This action can't be undone" else "You're deleting #{ objects.length } files. This action can't be undone"
    button_text = if objects.length < 2 then 'Delete' else 'Delete All'

    Alert.alert 'Are you sure?', message,
      [
        {
          text: 'Cancel'
          style: 'cancel'
        }
        {
          text: button_text
          onPress: =>
            API.global.removeMedia objects, => @cancel()
        }
      ]

  export: =>
    objects = @props.app.select_mode.selected_objects

    Alert.alert "Export #{ objects.length } selected files?", '',
      [
        {
          text: 'No'
          style: 'cancel'
        }
        {
          text: 'Yes'
          onPress: =>
            API.global.exportMedia objects, => @cancel()
        }
      ]

  share: =>
    Sharing.shareAsync @props.app.select_mode.selected_objects[0].path
    .then => @cancel()

  cancel: =>
    Ambry.call 'setSelectMode',
      available: yes
      active: no
      selected_objects: []



  render: =>
    <View style={ Shape.Menu }>
      <View style={{ opacity: if @state.config.delete then 1 else .4 }}>
        <TouchableOpacity style={ Shape.MenuIcon } activeOpacity={ .5 } onPress={ if @state.config.delete then @delete }>
          <Image source={ Assets.img.icons.trash_linear_icon_grey } style={{ width: 18, height: 18, resizeMode: 'contain', marginBottom: 3 }}/>
          <Text style={[Typography.Light, Typography.Little, Typography.DarkGrey]}>Delete</Text>
        </TouchableOpacity>
      </View>
      <View style={{ opacity: if @state.config.export then 1 else .4 }}>
        <TouchableOpacity style={ Shape.MenuIcon } activeOpacity={ .5 } onPress={ if @state.config.export then @export }>
          <Image source={ Assets.img.icons.export_linear_icon_grey } style={{ width: 18, height: 18, resizeMode: 'contain', marginBottom: 3 }}/>
          <Text style={[Typography.Light, Typography.Little, Typography.DarkGrey]}>Export</Text>
        </TouchableOpacity>
      </View>
      <View style={{ opacity: if @state.config.share then 1 else .4 }}>
        <TouchableOpacity style={ Shape.MenuIcon } activeOpacity={ .5 } onPress={ if @state.config.share then @share }>
          <Image source={ Assets.img.icons.share_linear_icon_grey } style={{ width: 18, height: 18, resizeMode: 'contain', marginBottom: 3 }}/>
          <Text style={[Typography.Light, Typography.Little, Typography.DarkGrey]}>Share</Text>
        </TouchableOpacity>
      </View>
    </View>



Shape = StyleSheet.create
  Menu:
    width: '100%'
    height: 52
    zIndex: 2
    paddingHorizontal: Window.width / 6
    borderBottomWidth: .5
    borderBottomColor: '#AAAAAA'
    alignItems: 'center'
    flexDirection: 'row'
    justifyContent: 'space-between'
    backgroundColor: 'white'

  MenuIcon:
    alignItems: 'center'
    justifyContent: 'center'



export default Hybrid withNavigation MediaMenu
