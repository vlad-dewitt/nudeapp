// Generated by CoffeeScript 2.4.1
var Shape, ViewIcon, _class,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };

ViewIcon = _class = class extends PureComponent {
  constructor(props) {
    super(props);
    this.render = this.render.bind(this);
  }

  render() {
    boundMethodCheck(this, _class);
    return <View style={{
        ...Shape.ViewIcon,
        opacity: this.props.focused ? 1 : .4
      }}>
      <Image source={this.props.icon} style={{
        width: '100%',
        height: '100%',
        resizeMode: 'contain'
      }} />
    </View>;
  }

};

Shape = StyleSheet.create({
  ViewIcon: {
    alignItems: 'center',
    justifyContent: 'center',
    width: 20,
    height: 20
  }
});

export default Hybrid(ViewIcon);

//# sourceMappingURL=view_icon.js.map
