import Carousel from '../../tools/carousel'

import BGGradientAnimated from './sub/bg_gradient_animated'
import NudeLogo from './sub/nude_logo'
import InfoCard from './sub/info_card'



Cards = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      gradients: [
        ['#EDA9A9', '#FFD8C0']
        ['#688491', '#A1BAC4']
        ['#C5A897', '#9E7A6A']
      ]
      current_card: 0
      dots_anim:
        first:
          scaleX: new Animated.Value 1.5
          scaleY: new Animated.Value 1.5
          opacity: new Animated.Value 1
        second:
          scaleX: new Animated.Value 1
          scaleY: new Animated.Value 1
          opacity: new Animated.Value .6
        third:
          scaleX: new Animated.Value 1
          scaleY: new Animated.Value 1
          opacity: new Animated.Value .6



  changeCard: (page_number) =>
    @setActiveDot page_number

  setActiveDot: (page_number) =>
    if page_number is 0
      dot_number = 'first'
    else if page_number is 1
      dot_number = 'second'
    else
      dot_number = 'third'

    if @state.current_card is 0
      previous_number = 'first'
    else if @state.current_card is 1
      previous_number = 'second'
    else
      previous_number = 'third'
    Animated.spring(@state.dots_anim[previous_number].scaleX, { toValue: 1, speed: 10, useNativeDriver: yes }).start()
    Animated.spring(@state.dots_anim[previous_number].scaleY, { toValue: 1, speed: 10, useNativeDriver: yes }).start()
    Animated.timing(@state.dots_anim[previous_number].opacity, { toValue: .6, speed: 10, useNativeDriver: yes }).start()

    Animated.spring(@state.dots_anim[dot_number].scaleX, { toValue: 1.5, speed: 10, useNativeDriver: yes }).start()
    Animated.spring(@state.dots_anim[dot_number].scaleY, { toValue: 1.5, speed: 10, useNativeDriver: yes }).start()
    Animated.spring(@state.dots_anim[dot_number].opacity, { toValue: 1, speed: 10, useNativeDriver: yes }).start()

    @setState
      current_card: page_number

  next: =>
    @changeCard @state.current_card + 1

  skip: =>
    @props.navigation.navigate 'PinCodeCreate'



  render: =>
    <BGGradientAnimated colors={ @state.gradients[@state.current_card] }>
      <View style={ Shape.Box }>
        <View style={ Shape.LogoBox }>
          <NudeLogo/>
        </View>
        <Carousel pageStyle={ Shape.CardsSlider } width={ Dimensions.get('window').width } pageWidth={ Window.width - 60 } swipeThreshold={ .4 } sneak={ 0 } onPageChange={ @changeCard } currentPage={ @state.current_card }>
          <InfoCard title='AUTO NUDE DETECTION' info='Our software automatically detects your naughty photos.' picture={ Assets.img.pictures.auto_nude_detection } button_color='#CD9D9B' next={ @next } skip={ @skip }/>
          <InfoCard title='SECURE VAULT' info='Pictures are secured locally. So safe even our staff can’t access them!' picture={ Assets.img.pictures.secure_vault } button_color='#698491' next={ @next } skip={ @skip }/>
          <InfoCard title='BREAK-IN ALERT' info='Photos of intruders are taken and all break-in attempts are tracked.' picture={ Assets.img.pictures.breakin_alerts } button_color='#9E7866' next={ @skip } skip={ @skip } last={ yes }/>
        </Carousel>
        <View style={ Shape.Dots }>
          <Animated.View style={{ Shape.DotsItem..., transform: [{ scaleX: @state.dots_anim.first.scaleX }, { scaleY: @state.dots_anim.first.scaleY }], opacity: @state.dots_anim.first.opacity }}></Animated.View>
          <Animated.View style={{ Shape.DotsItem..., transform: [{ scaleX: @state.dots_anim.second.scaleX }, { scaleY: @state.dots_anim.second.scaleY }], opacity: @state.dots_anim.second.opacity }}></Animated.View>
          <Animated.View style={{ Shape.DotsItem..., transform: [{ scaleX: @state.dots_anim.third.scaleX }, { scaleY: @state.dots_anim.third.scaleY }], opacity: @state.dots_anim.third.opacity }}></Animated.View>
        </View>
      </View>
    </BGGradientAnimated>



Shape = StyleSheet.create
  Box:
    flex: 1
    alignItems: 'center'
    justifyContent: 'center'
    paddingVertical: 40

  LogoBox:
    width: 140
    height: 80
    alignItems: 'center'

  CardsSlider:
    height: '95%'
    backgroundColor: 'white'
    borderRadius: 16
    alignItems: 'center'
    justifyContent: 'center'

  Dots:
    flexDirection:'row'
    flexWrap:'wrap'
    width: '100%'
    height: 8
    alignItems: 'center'
    justifyContent: 'center'

  DotsItem:
    width: 8
    height: 8
    marginHorizontal: 5
    borderRadius: 8
    backgroundColor: 'white'



export default Hybrid Cards
