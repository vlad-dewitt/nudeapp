// Generated by CoffeeScript 2.4.1
import Tflite from 'tflite-react-native';

// import { useScreens } from 'react-native-screens'
// useScreens()
this.TFLite = new Tflite();

TFLite.loadModel({
  model: 'open_nsfw.tflite',
  labels: 'open_nsfw.txt',
  numThreads: 1
});

//# sourceMappingURL=initial_script.js.map
