import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:whats_app/core/themes/theme_dark/theme_dark.dart';
import 'package:whats_app/features/select_contact/state_management/select_contact_cubit/select_contact_cubit.dart';

class SearchContact extends SearchDelegate<Contact?> {
  List<Contact> contacts;
  SelectContactCubit selectContactCubit;
  SearchContact({
    required this.contacts,
    required this.selectContactCubit,
  });

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
              child: Text("My Account"),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text("Settings"),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text("Logout"),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 0) {
            print("My account menu is selected.");
          } else if (value == 1) {
            print("Settings menu is selected.");
          } else if (value == 2) {
            print("Logout menu is selected.");
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
    List<Contact> searchContacts = contacts
        .where(
          (element) => element.displayName.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return ListView.separated(
      itemCount: searchContacts.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          close(context, searchContacts[index]);
        },
        child: ListTile(
          title: Text(
            searchContacts[index].displayName,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> searchContacts = contacts
        .where(
          (element) => element.displayName.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
    return BlocBuilder<SelectContactCubit, SelectContactState>(
      bloc: selectContactCubit,
      builder: (context, state) {
        return ListView.separated(
          itemCount: searchContacts.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              selectContactCubit.selectUser(
                context,
                searchContacts[index],
              );
              // close(context, searchContacts[index]);
            },
            child: ListTile(
              title: Text(
                searchContacts[index].displayName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
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
