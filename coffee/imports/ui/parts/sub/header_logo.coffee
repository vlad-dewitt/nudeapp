import NudeLogo from './nude_logo'



HeaderLogo = class extends PureComponent
  constructor: (props) ->
    super props



  render: =>
    <View style={ Shape.Box }>
      <NudeLogo/>
    </View>



Shape = StyleSheet.create
  Box:
    width: 106
    height: 48
    alignItems: 'center'



export default Hybrid HeaderLogo
