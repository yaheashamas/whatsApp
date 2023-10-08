import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/routes/route_constants.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/landing/state_management/user_cubit/user_cubit.dart';
import 'package:whats_app/features/landing/state_management/user_cubit/user_state.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<UserCubit, UserState>(
        listenWhen: (previous, current) {
          return previous.userModel != current.userModel;
        },
        listener: (context, state) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteList.home,
            (route) => false,
          );
        },
        builder: (context, state) {
          switch (state.stateWidget) {
            case StateWidget.loaded:
              return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Text(
                      "Welcome To WatsApp",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Expanded(
                        child: Image.asset("assets/images/landing_screen.png")),
                    Text(
                      "Read our Privacy Policy, Tap \"Agree and continue\" to accept the Terms of Service.",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteList.login);
                        },
                        child: const Text("Agree And Continue"),
                      ),
                    ),
                  ],
                ),
              );
            case StateWidget.loading:
              return const Center(child: CircularProgressIndicator());
            case StateWidget.error:
              return const Center(child: CircularProgressIndicator());
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
