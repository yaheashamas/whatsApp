import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whats_app/core/global/widgets/text_form_field/custom_text_form_field.dart';
import 'package:whats_app/core/helper/helper.dart';
import 'package:whats_app/core/models/code_phone_number_model.dart';
import 'package:whats_app/features/auth/controller/auth_controller.dart';
import 'package:whats_app/features/auth/screens/search_countries.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String codeCountry = "";
  final TextEditingController code = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    Helper().getAllCountries();
    super.initState();
  }

  login(String phoneNumber) async {
    await ref
        .read(authControllerProvider)
        .signInWithPhone(context, phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Enter Your Phone Number")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text(
              "WhatsApp will need to verify your phone number.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomTextFormField(
                    controller: code,
                    readOnly: true,
                    prefixIcon: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          codeCountry,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    onTap: () async {
                      CodePhoneNumberModel? value =
                          await showSearch<CodePhoneNumberModel?>(
                        context: context,
                        delegate: SearchCountries(),
                      );
                      if (value?.name != null) {
                        code.text = value!.regionalNumber;
                        setState(() {
                          codeCountry = value.code;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 8,
                  child: CustomTextFormField(
                    controller: phoneNumber,
                    textInputType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SafeArea(
              child: ElevatedButton(
                onPressed: () async {
                  await login(
                    code.text.toString() + phoneNumber.text.toString(),
                  );
                },
                child: const Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
