import 'package:flutter/cupertino.dart';
import 'package:whats_app/core/routes/route_constants.dart';
import 'package:whats_app/features/auth/screens/info_user_screen.dart';
import 'package:whats_app/features/auth/screens/login_screen.dart';
import 'package:whats_app/features/auth/screens/otp_screen.dart';
import 'package:whats_app/features/landing/landing_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings settings) => {
        RouteList.initial: (context) => const LandingScreen(),
        //auth
        RouteList.login: (context) => const LoginScreen(),
        //otp auth
        RouteList.otp: (context) => OtpScreen(
              verficationId: settings.arguments as String,
            ),
        //user info
        RouteList.infoUser: (context) => const InfoUserScreen(),
      };
}
