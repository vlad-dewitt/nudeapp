// Generated by CoffeeScript 2.4.1
var InfoCard, Shape, _class,
  boundMethodCheck = function(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new Error('Bound instance method accessed before binding'); } };

InfoCard = _class = class extends PureComponent {
  constructor(props) {
    super(props);
    this.render = this.render.bind(this);
  }

  render() {
    boundMethodCheck(this, _class);
    return <View style={Shape.Box}>
      <Text style={[Typography.Bold, Typography.Big, Typography.DarkGrey, Shape.Text, Shape.Title]}>{this.props.title}</Text>
      <Text style={[Typography.SemiBold, Typography.Small, Typography.Grey, Shape.Text]}>{this.props.info}</Text>
      <View style={Shape.ImageContainer}>
        <Image source={this.props.picture} style={{
        width: '100%',
        height: '100%',
        resizeMode: 'contain'
      }} />
      </View>
      <View style={Shape.ButtonsContainer}>
        <Theme.ButtonEmpty text={this.props.last ? 'GET STARTED' : ' NEXT '} color={this.props.button_color} onPress={this.props.next} />
        <Text style={[Typography.Small, Typography.Grey, Shape.Skip]} onPress={this.props.skip}>SKIP</Text>
      </View>
    </View>;
  }

};

Shape = StyleSheet.create({
  Box: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 30,
    paddingHorizontal: 30
  },
  Title: {
    marginBottom: 15
  },
  Text: {
    textAlign: 'center',
    marginBottom: 15
  },
  ImageContainer: {
    flex: 2,
    marginVertical: 20,
    width: Window.width - 90,
    height: Window.height / 2
  },
  ButtonsContainer: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  },
  Skip: {
    padding: 20,
    paddingBottom: 10
  }
});

export default Hybrid(InfoCard);

//# sourceMappingURL=info_card.js.map