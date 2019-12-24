Help = class extends PureComponent
  constructor: (props) ->
    super props
    @state =
      data: [
        {
          title: 'FAQ'
          pages: [
            { title: 'What is nude?', content: "Nude is a photo vault app that automatically scans and secures all of the naughty photos on your phone.\n\nIn addition, you may also use Nude as a digital vault to secure your private videos and files." }
            { title: 'What is nude detection?', content: "Our proprietary nude detection software automatically scans through your #{ if Platform.OS is 'ios' then 'camera roll' else 'gallery' } and locks your naughty photos with the Nude app." }
            { title: 'So how does nude detection work?', content: "Great question!\n\nHere’s how the magic happens: the application sends the encrypted and anonymized data of your photos to our secure server where we run our proprietary software.\n\nThe software then processes the data and returns a confidence score that reflects the detection result.\nAll data are immediately erased after processing to protect your privacy, and only the confidence score is used for the purpose of identifying naughty photos." }
            { title: 'Are my photos secure?', content: "Absolutely!\n\nIn fact, unlike other photo vault apps, we do not store any of your photos in the cloud.\n\nEverything is stored locally and encrypted on your phone. You are in control every step of the way." }
            { title: 'How do I contact customer support?', content: "For all your questions and inquiries, please visit:\n\nhttps://thenudeapp.com/contact-us" }
          ]
        }
        {
          title: 'Support'
          pages: [
            { title: 'Terms & Conditions', url: "https://thenudeapp.com/privacy-policy" }
            { title: 'Privacy Policy', url: "https://thenudeapp.com/terms-of-service" }
            { title: 'Contact Support', url: "https://thenudeapp.com/contact-us" }
          ]
        }
      ]



  componentDidMount: =>
    @props.navigation.closeDrawer()



  openPage: (page) =>
    if page.url
      Linking.openURL page.url
    else
      @props.navigation.navigate
        routeName: 'HelpPage'
        params:
          help_page_content: page



  render: =>
    <View style={ Shape.Box }>
      {
        @state.data.map (section, num) =>
          <View key={ num } style={ Shape.Section }>
            <Text style={[Typography.Medium, Typography.Regular, Typography.Grey, Shape.SectionTitle]}>{ section.title }</Text>
            {
              section.pages.map (page, num) =>
                <TouchableOpacity key={ num } style={ Shape.Page } activeOpacity={ .5 } onPress={ @openPage.bind this, page }>
                  <Text style={[Typography.Medium, Typography.Regular, Typography.Grey]}>{ page.title }</Text>
                </TouchableOpacity>
            }
          </View>
      }
      <Text style={[Typography.Little, Typography.Regular, Typography.Grey, Shape.NudeVersion]}>{ "Nude v#{ Constants.nativeAppVersion }" }</Text>
    </View>



Shape = StyleSheet.create
  Box:
    flex: 1
    width: '100%'
    backgroundColor: '#F5F6F9'

  Section:
    marginVertical: 15
    width: '100%'

  SectionTitle:
    marginHorizontal: 24
    marginBottom: 10

  Page:
    width: Window.width
    paddingVertical: 16
    paddingHorizontal: 24
    borderBottomWidth: 1
    borderColor: '#DAD9DD'
    backgroundColor: 'white'
    textAlign: 'left'
    justifyContent: 'center'

  NudeVersion:
    position: 'absolute'
    width: Window.width
    bottom: 20
    alignItems: 'center'
    textAlign: 'center'
    justifyContent: 'center'



export default Hybrid Help
