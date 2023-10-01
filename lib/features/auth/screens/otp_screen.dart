import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  final String verficationId;
  const OtpScreen({super.key,required this.verficationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text("OTP Screen")),
    );
  }
}
