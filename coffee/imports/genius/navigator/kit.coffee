import { createSwitchNavigator, createAppContainer } from 'react-navigation'
import createAnimatedSwitchNavigator from 'react-navigation-animated-switch'

import AuthNavigator from './auth_navigator'
import HomeNavigator from './home_navigator'
import PinCode from '../../ui/parts/pin_code'
import PinCodeReset from '../../ui/parts/pin_code_reset'

import Success from '../../ui/parts/success'



Navigator =
  AuthNavigator: AuthNavigator
  HomeNavigator: HomeNavigator
  PinCodeVerification:
    screen: => <PinCode status='check'/>
    path: 'pincode-check'
  PinCodeReset:
    screen: PinCodeReset
    path: 'pincode-reset'
  ChangePIN:
    screen: => <PinCode status='change'/>
    path: 'pincode-change'
    navigationOptions:
      gesturesEnabled: no

  # Should be the last
  Success:
    screen: Success
    path: 'success'



export default createAppContainer Platform.select
  ios: createAnimatedSwitchNavigator Navigator
  android: createSwitchNavigator Navigator
