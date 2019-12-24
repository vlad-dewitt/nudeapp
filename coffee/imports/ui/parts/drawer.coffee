import BGGradient from './sub/bg_gradient'



Drawer = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      menu: [
        { id: 'home', title: 'Home', route: 'Home' }
        { id: 'settings', title: 'Settings', route: 'Settings' }
        { id: 'breakin_alerts', title: 'Break-in Alerts', route: 'BreakInAlerts' }
        { id: 'help', title: 'Help', route: 'Help' }
      ]



  componentDidMount: =>
    if @props.app.user.data.settings.auto_nude_detection
      { status: FS_permission_status } = await Permissions.askAsync Permissions.CAMERA_ROLL
      if FS_permission_status is 'granted'
        API.global.startDetection()

  close: =>
    @props.navigation.closeDrawer()

  openPage: (page) =>
    current_route = @props.navigation.state.routes[0].routes[@props.navigation.state.routes[0].routes.length - 1].routeName
    if current_route
      if current_route isnt page.route
        @props.navigation.navigate page.route
      else
        @close()
    else
      @props.navigation.navigate page.route




  render: =>
    <BGGradient colors={['#EDA9A9', '#FFD8C0']} style={{ width: '100%' }}>
      <View style={ Shape.Box }>
        <TouchableOpacity style={ Shape.CloseCross } onPress={ @close }>
          <Image source={ Assets.img.icons.thin_cross } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
        </TouchableOpacity>
        <View style={ Shape.Menu }>
          {
            @state.menu.map (item, num) =>
              <TouchableOpacity key={ num } style={ Shape.MenuItem } onPress={ @openPage.bind this, item }>
                <Text style={[Typography.Big, Typography.Light, Shape.MenuItemTitle]}>{ item.title }</Text>
              </TouchableOpacity>
          }
        </View>
      </View>
    </BGGradient>



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'
    alignItems: 'flex-start'
    justifyContent: 'center'
    paddingVertical: 30
    paddingHorizontal: 36

  CloseCross:
    position: 'absolute'
    width: 22
    height: 22
    top: 40
    left: 30

  MenuItem:
    marginVertical: 13

  MenuItemTitle:
    fontSize: 22



export default Hybrid Drawer
