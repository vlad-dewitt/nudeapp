ImageSelector = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      objects: []
      selected: {}
      after: null
      has_next_page: yes



  componentDidMount: =>
    @getPhotos()

  componentDidUpdate: (prevProps, prevState) =>
    if @state.selected isnt prevState.selected
      selectedPhotos = @state.objects.filter (item, index) =>
        @state.selected[index]

      Ambry.call 'setImageSelector',
        active: yes
        objects: selectedPhotos

  componentWillUnmount: =>
    Ambry.call 'setImageSelector',
      active: no
      objects: []



  getPhotos: =>
    params =
      first: 120
      mediaType: ['photo', 'video']
      sortBy: ['creationTime']

    if @state.after
      params.after = @state.after

    if not @state.has_next_page
      no
    else
      MediaLibrary.getAssetsAsync params
      .then (res) =>
        @processImages res


  processImages: (images) =>
    if @state.after is images.endCursor
      return
    else
      @setState
        objects: [@state.objects..., images.assets...]
        after: images.endCursor
        has_next_page: images.hasNextPage

  selectImage: (index) =>
    newSelected = { @state.selected... }

    if newSelected[index]
      delete newSelected[index]
    else
      newSelected[index] = yes

    if not newSelected
      newSelected = {}

    @setState
      selected: newSelected



  render: =>
    <View style={ Shape.Box }>
      <FlatList data={ @state.objects } numColumns={ 4 } initialNumToRender={ 40 } onEndReachedThreshold={ .5 } renderItem={ ({ item, index }) =>
        <ImageTile object={ item } index={ index } selected={ if @state.selected[index] then yes else no } selectImage={ @selectImage }/>
      } keyExtractor={ (path, index) => index } onEndReached={ @getPhotos } extraData={ @state.selected }/>
    </View>



ImageTile = class extends PureComponent
  constructor: (props) ->
    super props

  render: =>
    if not @props.object
      null
    else
      <TouchableOpacity activeOpacity={ .7 } onPress={ @props.selectImage.bind this, @props.index }>
        <View>
          <Image style={{ width: Dimensions.get('window').width / 4, height: Dimensions.get('window').width / 4 }} source={{ uri: @props.object.uri }}/>
          {
            if @props.object.mediaType is 'video'
              <View style={{ position: 'absolute', zIndex: 10, width: 24, height: 24, bottom: 4, right: 6, alignItems: 'center', justifyContent: 'center' }}>
                <Image source={ Assets.img.icons.video_linear_icon } style={{ width: '100%', height: '100%', resizeMode: 'contain' }}/>
              </View>
          }
          {
            if @props.selected
              <View style={{ position: 'absolute', zIndex: 10, top: 0, left: 0, bottom: 0, right: 0, backgroundColor: 'rgba(250, 217, 217, .8)', alignItems: 'center', justifyContent: 'center' }}>
                <Image source={ Assets.img.icons.selected } style={{ width: 64, height: 64, resizeMode: 'contain' }}/>
              </View>
          }
        </View>
      </TouchableOpacity>



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'



export default Hybrid withNavigation ImageSelector
