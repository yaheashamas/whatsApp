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
import 'package:whats_app/features/landing/state_management/user_cubit/user_cubit.dart';
import 'package:whats_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late LoadingCubit loadingCubit;
  late UserCubit userCubit;
  @override
  void initState() {
    super.initState();
    loadingCubit = getIt.get<LoadingCubit>();
    userCubit = getIt.get<UserCubit>();
    userCubit.getUser();
  }

  @override
  void dispose() {
    loadingCubit.close();
    userCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => loadingCubit),
        BlocProvider(create: (context) => userCubit),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whatsapp UI',
        theme: darkTheme(),
        initialRoute: RouteList.initial,
        builder: (context, child) {
          return LoadingScreen(child: child!);
        },
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
