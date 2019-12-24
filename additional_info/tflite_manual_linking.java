// 1. Open up android/app/src/main/java/[...]/MainApplication.java
//   Add import com.reactlibrary.TfliteReactNativePackage; to the imports at the top of the file
//   Add new TfliteReactNativePackage() to the list returned by the getPackages() method
// 2. Append the following lines to android/settings.gradle:
  include ':tflite-react-native'
  project(':tflite-react-native').projectDir = new File(rootProject.projectDir,   '../node_modules/tflite-react-native/android')
// 3. Insert the following lines inside the dependencies block in android/app/build.gradle:
  implementation project(':tflite-react-native')
