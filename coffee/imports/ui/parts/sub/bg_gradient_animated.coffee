GradientHelper = class extends Component
  constructor: (props) ->
    super props



  render: =>
    <LinearGradient colors={[@props.color1, @props.color2]} style={ Shape.BGGradientAnimated } start={[1, 0]} end={[0, 1]}>
      {
        @props.children
      }
    </LinearGradient>



AnimatedGradientHelper = Animated.createAnimatedComponent GradientHelper



BGGradientAnimated = class extends Component
  constructor: (props) ->
    super props
    @state =
      prevColors: @props.colors
      colors: @props.colors
      tweener: new Animated.Value 0



  shouldComponentUpdate: (nextProps, nextState) =>
    if @state isnt nextState
      yes
    else if @props.colors[0] isnt nextProps.colors[0]
      yes
    else
      no

  componentDidUpdate: (prevProps, prevState) =>
    Animated.spring(@state.tweener, { toValue: 1, speed: 1, useNativeDriver: yes }).start()
    if prevProps.colors[0] isnt @props.colors[0]
      @setState
        prevColors: @state.colors
        colors: @props.colors
        tweener: new Animated.Value 0



  render: =>
    color1Interp = @state.tweener.interpolate
      inputRange: [0, 1]
      outputRange: [@state.prevColors[0], @state.colors[0]]
    color2Interp = @state.tweener.interpolate
      inputRange: [0, 1]
      outputRange: [@state.prevColors[1], @state.colors[1]]

    <AnimatedGradientHelper color1={ color1Interp } color2={ color2Interp }>
      {
        @props.children
      }
    </AnimatedGradientHelper>



Shape = StyleSheet.create
  BGGradientAnimated:
    width: Window.width
    height: Window.height



export default Hybrid BGGradientAnimated
