import { StyleSheet } from 'react-native'



export default

  CircleButton: ({ text, onPress }) =>
    Shape = StyleSheet.create
      CircleButton:
        width: 86
        height: 86
        borderRadius: 43
        backgroundColor: 'white'
        alignItems: 'center'
        justifyContent: 'center'
      Text:
        color: '#E0BDBD'

    <TouchableOpacity style={ Shape.CircleButton } activeOpacity={ .6 } onPress={ onPress }>
      <Text style={{ Typography.Medium..., Shape.Text... }}>{ text }</Text>
    </TouchableOpacity>

  ButtonEmpty: ({ text, color, onPress }) =>
    Shape = StyleSheet.create
      ButtonEmpty:
        paddingVertical: 12
        paddingHorizontal: 40
        borderWidth: 2
        borderColor: color
        borderRadius: 30
        backgroundColor: 'transparent'
        alignItems: 'center'
        justifyContent: 'center'
      Text:
        color: color

    <TouchableOpacity style={ Shape.ButtonEmpty } activeOpacity={ .7 } onPress={ onPress }>
      <Text style={{ Typography.Medium..., Shape.Text... }}>{ text }</Text>
    </TouchableOpacity>

  ButtonWhite: ({ style, text, color, onPress }) =>
    Shape = StyleSheet.create
      ButtonWhite: {
        paddingVertical: 14
        paddingHorizontal: 40
        borderRadius: 30
        backgroundColor: 'white'
        alignItems: 'center'
        justifyContent: 'center'
        style...
      }
      Text:
        color: color

    <TouchableOpacity style={ Shape.ButtonWhite } activeOpacity={ .6 } onPress={ onPress }>
      <Text style={{ Typography.Medium..., Shape.Text... }}>{ text }</Text>
    </TouchableOpacity>
