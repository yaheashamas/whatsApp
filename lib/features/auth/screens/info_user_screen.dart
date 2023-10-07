import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/global/widgets/text_form_field/custom_text_form_field.dart';
import 'package:whats_app/core/permission/check_permission.dart';
import 'package:whats_app/core/utils/snak_bar.dart';
import 'package:whats_app/di.dart';
import 'package:whats_app/features/auth/state_management/info_user_cubit/info_user_cubit.dart';

class InfoUserScreen extends StatefulWidget {
  const InfoUserScreen({super.key});

  @override
  State<InfoUserScreen> createState() => _InfoUserScreenState();
}

class _InfoUserScreenState extends State<InfoUserScreen> {
  late InfoUserCubit infoUserCubit;
  String imageName = "https://cdn-icons-png.flaticon.com/512/149/149071.png";
  @override
  void initState() {
    super.initState();
    infoUserCubit = getIt.get<InfoUserCubit>();
  }

  @override
  void dispose() {
    infoUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => infoUserCubit,
      child: Scaffold(
        appBar: AppBar(title: const Text("Your Profile")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    BlocBuilder<InfoUserCubit, InfoUserState>(
                      builder: (context, state) {
                        return state.image != null
                            ? CircleAvatar(
                                backgroundImage: FileImage(state.image!),
                                radius: 75,
                              )
                            : CircleAvatar(
                                child: Image.network(
                                  imageName,
                                  height: 150,
                                  width: 160,
                                ),
                                radius: 75,
                              );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () async {
                          await CheckPermission.isStoragePermission()
                              .then((value) {
                            if (value) {
                              getLostData(context).then((value) {
                                infoUserCubit.changeImage(value);
                              });
                            }
                          });
                        },
                        icon: const Icon(Icons.add_a_photo_outlined),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: BlocBuilder<InfoUserCubit, InfoUserState>(
                        builder: (context, state) {
                          return CustomTextFormField(
                            label: "Full Name",
                            errorText: state.fullName.isNotValid
                                ? state.fullName.error
                                : null,
                            onChanged: (value) {
                              infoUserCubit.changeName(value);
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: BlocBuilder<InfoUserCubit, InfoUserState>(
                        builder: (context, state) {
                          return IconButton(
                            onPressed: () async {
                              infoUserCubit.storeUser(context);
                            },
                            icon: Icon(
                              Icons.done,
                              color: state.fullName.isNotValid
                                  ? null
                                  : Colors.green,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
