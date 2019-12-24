import React, { Component, PureComponent } from 'react'
import { createContext } from 'react'

import _ from 'underscore'

import moment from 'moment'

import { AppState, AsyncStorage, CameraRoll, NativeModules, Platform, BackHandler, Share, Dimensions, StyleSheet, StatusBar, Alert, Linking, Animated, Text, View, Image, ImageBackground, TouchableOpacity, TouchableHighlight, Button, TextInput, Switch, ScrollView, FlatList, Shadow } from 'react-native'

import NetInfo from '@react-native-community/netinfo'

import { withNavigation, withNavigationFocus } from 'react-navigation'

import Constants from 'expo-constants'
import { SplashScreen, ScreenOrientation } from 'expo'
import * as Permissions from 'expo-permissions'
import * as Font from 'expo-font'
import { LinearGradient } from 'expo-linear-gradient'
import * as LocalAuth from 'expo-local-authentication'
import * as Sharing from 'expo-sharing'
import { Video } from 'expo-av'
import * as ImagePicker from 'expo-image-picker'
import * as ImageManipulator from 'expo-image-manipulator'
import * as FileSystem from 'expo-file-system'
import * as MediaLibrary from 'expo-media-library'
import { Camera } from 'expo-camera'

import { State, PinchGestureHandler, LongPressGestureHandler } from 'react-native-gesture-handler'

import { Hybrid, API, Ambry } from '../imports/genius/hybrid'

import Assets from './assets'
import Typography from '../imports/ui/shape/typography'
import Theme from '../imports/ui/shape/theme'

import random from 'randomatic'



@React = React
@Component = Component
@PureComponent = PureComponent
@createContext = createContext

@_ = _

@moment = moment

@AppState = AppState
@AsyncStorage = AsyncStorage
@CameraRoll = CameraRoll
@NativeModules = NativeModules
@Platform = Platform
@BackHandler = BackHandler
@Share = Share
@Dimensions = Dimensions
@StyleSheet = StyleSheet
@StatusBar = StatusBar
@Alert = Alert
@Linking = Linking
@Animated = Animated
@Text = Text
@View = View
@Image = Image
@ImageBackground = ImageBackground
@TouchableOpacity = TouchableOpacity
@TouchableHighlight = TouchableHighlight
@Button = Button
@TextInput = TextInput
@Switch = Switch
@ScrollView = ScrollView
@FlatList = FlatList
@Shadow = Shadow

@NetInfo = NetInfo

@withNavigation = withNavigation
@withNavigationFocus = withNavigationFocus

@Constants = Constants
@SplashScreen = SplashScreen
@ScreenOrientation = ScreenOrientation
@Permissions = Permissions
@Font = Font
@LinearGradient = LinearGradient
@LocalAuth = LocalAuth
@Sharing = Sharing
@Video = Video
@ImagePicker = ImagePicker
@ImageManipulator = ImageManipulator
@FileSystem = FileSystem
@MediaLibrary = MediaLibrary
@Camera = Camera

@GestureState = State
@PinchGestureHandler = PinchGestureHandler
@LongPressGestureHandler = LongPressGestureHandler

@Hybrid = Hybrid
@API = API
@Ambry = Ambry

@Assets = Assets
@Typography = Typography
@Theme = Theme

@random = random

@WebsiteAddress = 'https://thenudeapp.com'

@Window = Dimensions.get 'window'
