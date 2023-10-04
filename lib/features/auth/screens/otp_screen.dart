import 'package:flutter/material.dart';
import 'package:whats_app/core/global/widgets/text_form_field/custom_text_form_field.dart';
import 'package:whats_app/di.dart';
import 'package:whats_app/features/auth/controller/auth_controller.dart';

class OtpScreen extends StatelessWidget {
  final String verficationId;
  const OtpScreen({super.key, required this.verficationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verification your number")),
      body: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            "We have send an SMS with a code",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 75),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 100),
            child: CustomTextFormField(
              textAlign: TextAlign.center,
              textInputType: TextInputType.number,
              label: "- - - - - -",
              maxLength: 6,
              onChanged: (value) {
                if (value.length == 6) {
                  getIt.get<AuthController>().verficationOTP(
                        context,
                        verficationId,
                        value,
                      );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
