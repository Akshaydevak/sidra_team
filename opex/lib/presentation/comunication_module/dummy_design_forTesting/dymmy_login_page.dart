import 'package:cluster/common_widgets/loading.dart';
import 'package:cluster/core/color_palatte.dart';
import 'package:cluster/core/common_snackBar.dart';
import 'package:cluster/presentation/comunication_module/communication_homescreen.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/bloc/dummy_login_bloc.dart';
import 'package:cluster/presentation/comunication_module/dummy_design_forTesting/dummychatscreen.dart';
import 'package:cluster/presentation/dashboard_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  @override
  void initState() {
    BlocProvider.of<DummyLoginBloc>(context)
        .add(TokenCreationCommunicationEvent());

    super.initState();
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupusername = TextEditingController();
  TextEditingController signupPassword = TextEditingController();
  String? dummyToken;

  @override
  Widget build(BuildContext context) {
    print("build");

    return DefaultTabController(
      length: 2,
      child: BlocListener<DummyLoginBloc, DummyLoginState>(
        listener: (context, state) {
          if (state is TokenCreationCommunicationLoading) {
            customCupertinoLoading();
          } else if (state is TokenCreationCommunicationSuccess) {
            // PersistentNavBarNavigator.pushNewScreen(
            //   context,
            //   screen: CommunicationModule(
            //     token: state.token,
            //   ),
            //   withNavBar: true, // OPTIONAL VALUE. True by default.
            //   pageTransitionAnimation: PageTransitionAnimation.fade,
            // );
          }
          else if (state is TokenCreationCommunicationFailed) {
         
          }
        },
        child: Center(
          child: SizedBox(
        
            width: MediaQuery.of(context).size.width / 8,
            child:const LoadingIndicator(
                indicatorType: Indicator.ballPulse,
                colors: [ColorPalette.primary],
                strokeWidth: 0.1,
                backgroundColor: Colors.transparent,
                pathBackgroundColor: Colors.black)
          ),
        ),
      ),
    );
  }
}
