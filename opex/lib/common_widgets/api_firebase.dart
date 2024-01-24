import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FireBaseApi {

  final _firebaseMessaging=FirebaseMessaging.instance;

  Future<void>initNotification()async{

    await _firebaseMessaging.requestPermission( alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    final fcmToken=await _firebaseMessaging.getToken();
    print("FCM TOKENE.....$fcmToken......");


    // BlocProvider.of<EmployeeBloc>(context)
    //     .add(PostImageDiscountEvent(cropImage!));


  }

}