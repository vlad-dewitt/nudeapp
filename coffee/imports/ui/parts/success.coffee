Success = class extends PureComponent
  constructor: (props) ->
    super props



  componentDidMount: =>
    setTimeout () =>
      next_route = @props.navigation.getParam 'next_route'
      if next_route
        @props.navigation.navigate next_route
      else
        @props.navigation.navigate 'Home'
    , 2000



  render: =>
    <View style={ Shape.Box }>
      <Image source={ Assets.img.icons.success } style={{ width: 106, height: 106, resizeMode: 'contain' }}/>
      <Text style={[Typography.Medium, Typography.Big, Typography.Grey, Shape.Text]}>Success</Text>
    </View>



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'
    backgroundColor: '#F5F6F9'
    alignItems: 'center'
    justifyContent: 'center'

  Text:
    marginTop: 20
    fontSize: 28
    letterSpacing: 1



export default Hybrid Success
