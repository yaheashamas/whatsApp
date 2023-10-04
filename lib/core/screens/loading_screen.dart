import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/state_management/loading_cubit/loading_cubit.dart';

class LoadingScreen extends StatelessWidget {
  final Widget child;
  const LoadingScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        child,
        BlocBuilder<LoadingCubit, bool>(
          builder: (context, state) {
            return state
                ? AbsorbPointer(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 2.0,
                        sigmaY: 2.0,
                      ),
                      child: Center(
                        child: Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(30),
                          child: const CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  )
                : Container();
          },
        )
      ],
    );
  }
}
