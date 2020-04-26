import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm  = FirebaseMessaging();

  Future initialise()async{
    if(Platform.isIOS){
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(

      onMessage: (Map<String, dynamic > message) async {
      print(('onMessage: $message'));
    },
      onLaunch:  (Map<String, dynamic > message) async{
      print('onLaunch: $message');
      },

      onBackgroundMessage: (Map<String, dynamic> message) async{
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },

    );


  }
}
