BGGradient = class extends PureComponent
  constructor: (props) ->
    super props



  render: =>
    <LinearGradient pointerEvents='box-none' colors={ @props.colors } style={ if @props.style then [Shape.BGGradient, @props.style] else Shape.BGGradient } start={ if @props.start then @props.start else [1, 0] } end={ if @props.end then @props.end else [0, 1] }>
      {
        @props.children
      }
    </LinearGradient>



Shape = StyleSheet.create
  BGGradient:
    width: Window.width
    height: Window.height



export default Hybrid BGGradient
