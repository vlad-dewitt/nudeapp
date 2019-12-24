HelpPage = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      content: @props.navigation.getParam 'help_page_content'



  render: =>
    <View style={ Shape.Box }>
      <Text style={[Typography.Medium, Typography.Regular, Typography.Grey, Shape.Title]}>{ @state.content.title }</Text>
      <ScrollView style={ Shape.ContentBox }>
        <Text style={[Typography.Medium, Typography.Regular, Typography.DarkGrey]}>{ @state.content.content }</Text>
      </ScrollView>
      <Text style={[Typography.Medium, Typography.Little, Typography.Grey, Shape.BottomText]}>Updated July 23, 2019</Text>
    </View>



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'
    alignItems: 'center'
    justifyContent: 'center'
    paddingVertical: 30
    paddingHorizontal: 30
    backgroundColor: '#F5F6F9'

  Title:
    width: '100%'
    alignItems: 'center'
    justifyContent: 'center'
    textAlign: 'center'

  ContentBox:
    width: Window.width - 60
    height: '90%'
    marginVertical: 20
    marginHorizontal: 30
    paddingHorizontal: 20
    paddingVertical: 30
    borderRadius: 16
    backgroundColor: 'white'

  BottomText:
    width: '100%'
    alignItems: 'center'
    justifyContent: 'center'
    textAlign: 'center'



export default Hybrid HelpPage
