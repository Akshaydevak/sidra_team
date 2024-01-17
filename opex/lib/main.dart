import 'package:cluster/presentation/authentication/authentication.dart';
import 'package:cluster/presentation/authentication/bloc/bloc/auth_bloc.dart';
import 'package:cluster/presentation/base/splash.dart';
import 'package:cluster/presentation/comunication_module/scoketconnection.dart';
import 'package:cluster/presentation/dashboard_screen/profile/profile_bloc/profile_bloc.dart';

import 'package:cluster/presentation/logistic_app/bloc/bloc/logistics_orders_bloc.dart';
import 'package:cluster/presentation/order_app/bloc/order_status_bloc/order_status_bloc.dart';
import 'package:cluster/presentation/seller_admin_app/seller_admin_bloc/seller_admin_bloc.dart';
import 'package:cluster/presentation/task_operation/create/task_bloc/task_bloc.dart';
import 'package:cluster/presentation/task_operation/employee_bloc/employee_bloc.dart';
import 'package:cluster/presentation/task_operation/home/bloc/job_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'presentation/comunication_module/bloc/attachment_bloc.dart';
import 'presentation/comunication_module/bloc/chat_bloc.dart';
import 'presentation/comunication_module/bloc/communication_bloc.dart';
import 'presentation/comunication_module/bloc/paginatedchat_bloc.dart';
import 'presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
import 'presentation/comunication_module/group_bloc/bloc/group_bloc.dart';
import 'presentation/order_app/bloc/order_bloc/order_list_bloc.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await authentication.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("..........${authentication.authenticatedUser.token}");
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.white,
    ));

    return StreamProvider<InternetConnectionStatus>(

        initialData: InternetConnectionStatus.connected,
        create: (_) {
          return InternetConnectionChecker().onStatusChange;
        },
        child: FlutterSizer(builder: (context, orientation, screenType) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: ((context) => scoketProvider() )),
              BlocProvider(
                create: (context) => JobBloc(),
              ),
              BlocProvider(
                create: (context) => TaskBloc(),
              ),
              BlocProvider(
                create: (context) => EmployeeBloc(),
              ),
              BlocProvider(
                create: (context) => OrderListBloc(),
              ),
              BlocProvider(
                create: (context) => OrderStatusBloc(),
              ),
              BlocProvider(
                create: (context) => AuthBloc(),
              ),
              BlocProvider(
                create: (context) => LogisticsOrdersBloc(),
              ),
               BlocProvider(
                create: (context) => DummyLoginBloc(),
              ),
              BlocProvider(
                create: (context) => CommunicationBloc(),
              ),
              BlocProvider(
                create: (context) => SellerAdminBloc(),
              ),
              BlocProvider(
                create: (context) => ChatBloc(),
              ),
              BlocProvider(
                create: (context) => PaginatedchatBloc(),
              ),
              BlocProvider(
                create: (context) => GroupBloc(),
              ),
              BlocProvider(
                create: (context) => AttachmentBloc(),
              ), BlocProvider(
                create: (context) => ProfileBloc(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Sidrateams',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),

              home:  SplashScreen(),
              // home:  HomeApp(),
            ),
          );
        }));
  }
}


