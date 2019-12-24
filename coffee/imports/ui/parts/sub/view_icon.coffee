ViewIcon = class extends PureComponent
  constructor: (props) ->
    super props



  render: =>
    <View style={{ Shape.ViewIcon..., opacity: if @props.focused then 1 else .4 }}>
      <Image source={ @props.icon } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
    </View>



Shape = StyleSheet.create
  ViewIcon:
    alignItems: 'center'
    justifyContent: 'center'
    width: 20
    height: 20



export default Hybrid ViewIcon
