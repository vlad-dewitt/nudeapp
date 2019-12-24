import Tflite from 'tflite-react-native'

# import { useScreens } from 'react-native-screens'
# useScreens()



@TFLite = new Tflite()

TFLite.loadModel
  model: 'open_nsfw.tflite'
  labels: 'open_nsfw.txt'
  numThreads: 1
