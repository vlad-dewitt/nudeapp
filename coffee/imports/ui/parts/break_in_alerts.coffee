BreakInAlerts = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      breakin_alerts: @props.app.user.data.breakins




  componentDidUpdate: (prevProps) =>
    if not _.isEqual @props.app.user.data.breakins, prevProps.app.user.data.breakins
      @setState
        breakin_alerts: @props.app.user.data.breakins



  deleteAll: =>
    Alert.alert "Confirmation", "Are you sure?",
      [
        { text: 'Cancel', style: 'cancel' }
        {
          text: "Delete #{ @state.breakin_alerts.length } items"
          onPress: => API.global.removeBreakIns @state.breakin_alerts
        }
      ]

  delete: (object) =>
    API.global.removeBreakIns [object]



  render: =>
    <View style={ Shape.Box }>
      {
        if @state.breakin_alerts.length is 0
          <View style={ Shape.Header }>
            <Text style={[Typography.Small, Typography.Regular, Typography.Grey]}>{ "You will be notified here whenever someone attempts to access the nude app with a wrong PIN" }</Text>
          </View>
        else
          <View style={ Shape.Header }>
            <Text style={[Typography.Medium, Typography.Bigger, Typography.Grey]}>{ "#{ @state.breakin_alerts.length } break-in attempts" }</Text>
            <TouchableOpacity style={ Shape.DeleteAll } activeOpacity={ .5 } onPress={ @deleteAll }>
              <Image source={ Assets.img.icons.trash } style={{ width: 32, height: 32, resizeMode: 'contain', marginBottom: 5 }}/>
              <Text style={[Typography.Medium, Typography.Little, Typography.Grey]}>Delete all</Text>
            </TouchableOpacity>
          </View>
      }
      <ScrollView style={ Shape.Content }>
        {
          if @state.breakin_alerts.length is 0
            <View style={ Shape.Empty }>
              <Image source={ Assets.img.icons.break_in } style={{ width: 96, height: 96, resizeMode: 'contain' }}/>
              <Text style={[Typography.Medium, Typography.Big, Typography.Grey, Shape.EmptyText]}>{ "No Attempted\nBreak-Ins Yet" }</Text>
            </View>
          else
            <View style={ Shape.List }>
              {
                @state.breakin_alerts.map (item, num) =>
                  <View key={ num } style={ Shape.ListItem }>
                    <Image source={{ uri: item.uri }} style={{ width: 56, height: 56, resizeMode: 'cover', borderRadius: 18, overflow: 'hidden' }}/>
                    <View>
                      <Text style={[Typography.Bolder, Typography.Big, Typography.Grey, Shape.ListItemText, Shape.ListItemPin]}>{ item.pin }</Text>
                      <Text style={[Typography.Medium, Typography.Bigger, Typography.Grey, Shape.ListItemText]}>{ moment(item.date).format 'MMMM D, YYYY' }</Text>
                    </View>
                    <TouchableOpacity activeOpacity={ .5 } onPress={ @delete.bind this, item }>
                      <Image source={ Assets.img.icons.trash_2 } style={{ width: 20, height: 20, resizeMode: 'contain' }}/>
                    </TouchableOpacity>
                  </View>
              }
            </View>
        }
      </ScrollView>
    </View>



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'

  Header:
    flexDirection: 'row'
    flexWrap: 'wrap'
    width: '100%'
    padding: 20
    borderBottomWidth: 1
    borderBottomColor: '#DADBDC'
    backgroundColor: 'white'
    alignItems: 'center'
    justifyContent: 'space-between'

  DeleteAll:
    alignItems: 'center'
    justifyContent: 'center'

  Content:
    width: Window.width
    flex: 1
    padding: 16
    backgroundColor: '#F5F6F9'

  Empty:
    flex: 1
    marginTop: Window.height / 5.5
    alignItems: 'center'
    justifyContent: 'center'

  EmptyText:
    marginTop: 15
    textAlign: 'center'

  List:
    marginBottom: 40

  ListItem:
    flexDirection: 'row'
    flexWrap: 'wrap'
    alignItems: 'center'
    justifyContent: 'space-between'
    marginVertical: 6
    padding: 20
    borderRadius: 12
    backgroundColor: 'white'

  ListItemText:
    marginVertical: 2.5
    marginRight: 60
    textAlign: 'left'
    letterSpacing: 0

  ListItemPin:
    color: '#D3DDE5'



export default Hybrid BreakInAlerts
