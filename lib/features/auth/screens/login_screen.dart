import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/global/widgets/text_form_field/custom_text_form_field.dart';
import 'package:whats_app/core/models/code_phone_number_model.dart';
import 'package:whats_app/di.dart';
import 'package:whats_app/features/auth/screens/search_countries.dart';
import 'package:whats_app/features/auth/state_management/cubit/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit loginCubit;
  late TextEditingController codeController;
  final TextEditingController phoneNumber = TextEditingController();

  @override
  void initState() {
    loginCubit = getIt.get<LoginCubit>();
    codeController = loginCubit.codeController;
    loginCubit.getAllCountry();

    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    phoneNumber.dispose();
    loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginCubit,
      child: Scaffold(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return state.stateWidget == StateWidget.loading
                            ? const CircularProgressIndicator()
                            : CustomTextFormField(
                                controller: codeController,
                                readOnly: true,
                                label: "Phone Number",
                                prefixIcon: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      state.chooseCountry?.code ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ],
                                ),
                                onTap: () => chooseCountry(state),
                              );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 8,
                    child: BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return state.stateWidget == StateWidget.loading
                            ? const CircularProgressIndicator()
                            : CustomTextFormField(
                                controller: phoneNumber,
                                textInputType: TextInputType.phone,
                                errorText: state.phone.isValid
                                    ? null
                                    : state.phone.error,
                                maxLength: state.phone.max,
                                onChanged: (value) {
                                  loginCubit.changePhoneNumber(value);
                                },
                              );
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SafeArea(
                child: BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.phone.isValid
                          ? () async {
                              loginCubit.login(context);
                            }
                          : null,
                      child: const Text("Login"),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  chooseCountry(LoginState state) async {
    CodePhoneNumberModel? chooseCountry =
        await showSearch<CodePhoneNumberModel?>(
      context: context,
      delegate: SearchCountries(
        state.allCountries ?? [],
      ),
    );
    if (chooseCountry?.name != null) {
      loginCubit.chooseCountry(chooseCountry!);
    }
  }
}
