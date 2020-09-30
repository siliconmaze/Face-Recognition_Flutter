# I am going to see if I can get this working on Visual Studio Code

30 September 2020

https://flutter.dev/docs/development/tools/vs-code
https://flutter.dev/docs/get-started/install/macos

From repo:

/Users/stever/local-repos/github/Face-Recognition_Flutter


mkdir ~/sdk
cd ~/dsk
curl -O -J -L https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.20.4-stable.zip
unzip ./flutter_macos_1.20.4-stable.zip

Add flutter to my path

see source set-env-imac.sh

I then installed VSCode Plugin: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter


I then used command pallete

Flutter: Get Packages

I then plugged in my Device, and ran Debug

the message is Running Gradle Task 'assembleDebug', there is a nice organge bar at bottom of Visual Studi Code.

My Device is known as SM N976B (android0arm64)

it took a few minutes to build!

It worked first time and when I uploaded an image using the image picker/camera button I loaded a picture of myself from google-drive , and the app was able to identify my face in the photo. Now I am not trying to do anything other than see this code working, I am now going to make some code adjustments, and see it can display data points.

====

the application is using `FirebaseVisionFaceDetector` i am going to see if I can chnage the 
https://firebase.google.com/docs/reference/android/com/google/firebase/ml/vision/common/FirebaseVisionImage
https://firebase.google.com/docs/reference/android/com/google/firebase/ml/vision/FirebaseVision
https://firebase.google.com/docs/reference/android/com/google/firebase/ml/vision/face/FirebaseVisionFaceDetector

FirebaseVisionFaceDetector is deprecated, i will look at this later as part o using Bundles ML kit etc.

I changed from `mode: FaceDetectorMode.fast, enableLandmarks: true` to

`mode: FaceDetectorMode.fast, enableLandmarks: true, enableClassification: true, enableContours: true, enableTracking: true`

No Face Contour model is bundled. Please check your app setup to include firebase-ml-vision-face-model dependency.

I ran Flutter: Get Pckages and it updated .packages with 
`firebase_ml_vision:file:///Users/stever/sdk/flutter/.pub-cache/hosted/pub.dartlang.org/firebase_ml_vision-0.9.3+5/lib/`

Exception has occurred.
PlatformException (PlatformException(faceDetectorError, No Face Contour model is bundled. Please check your app setup to include firebase-ml-vision-face-model dependency., null))

https://firebase.google.com/docs/ml-kit/android/detect-faces


so lets look at manifests?

Optional but recommended: Configure your app to automatically download the ML model to the device after your app is installed from the Play Store.

To do so, add the following declaration to your app's AndroidManifest.xml file:

<application ...>
  ...
  <meta-data
      android:name="com.google.firebase.ml.vision.DEPENDENCIES"
      android:value="face" />
  <!-- To use multiple models: android:value="face,model2,model3" -->
</application>

Manifest was OK!

I needed to update the pubspec.yml


If you're using the on-device Face Contour Detection, include the latest matching ML Kit: Face Detection Model dependency in your app-level build.gradle file.

https://pub.dev/packages/firebase_ml_vision

android {
    dependencies {
        // ...

        api 'com.google.firebase:firebase-ml-vision-face-model:17.0.2'
    }
}

I got my ideas from :




https://codelabs.developers.google.com/codelabs/flutter-firebase/#3

Using this intelligence I update the Android App's `build.gradle` dependencie section from 

```s
dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'androidx.test:runner:1.1.1'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.1.1'
}
```

to 
```s
dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    testImplementation 'junit:junit:4.12'
    androidTestImplementation 'androidx.test:runner:1.1.1'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.1.1'
    api 'com.google.firebase:firebase-ml-vision-face-model:17.0.2'
}
```
I can now see that I have a confluence detection of:

I still have a question as how I can show the contours? 

```s
I/flutter (10788): leftEyeOpenProbability=0.9956856369972229
```

SUCCESS, I have made an alteration to the code.


Note: https://pub.dev/documentation/firebase_ml_vision/latest/

Machine Learning Vision for Firebase

A Flutter plugin to use the capabilities of Firebase ML, which includes all of Firebase's cloud-based ML features, and ML Kit, a standalone library for on-device ML, which can be used with or without Firebase.

I guess for me, I need to take: `https://github.com/flutter/plugins/tree/master/packages/camera` abd work out how I can use the flutter camera plugin to get the stream, and match to the static image.

For me I have learned that at the moment Google is limited in Facial recognition. they do not yet provide services that allow you to recognise a face from a pre captures image of that same face ie compare facial images with live camera etc.

https://pusher.com/tutorials/facial-recognition-react-native might help with some ideas?

https://www.altexsoft.com/blog/datascience/comparing-machine-learning-as-a-service-amazon-microsoft-azure-google-cloud-ai-ibm-watson/
scroll down to see what is on offer my Azur for fiacial is vs table.

Person face identificsion (person face recog)  is provied by AWS and Azure, not GCP,so it looks I will need to resort to Azure me thinks?









