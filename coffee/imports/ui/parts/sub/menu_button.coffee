MenuButton = class extends PureComponent
  constructor: (props) ->
    super props



  openMenu: =>
    @props.navigation.openDrawer()



  render: =>
    <TouchableOpacity style={ width: 36, height: 36, alignItems: 'center', justifyContent: 'center' } onPress={ @openMenu }>
      <Image source={ Assets.img.icons.three_dots } style={ width: 24, height: 24, resizeMode: 'contain' }/>
    </TouchableOpacity>



export default Hybrid withNavigation MenuButton
