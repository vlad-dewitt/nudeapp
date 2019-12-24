InfoCard = class extends PureComponent
  constructor: (props) ->
    super props



  render: =>
    <View style={ Shape.Box }>
      <Text style={[Typography.Bold, Typography.Big, Typography.DarkGrey, Shape.Text, Shape.Title]}>{ @props.title }</Text>
      <Text style={[Typography.SemiBold, Typography.Small, Typography.Grey, Shape.Text]}>{ @props.info }</Text>
      <View style={ Shape.ImageContainer }>
        <Image source={ @props.picture } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
      </View>
      <View style={ Shape.ButtonsContainer }>
        <Theme.ButtonEmpty text={ if @props.last then 'GET STARTED' else ' NEXT ' } color={ @props.button_color } onPress={ @props.next }/>
        <Text style={[Typography.Small, Typography.Grey, Shape.Skip]} onPress={ @props.skip }>SKIP</Text>
      </View>
    </View>



Shape = StyleSheet.create
  Box:
    flex: 1
    alignItems: 'center'
    justifyContent: 'center'
    paddingVertical: 30
    paddingHorizontal: 30

  Title:
    marginBottom: 15

  Text:
    textAlign: 'center'
    marginBottom: 15

  ImageContainer:
    flex: 2
    marginVertical: 20
    width: Window.width - 90
    height: Window.height / 2

  ButtonsContainer:
    flex: 1
    alignItems: 'center'
    justifyContent: 'center'

  Skip:
    padding: 20
    paddingBottom: 10



export default Hybrid InfoCard
