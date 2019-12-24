import * as Progress from 'react-native-progress'
import BGGradient from './sub/bg_gradient'



ModalScreen = class extends Component
  constructor: (props) ->
    super props
    @state =
      config: @props.app.modal_screen
      loading: new Animated.Value 0



  shouldComponentUpdate: (nextProps, nextState) =>
    if @props.app.modal_screen isnt nextProps.app.modal_screen
      yes
    else if @props.app.scanning isnt nextProps.app.scanning
      yes
    else if @props.app.user.data isnt nextProps.app.user.data
      yes
    else if @state.config isnt nextState.config
      yes
    else
      no

  componentDidUpdate: =>
    @setState
      config: @props.app.modal_screen

  closeModalScreen: =>
    if @state.config.type is 'modal_plus'
      Ambry.call 'setModalScreen', visible: yes, type: 'modal_scanning_process'
    else
      Ambry.call 'setModalScreen',
        visible: no
        type: ''

  showModalPlus: =>
    Ambry.call 'setModalScreen',
      visible: yes
      type: 'modal_plus'



  render: =>
    <View style={ Shape.Box }>
      {
        if @state.config.type is 'modal_scanning'
          <TouchableOpacity style={ Shape.ModalLayout } activeOpacity={ 1 } onPress={ @showModalPlus }>
            <View style={ Shape.ModalScanning }>
              <Image source={ Assets.img.pictures.modal_scanning } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
            </View>
          </TouchableOpacity>
        else if @state.config.type is 'modal_loading'
          <View style={ Shape.ModalLoading }>
            <Progress.Circle size={ 64 } indeterminate={ yes } color='#F98187' borderColor='#F98187' borderWidth={ 3 }/>
          </View>
        else if @state.config.type is 'modal_plus'
          <TouchableOpacity style={ Shape.ModalLayout } activeOpacity={ 1 } onPress={ @closeModalScreen }>
            <View style={ Shape.ModalPlus }>
              <Image source={ if Platform.OS is 'ios' then Assets.img.pictures.modal_plus else Assets.img.pictures.modal_plus_android } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
            </View>
          </TouchableOpacity>
        else if @state.config.type is 'modal_scanning_process'
          <View style={ Shape.ModalScanningProcess }>
            <BGGradient colors={['#CED5DF', '#A9B0C2']} from={[0, 0]} to={[0, 1]} style={{ width: '100%', height: '100%', padding: 20 }}>
              {
                if @props.app.user.data.user_first_time and @props.app.scanning.active
                  null
                else
                  <TouchableOpacity style={ Shape.ModalScanningProcessClose } activeOpacity={ .7 } onPress={ @closeModalScreen }>
                    <Image source={ Assets.img.icons.thin_cross } style={{ width: '100%', height: '100%' }}/>
                  </TouchableOpacity>
              }
              <View style={ Shape.ModalScanningProcessLoading }>
                <ImageBackground source={ Assets.img.pictures.progress_circle_bg } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}>
                  <View style={ Shape.ModalScanningProcessLoadingCircle }>
                    <Progress.Pie progress={ @props.app.scanning.progress / 100 } size={ Window.width - 80 - 60 } color='#F98187' borderWidth={ 0 }/>
                  </View>
                  <ImageBackground source={ Assets.img.pictures.progress_circle_center } style={{ width: '100%', height: '100%', resizeMode: 'contain', marginTop: 14 }}>
                    <View style={{ width: '100%', height: '100%', alignItems: 'center', justifyContent: 'center' }}>
                      <View style={{ alignItems: 'center', justifyContent: 'center', flexDirection: 'row' }}>
                        <Text style={[Typography.Medium, Typography.Big, Typography.DarkGrey, { fontSize: 60, marginLeft: 6 }]}>{ @props.app.scanning.progress.toFixed 0 }</Text>
                        <Text style={[Typography.Medium, Typography.Regular, Typography.DarkGrey, { marginTop: 26 }]}>%</Text>
                      </View>
                      <Text style={[Typography.Medium, Typography.Little, Typography.DarkGrey, { marginBottom: 32 }]}>COMPLETED</Text>
                    </View>
                  </ImageBackground>
                </ImageBackground>
              </View>
              <Text style={[Typography.Medium, Typography.Regular, Shape.ModalScanningProcessText, { marginBottom: 8 }]}>
                {
                  if Platform.OS is 'ios'
                    "Hang tight! Our Nude Bot 🤖\nis scanning your Camera Roll"
                  else
                    "Hang tight! Our Nude Bot 🤖\nis scanning your Gallery"
                }
              </Text>
              <Text style={[Typography.Light, Typography.Little, Shape.ModalScanningProcessText]}>{ "(You may continue to use the Nude App by closing this screen)" }</Text>
            </BGGradient>
          </View>
      }
    </View>



Shape = StyleSheet.create
  Box:
    position: 'absolute'
    zIndex: 9999
    top: 0
    left: 0
    bottom: 0
    right: 0
    alignItems: 'center'
    justifyContent: 'center'
    backgroundColor: 'rgba(0,0,0,.6)'

  ModalLayout:
    width: '100%'
    height: '100%'

  ModalScanning:
    position: 'absolute'
    top: 60
    right: -5
    width: Window.width / 1.6
    height: Window.height / 4.5

  ModalPlus:
    position: 'absolute'
    bottom: 86
    right: if Platform.OS is 'ios' then (Window.width - Window.width / 1.4) / 2 else 0
    width: Window.width / 1.4
    height: Window.height / 4.5

  ModalLoading:
    width: 64
    height: 64

  ModalScanningProcess:
    position: 'absolute'
    top: (Window.height - Window.height / 1.6) / 2
    right: 40
    width: Window.width - 80
    height: Window.height / 1.6
    alignItems: 'center'
    justifyContent: 'center'
    borderRadius: 40
    overflow: 'hidden'

  ModalScanningProcessLoading:
    marginVertical: 24
    marginHorizontal: 10
    width: Window.width - 80 - 60
    height: Window.width - 80 - 60
    alignItems: 'center'
    justifyContent: 'center'

  ModalScanningProcessLoadingCircle:
    position: 'absolute'
    top: -1
    left: 0
    right: 0
    bottom: 0

  ModalScanningProcessClose:
    position: 'absolute'
    top: 24
    left: 24
    width: 20
    height: 20
    alignItems: 'center'
    justifyContent: 'center'

  ModalScanningProcessText:
    textAlign: 'center'



export default Hybrid ModalScreen
