import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/routes/route_constants.dart';
import 'package:whats_app/features/landing/state_management/user_cubit/user_cubit.dart';
import 'package:whats_app/features/landing/state_management/user_cubit/user_state.dart';

class InialScreen extends StatelessWidget {
  const InialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state.userModel != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteList.home,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteList.landing,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
