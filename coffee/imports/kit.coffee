import Navigator from './genius/navigator/kit'
import ModalScreen from './ui/parts/modal_screen'



App = class extends Component
  constructor: (props) ->
    super props



  componentDidMount: =>
    ScreenOrientation.lockAsync ScreenOrientation.Orientation.PORTRAIT
    SplashScreen.hide()
    API.global.setInitialData()
    await @loadFonts()
    await API.global.syncUserLocally (res) =>
      # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
      # console.log "(((await API.global.syncUserLocally (finished):"
      # console.log res
      # console.log 'await API.global.syncUserLocally)))'
      # console.log '>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>'
    API.global.syncMediaLocally()

    Ambry.call 'setAppLoaded'



  loadFonts: =>
    Font.loadAsync
      'Montserrat-Thin': require '../../assets/fonts/Montserrat-Thin.ttf'
      'Montserrat-Light': require '../../assets/fonts/Montserrat-Light.ttf'
      'Montserrat-Regular': require '../../assets/fonts/Montserrat-Regular.ttf'
      'Montserrat-Medium': require '../../assets/fonts/Montserrat-Medium.ttf'
      'Montserrat-SemiBold': require '../../assets/fonts/Montserrat-SemiBold.ttf'
      'Montserrat-Bold': require '../../assets/fonts/Montserrat-Bold.ttf'



  render: =>
    <View style={ width: '100%', height: '100%' }>
      <Navigator screenProps={{ @props..., loaded: @props.app.loaded }}/>
      {
        if @props.app.modal_screen.visible
          <ModalScreen/>
      }
    </View>



export default Hybrid App
