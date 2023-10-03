import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/routes/fade_page_route_builder.dart';
import 'package:whats_app/core/routes/route.dart';
import 'package:whats_app/core/routes/route_constants.dart';
import 'package:whats_app/core/screens/loading_screen.dart';
import 'package:whats_app/core/state_management/loading_cubit/loading_cubit.dart';
import 'package:whats_app/core/themes/theme_dark/theme_dark.dart';
import 'package:whats_app/di.dart';
import 'package:whats_app/features/landing/landing_screen.dart';
import 'package:whats_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<LoadingCubit>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whatsapp UI',
        theme: darkTheme(),
        home: const LoadingScreen(
          child: LandingScreen(),
        ),
        initialRoute: RouteList.initial,
        onGenerateRoute: (settings) {
          final routes = Routes.getRoutes(settings);
          final WidgetBuilder? builder = routes[settings.name];
          return FadePageRouteBuilder(
            builder: builder!,
            settings: settings,
          );
        },
        // const ResponsiveLayout(
        //   mobileScreenLayout: MobileLayoutScreen(),
        //   webScreenLayout: WebLayoutScreen(),
        // ),
      ),
    );
  }
}
