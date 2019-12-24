// 1. In Android Studio (1.0 & above), right-click on the app folder and go to New > Folder > Assets Folder. Click Finish to create the assets folder.
// 2. Place the model and label files at app/src/main/assets.
// 3. In android/app/build.gradle, add the following setting in android block.

aaptOptions {
    noCompress 'tflite'
}
