HeaderCustomBack = class extends PureComponent
  constructor: (props) ->
    super props



  press: =>
    if @props.action is 'goHome'
      @props.navigation.navigate 'Home'
    else
      @props.navigation.goBack()



  render: =>
    <TouchableOpacity onPress={ @press }>
      <Image source={ Assets.img.icons.back_arrow } style={{ width: 18, height: 18, marginLeft: 13, resizeMode: 'contain' }}/>
    </TouchableOpacity>



export default Hybrid withNavigation HeaderCustomBack
