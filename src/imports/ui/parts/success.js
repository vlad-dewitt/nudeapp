// Generated by CoffeeScript 2.4.1
var Shape, Success, _class,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };

Success = _class = class extends PureComponent {
  constructor(props) {
    super(props);
    this.componentDidMount = this.componentDidMount.bind(this);
    this.render = this.render.bind(this);
  }

  componentDidMount() {
    boundMethodCheck(this, _class);
    return setTimeout(() => {
      var next_route;
      next_route = this.props.navigation.getParam('next_route');
      if (next_route) {
        return this.props.navigation.navigate(next_route);
      } else {
        return this.props.navigation.navigate('Home');
      }
    }, 2000);
  }

  render() {
    boundMethodCheck(this, _class);
    return <View style={Shape.Box}>
      <Image source={Assets.img.icons.success} style={{
        width: 106,
        height: 106,
        resizeMode: 'contain'
      }} />
      <Text style={[Typography.Medium, Typography.Big, Typography.Grey, Shape.Text]}>Success</Text>
    </View>;
  }

};

Shape = StyleSheet.create({
  Box: {
    flex: 1,
    width: '100%',
    backgroundColor: '#F5F6F9',
    alignItems: 'center',
    justifyContent: 'center'
  },
  Text: {
    marginTop: 20,
    fontSize: 28,
    letterSpacing: 1
  }
});

export default Hybrid(Success);

//# sourceMappingURL=success.js.map
