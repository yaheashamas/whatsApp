import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/state_management/loading_cubit/loading_cubit.dart';

class LoadingScreen extends StatelessWidget {
  final Widget child;
  const LoadingScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, bool>(
      builder: (context, shouldShow) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              child,
              if (shouldShow)
                AbsorbPointer(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 2.0,
                      sigmaY: 2.0,
                    ),
                    child: Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(29),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 1,
                              offset: const Offset(1, 1),
                              color: Theme.of(context)
                                  .scaffoldBackgroundColor
                                  .withOpacity(0.1),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(30),
                        child: const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
