HeaderSelect = class extends Component
  constructor: (props) ->
    super props
    @state =
      config: @props.app.select_mode



  shouldComponentUpdate: (nextProps, nextState) =>
    if @props.app.select_mode isnt nextProps.app.select_mode
      yes
    else if @state.config isnt nextState.config
      yes
    else if @props.app.data.media.length isnt nextProps.app.data.media.length
      yes
    else
      no

  componentDidUpdate: =>
    @setState
      config: @props.app.select_mode



  press: =>
    if @state.config.active
      Ambry.call 'setSelectMode',
        available: yes
        active: no
        selected_objects: []
    else
      Ambry.call 'setSelectMode',
        available: yes
        active: yes
        selected_objects: []



  render: =>
    if @props.app.data.media.length > 0 and @props.app.select_mode.available
      <TouchableOpacity onPress={ @press }>
        <Text style={ Typography.Small }>{ if @state.config.active then 'Cancel' else 'Select' }</Text>
      </TouchableOpacity>
    else
      null



export default Hybrid withNavigation HeaderSelect
