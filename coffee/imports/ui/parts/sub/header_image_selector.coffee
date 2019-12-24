HeaderImageSelector = class extends Component
  constructor: (props) ->
    super props
    @state =
      config: @props.app.image_selector



  shouldComponentUpdate: (nextProps, nextState) =>
    if @props.app.image_selector isnt nextProps.app.image_selector
      yes
    else if @state.config isnt nextState.config
      yes
    else
      no

  componentDidUpdate: =>
    @setState
      config: @props.app.image_selector



  press: =>
    if @state.config.active
      objects = []
      @state.config.objects.map (item) =>
        item.type = if item.mediaType is 'photo' then 'image' else 'video'
        objects.push item
      API.global.addMedia { import: yes }, objects
      Ambry.call 'setImageSelector',
        active: no
        objects: []
      @props.navigation.goBack()



  render: =>
    if @props.app.image_selector.objects.length > 0
      <TouchableOpacity onPress={ @press }>
        <Text style={ Typography.Small }>Done</Text>
      </TouchableOpacity>
    else
      null



export default Hybrid withNavigation HeaderImageSelector
