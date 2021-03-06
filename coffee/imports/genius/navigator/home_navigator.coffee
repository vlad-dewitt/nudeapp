import { createMaterialTopTabNavigator, createStackNavigator, createDrawerNavigator } from 'react-navigation'

import NudeLogo from '../../ui/parts/sub/nude_logo'
import Drawer from '../../ui/parts/drawer'

import BGGradient from '../../ui/parts/sub/bg_gradient'
import MenuButton from '../../ui/parts/sub/menu_button'
import HeaderLogo from '../../ui/parts/sub/header_logo'
import HeaderCustomBack from '../../ui/parts/sub/header_custom_back'
import ScanningPicture from '../../ui/parts/sub/scanning_picture'
import ViewIcon from '../../ui/parts/sub/view_icon'
import HeaderSelect from '../../ui/parts/sub/header_select'
import HeaderImageSelector from '../../ui/parts/sub/header_image_selector'
import MediaMenu from '../../ui/parts/sub/media_menu'

import Home from '../../ui/parts/home'
import MediaViewer from '../../ui/parts/media_viewer'
import ImageSelector from '../../ui/parts/image_selector'
import Settings from '../../ui/parts/settings'
import AccountInfo from '../../ui/parts/account_info'
import PinCode from '../../ui/parts/pin_code'
import BreakInAlerts from '../../ui/parts/break_in_alerts'
import Help from '../../ui/parts/help'
import HelpPage from '../../ui/parts/help_page'

import Success from '../../ui/parts/success'
import LockedScreen from '../../ui/parts/locked_screen'



HomeWithTabs = createMaterialTopTabNavigator
  GridView:
    screen: => <Home key='1' view='grid'/>
    navigationOptions: ({ screenProps: props }) =>
      if props.app.select_mode.active
        tabBarIcon: ({ focused }) => <ViewIcon icon={ Assets.img.icons.grid_view } focused={ focused }/>
        tabBarComponent: MediaMenu
      else
        tabBarIcon: ({ focused }) => <ViewIcon icon={ Assets.img.icons.grid_view } focused={ focused }/>
  ListView:
    screen: => <Home key='2' view='list'/>
    navigationOptions:
      tabBarIcon: ({ focused }) => <ViewIcon icon={ Assets.img.icons.list_view } focused={ focused }/>
  GalleryView:
    screen: => <Home key='3' view='gallery'/>
    navigationOptions:
      tabBarIcon: ({ focused }) => <ViewIcon icon={ Assets.img.icons.gallery_view } focused={ focused }/>
  VideoView:
    screen: => <Home key='4' view='video'/>
    navigationOptions:
      tabBarIcon: ({ focused }) => <ViewIcon icon={ Assets.img.icons.video_view } focused={ focused }/>
,
  initialRouteName: 'GridView'
  backBehavior: 'none'
  swipeEnabled: no
  animationEnabled: no
  optimizationsEnabled: yes
  lazy: yes
  tabBarOptions:
    showIcon: yes
    showLabel: no
    indicatorStyle:
      width: 0
      height: 0
    style:
      height: 52
      paddingHorizontal: 16
      backgroundColor: 'white'



HomeNavigator = createStackNavigator
  Home:
    screen: HomeWithTabs
    path: 'home'
    navigationOptions: ({ screenProps: props }) =>
      gesturesEnabled: no
      headerLeft: MenuButton
      headerRight:
        if props.app.scanning.active
          <ScanningPicture/>
        else if props.app.modal_screen.type is 'modal_scanning' or props.app.modal_screen.type is 'modal_plus'
          <ScanningPicture untouchable={ yes }/>
        else
          <HeaderSelect/>
  MediaViewer:
    screen: MediaViewer
    path: 'media-viewer'
    navigationOptions: ({ screenProps: props }) =>
      gesturesEnabled: no
      headerTransparent: yes
      headerBackground:
        if not props.app.media_viewer.focus
          <View style={{ width: '100%', height: '100%', backgroundColor: 'rgba(0,0,0,.2)' }}/>
        else
          null
      headerLeft: if props.app.media_viewer.focus then null
      headerTitle: null
  ImageSelector:
    screen: ImageSelector
    path: 'image-selector'
    navigationOptions:
      gesturesEnabled: no
      headerRight: <HeaderImageSelector/>
  Settings:
    screen: Settings
    path: 'settings'
    navigationOptions:
      gesturesEnabled: no
      headerTransparent: yes
      headerBackground: null
      headerTitle: <Text style={[Typography.Medium, Typography.Bigger]}>Settings</Text>
      headerLeft: <HeaderCustomBack action='goHome'/>
      headerStyle:
        zIndex: 99999
        width: Window.width
  AccountInfo:
    screen: AccountInfo
    path: 'account-info'
    navigationOptions:
      headerTitle: <Text style={[Typography.Medium, Typography.Bigger]}>Account</Text>
  ChangePIN:
    screen: => <PinCode status='change'/>
    path: 'pincode-change'
    navigationOptions:
      gesturesEnabled: no
      headerTransparent: yes
      headerBackground: null
      headerTitle: null
  BreakInAlerts:
    screen: BreakInAlerts
    path: 'break-in-alerts'
    navigationOptions:
      gesturesEnabled: no
      headerTitle: <Text style={[Typography.Medium, Typography.Bigger]}>Break-in Alerts</Text>
      headerLeft: <HeaderCustomBack action='goHome'/>
  Help:
    screen: Help
    path: 'help'
    navigationOptions:
      gesturesEnabled: no
      headerTitle: <Text style={[Typography.Medium, Typography.Bigger]}>Help</Text>
      headerLeft: <HeaderCustomBack action='goHome'/>
  HelpPage:
    screen: HelpPage
    path: 'help-page'
    navigationOptions:
      headerTitle: <Text style={[Typography.Medium, Typography.Bigger]}>Help</Text>


  # Should be the last
  Success:
    screen: Success
    path: 'success'
    navigationOptions:
      gesturesEnabled: no
      header: null
  LockedScreen:
    screen: LockedScreen
    path: 'locked-screen'
    navigationOptions:
      header: null
,
  headerMode: 'screen'
  headerLayoutPreset: 'center'
  defaultNavigationOptions:
    headerStyle:
      height: 60
      elevation: 0
      borderBottomWidth: 0
      zIndex: 9999
    headerTitle: HeaderLogo
    headerBackground: <BGGradient colors={['#EDA9A9', '#FFD8C0']} style={{ height: '100%' }}/>
    headerBackImage: <Image source={ Assets.img.icons.back_arrow } style={{ width: 18, height: 18, resizeMode: 'contain' }}/>
    headerBackTitle: null
    headerLeftContainerStyle:
      justifyContent: 'flex-start'
      textAlign: 'left'
      paddingLeft: 16
    headerRightContainerStyle:
      paddingRight: 16




export default createDrawerNavigator
  Home: HomeNavigator
,
  initialRouteName: 'Home'
  drawerWidth: Window.width - 60
  contentComponent: Drawer
