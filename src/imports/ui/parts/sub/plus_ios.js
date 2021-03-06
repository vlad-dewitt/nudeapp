// Generated by CoffeeScript 2.4.1
var PlusIOS, Shape, _class,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };

import BGGradient from './bg_gradient';

PlusIOS = _class = class extends PureComponent {
  constructor(props) {
    super(props);
    this.componentDidMount = this.componentDidMount.bind(this);
    this.componentDidUpdate = this.componentDidUpdate.bind(this);
    this.expand = this.expand.bind(this);
    this.collapse = this.collapse.bind(this);
    this.render = this.render.bind(this);
    this.state = {
      plus_rotate: new Animated.Value(0),
      plus_icon_scale: new Animated.Value(1),
      white_box_width: new Animated.Value(72),
      white_box_margin: new Animated.Value((Window.width - 72) / 2),
      icons_scale: new Animated.Value(0),
      icons_opacity: new Animated.Value(0)
    };
  }

  componentDidMount() {
    boundMethodCheck(this, _class);
    Animated.spring(this.state.icons_scale, {
      toValue: 0,
      speed: 400,
      useNativeDriver: true
    }).start();
    return Animated.spring(this.state.icons_opacity, {
      toValue: 0,
      speed: 400,
      useNativeDriver: true
    }).start();
  }

  componentDidUpdate(prevProps) {
    boundMethodCheck(this, _class);
    if (prevProps.state !== this.props.state) {
      if (this.props.state === true) {
        return this.expand();
      } else {
        return this.collapse();
      }
    }
  }

  expand() {
    boundMethodCheck(this, _class);
    Animated.spring(this.state.plus_rotate, {
      toValue: 1,
      speed: 40,
      useNativeDriver: true
    }).start();
    Animated.spring(this.state.plus_icon_scale, {
      toValue: .7,
      speed: 60,
      useNativeDriver: true
    }).start();
    Animated.spring(this.state.white_box_width, {
      toValue: 260,
      speed: 30
    }).start();
    Animated.spring(this.state.white_box_margin, {
      toValue: (Window.width - 260) / 2,
      speed: 30
    }).start();
    Animated.spring(this.state.icons_opacity, {
      toValue: 1,
      speed: 40,
      useNativeDriver: true,
      delay: 50
    }).start();
    return Animated.spring(this.state.icons_scale, {
      toValue: 1,
      speed: 40,
      useNativeDriver: true,
      delay: 50
    }).start();
  }

  collapse() {
    boundMethodCheck(this, _class);
    Animated.spring(this.state.plus_rotate, {
      toValue: 0,
      speed: 60,
      useNativeDriver: true
    }).start();
    Animated.spring(this.state.plus_icon_scale, {
      toValue: 1,
      speed: 60,
      useNativeDriver: true
    }).start();
    Animated.spring(this.state.icons_opacity, {
      toValue: 0,
      speed: 40,
      useNativeDriver: true
    }).start();
    Animated.spring(this.state.icons_scale, {
      toValue: 0,
      speed: 40,
      useNativeDriver: true
    }).start();
    Animated.spring(this.state.white_box_width, {
      toValue: 72,
      speed: 40,
      delay: 80
    }).start();
    return Animated.spring(this.state.white_box_margin, {
      toValue: (Window.width - 72) / 2,
      speed: 40,
      delay: 80
    }).start();
  }

  render() {
    var plus_icon_rotation;
    boundMethodCheck(this, _class);
    plus_icon_rotation = this.state.plus_rotate.interpolate({
      inputRange: [0, 1],
      outputRange: ['0deg', '45deg']
    });
    return <View style={Shape.Plus}>
      <TouchableOpacity style={Shape.PlusButton} activeOpacity={.5} onPress={this.props.onPress.bind(this, this.props.state === true ? false : true)}>
        <BGGradient colors={['#FD8D68', '#F9799A', '#F97072']} style={{
        width: '100%',
        height: '100%',
        alignItems: 'center',
        justifyContent: 'center'
      }}>
          <Animated.View style={{
        ...Shape.PlusIcon,
        transform: [
          {
            rotate: plus_icon_rotation
          },
          {
            scaleX: this.state.plus_icon_scale
          },
          {
            scaleY: this.state.plus_icon_scale
          }
        ]
      }}>
            <Image source={Assets.img.icons.plus} style={{
        width: '100%',
        height: '100%',
        resizeMode: 'contain'
      }} />
          </Animated.View>
        </BGGradient>
      </TouchableOpacity>
      <Animated.View style={{
        ...Shape.WhiteBox,
        width: this.state.white_box_width,
        marginHorizontal: this.state.white_box_margin
      }}>
        <Animated.View style={{
        opacity: this.state.icons_opacity,
        transform: [
          {
            scaleX: this.state.icons_scale
          },
          {
            scaleY: this.state.icons_scale
          }
        ]
      }}>
          <TouchableOpacity style={{
        ...Shape.WhiteBoxIcon,
        marginLeft: 34
      }} activeOpacity={.5} onPress={this.props.mediaAction}>
            <Image source={Assets.img.icons.add_media} style={{
        width: 36,
        height: 29,
        resizeMode: 'contain',
        marginBottom: 2
      }} />
            <Text style={[Typography.Medium, Typography.Little, Typography.DarkGrey]}>Add</Text>
          </TouchableOpacity>
        </Animated.View>
        <Animated.View style={{
        opacity: this.state.icons_opacity,
        transform: [
          {
            scaleX: this.state.icons_scale
          },
          {
            scaleY: this.state.icons_scale
          }
        ]
      }}>
          <TouchableOpacity style={{
        ...Shape.WhiteBoxIcon,
        marginRight: 30
      }} activeOpacity={.5} onPress={this.props.cameraAction}>
            <Image source={Assets.img.icons.camera} style={{
        width: 28,
        height: 28,
        resizeMode: 'contain',
        marginBottom: 3
      }} />
            <Text style={[Typography.Medium, Typography.Little, Typography.DarkGrey]}>Camera</Text>
          </TouchableOpacity>
        </Animated.View>
      </Animated.View>
    </View>;
  }

};

Shape = StyleSheet.create({
  Plus: {
    position: 'absolute',
    width: '100%',
    height: '100%',
    bottom: 0
  },
  PlusButton: {
    position: 'absolute',
    zIndex: 2,
    width: 72,
    height: 72,
    bottom: 15,
    borderRadius: 36,
    alignItems: 'center',
    justifyContent: 'center',
    overflow: 'hidden',
    marginHorizontal: (Window.width - 72) / 2
  },
  PlusIcon: {
    width: 26,
    height: 26,
    alignItems: 'center',
    justifyContent: 'center'
  },
  WhiteBox: {
    position: 'absolute',
    zIndex: 1,
    height: 72,
    bottom: 15,
    borderRadius: 36,
    alignItems: 'center',
    flexDirection: 'row',
    justifyContent: 'space-between',
    overflow: 'hidden',
    backgroundColor: '#EEEEEE'
  },
  WhiteBoxIcon: {
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export default Hybrid(withNavigation(PlusIOS));

//# sourceMappingURL=plus_ios.js.map
