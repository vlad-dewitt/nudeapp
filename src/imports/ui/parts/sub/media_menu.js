// Generated by CoffeeScript 2.4.1
var MediaMenu, Shape, _class,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };

MediaMenu = _class = class extends Component {
  constructor(props) {
    super(props);
    this.componentDidMount = this.componentDidMount.bind(this);
    this.componentDidUpdate = this.componentDidUpdate.bind(this);
    this.init = this.init.bind(this);
    this.delete = this.delete.bind(this);
    this.export = this.export.bind(this);
    this.share = this.share.bind(this);
    this.cancel = this.cancel.bind(this);
    this.render = this.render.bind(this);
    this.state = {
      config: {
        delete: false,
        export: false,
        share: false
      }
    };
  }

  componentDidMount() {
    boundMethodCheck(this, _class);
    return this.init();
  }

  componentDidUpdate(prevProps, prevState) {
    boundMethodCheck(this, _class);
    if (prevProps.app.select_mode !== this.props.app.select_mode) {
      return this.init();
    }
  }

  init() {
    var config;
    boundMethodCheck(this, _class);
    config = this.state.config;
    if (this.props.app.select_mode.selected_objects.length > 0) {
      config.delete = true;
      config.export = true;
    } else {
      config.delete = false;
      config.export = false;
    }
    if (this.props.app.select_mode.selected_objects.length === 1) {
      config.share = true;
    } else {
      config.share = false;
    }
    return this.setState({
      config: config
    });
  }

  delete() {
    var button_text, message, objects;
    boundMethodCheck(this, _class);
    objects = this.props.app.select_mode.selected_objects;
    message = objects.length < 2 ? "This action can't be undone" : `You're deleting ${objects.length} files. This action can't be undone`;
    button_text = objects.length < 2 ? 'Delete' : 'Delete All';
    return Alert.alert('Are you sure?', message, [
      {
        text: 'Cancel',
        style: 'cancel'
      },
      {
        text: button_text,
        onPress: () => {
          return API.global.removeMedia(objects,
      () => {
            return this.cancel();
          });
        }
      }
    ]);
  }

  export() {
    var objects;
    boundMethodCheck(this, _class);
    objects = this.props.app.select_mode.selected_objects;
    return Alert.alert(`Export ${objects.length} selected files?`, '', [
      {
        text: 'No',
        style: 'cancel'
      },
      {
        text: 'Yes',
        onPress: () => {
          return API.global.exportMedia(objects,
      () => {
            return this.cancel();
          });
        }
      }
    ]);
  }

  share() {
    boundMethodCheck(this, _class);
    return Sharing.shareAsync(this.props.app.select_mode.selected_objects[0].path).then(() => {
      return this.cancel();
    });
  }

  cancel() {
    boundMethodCheck(this, _class);
    return Ambry.call('setSelectMode', {
      available: true,
      active: false,
      selected_objects: []
    });
  }

  render() {
    boundMethodCheck(this, _class);
    return <View style={Shape.Menu}>
      <View style={{
        opacity: this.state.config.delete ? 1 : .4
      }}>
        <TouchableOpacity style={Shape.MenuIcon} activeOpacity={.5} onPress={this.state.config.delete ? this.delete : void 0}>
          <Image source={Assets.img.icons.trash_linear_icon_grey} style={{
        width: 18,
        height: 18,
        resizeMode: 'contain',
        marginBottom: 3
      }} />
          <Text style={[Typography.Light, Typography.Little, Typography.DarkGrey]}>Delete</Text>
        </TouchableOpacity>
      </View>
      <View style={{
        opacity: this.state.config.export ? 1 : .4
      }}>
        <TouchableOpacity style={Shape.MenuIcon} activeOpacity={.5} onPress={this.state.config.export ? this.export : void 0}>
          <Image source={Assets.img.icons.export_linear_icon_grey} style={{
        width: 18,
        height: 18,
        resizeMode: 'contain',
        marginBottom: 3
      }} />
          <Text style={[Typography.Light, Typography.Little, Typography.DarkGrey]}>Export</Text>
        </TouchableOpacity>
      </View>
      <View style={{
        opacity: this.state.config.share ? 1 : .4
      }}>
        <TouchableOpacity style={Shape.MenuIcon} activeOpacity={.5} onPress={this.state.config.share ? this.share : void 0}>
          <Image source={Assets.img.icons.share_linear_icon_grey} style={{
        width: 18,
        height: 18,
        resizeMode: 'contain',
        marginBottom: 3
      }} />
          <Text style={[Typography.Light, Typography.Little, Typography.DarkGrey]}>Share</Text>
        </TouchableOpacity>
      </View>
    </View>;
  }

};

Shape = StyleSheet.create({
  Menu: {
    width: '100%',
    height: 52,
    zIndex: 2,
    paddingHorizontal: Window.width / 6,
    borderBottomWidth: .5,
    borderBottomColor: '#AAAAAA',
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
    backgroundColor: 'white'
  },
  MenuIcon: {
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export default Hybrid(withNavigation(MediaMenu));

//# sourceMappingURL=media_menu.js.map