import { createStackNavigator } from 'react-navigation'

import Welcome from '../../ui/parts/welcome'
import Cards from '../../ui/parts/cards'
import PinCode from '../../ui/parts/pin_code'
import EnterEmail from '../../ui/parts/enter_email'
import AskAccessFS from '../../ui/parts/ask_access_fs'
import AskAccessCamera from '../../ui/parts/ask_access_camera'



export default createStackNavigator
  Welcome:
    screen: Welcome
    path: 'welcome'
    navigationOptions:
      header: null
  Cards:
    screen: Cards
    path: 'cards'
    navigationOptions:
      header: null
      gesturesEnabled: no
  PinCodeCreate:
    screen: => <PinCode status='create'/>
    path: 'pincode-create'
    navigationOptions:
      headerTransparent: yes
      headerRight: <Text style={ Typography.Small }>Step 1 of 2</Text>
  EnterEmail:
    screen: EnterEmail
    path: 'enter-email'
    navigationOptions:
      headerTransparent: yes
      headerRight: <Text style={ Typography.Small }>Step 2 of 2</Text>
  AskAccessFS:
    screen: AskAccessFS
    path: 'ask-access-fs'
    navigationOptions:
      header: null
      gesturesEnabled: no
  AskAccessCamera:
    screen: AskAccessCamera
    path: 'ask-access-camera'
    navigationOptions:
      header: null
      gesturesEnabled: no
,
  defaultNavigationOptions:
    headerBackImage: <Image source={ Assets.img.icons.back_arrow } style={ width: 18, height: 18, resizeMode: 'contain' }/>
    headerBackTitleStyle:
      color: 'white'
    headerBackTitle: null
    headerLeftContainerStyle:
      paddingLeft: 16
    headerRightContainerStyle:
      paddingRight: 16
