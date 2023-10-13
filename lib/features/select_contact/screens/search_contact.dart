import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/core/constants/const_color.dart';
import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/core/routes/route_constants.dart';
import 'package:whats_app/core/themes/theme_dark/theme_dark.dart';
import 'package:whats_app/features/auth/state_management/login_cubit/login_cubit.dart';
import 'package:whats_app/features/select_contact/state_management/select_contact_cubit/select_contact_cubit.dart';

class SearchContact extends SearchDelegate<UserModel?> {
  SelectContactCubit selectContactCubit;
  SearchContact({required this.selectContactCubit});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return darkTheme();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
      PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            const PopupMenuItem<int>(
              value: 0,
              child: Text("Refesh"),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 0) {
            selectContactCubit.getAllContact();
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_sharp),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    selectContactCubit.search(query);
    return BlocBuilder<SelectContactCubit, SelectContactState>(
      bloc: selectContactCubit,
      builder: (context, state) {
        if (state.stateWidget == StateWidget.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          itemCount: state.contactsSearch.length,
          itemBuilder: (context, index) {
            var user = state.contactsSearch[index];
            return InkWell(
              onTap: () {
                if (!user.invite) {
                  close(context, null);
                  Navigator.pushNamed(
                    context,
                    RouteList.chat,
                    arguments: user.uid,
                  );
                }
              },
              child: ListTile(
                title: Text(
                  user.name.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    user.phoneNumber.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                trailing: Text(
                  user.invite ? "Invate" : "",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: tabColor),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.profilePic.toString(),
                  ),
                  radius: 30,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    selectContactCubit.search(query);
    return BlocBuilder<SelectContactCubit, SelectContactState>(
      bloc: selectContactCubit,
      builder: (context, state) {
        if (state.stateWidget == StateWidget.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          itemCount: state.contactsSearch.length,
          itemBuilder: (context, index) {
            var user = state.contactsSearch[index];
            return InkWell(
              onTap: () {
                if (!user.invite) {
                  close(context, null);
                  Navigator.pushNamed(
                    context,
                    RouteList.chat,
                    arguments: user.uid,
                  );
                }
              },
              child: ListTile(
                title: Text(
                  user.name.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    user.phoneNumber.toString(),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                trailing: Text(
                  user.invite ? "Invate" : "",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: tabColor),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.profilePic.toString(),
                  ),
                  radius: 30,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Divider(
              color: Colors.grey,
              thickness: 0.5,
            ),
          ),
        );
      },
    );
  }
}
