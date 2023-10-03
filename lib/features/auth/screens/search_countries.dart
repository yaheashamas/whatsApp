import 'package:flutter/material.dart';
import 'package:whats_app/core/models/code_phone_number_model.dart';
import 'package:whats_app/core/themes/theme_dark/theme_dark.dart';

class SearchCountries extends SearchDelegate<CodePhoneNumberModel?> {
  List<CodePhoneNumberModel> allCountries;
  SearchCountries(this.allCountries);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return darkTheme();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back_ios_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<CodePhoneNumberModel> newCountries = allCountries
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.separated(
      itemCount: newCountries.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: ListTile(
            leading: Text(
              newCountries[index].flag,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            title: Text(
              newCountries[index].name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(
              newCountries[index].regionalNumber,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          onTap: () {
            close(context, newCountries[index]);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<CodePhoneNumberModel> newCountries = allCountries
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.separated(
      itemCount: newCountries.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: ListTile(
            leading: Text(
              newCountries[index].flag,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            title: Text(
              newCountries[index].name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Text(
              newCountries[index].regionalNumber,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          onTap: () {
            close(context, newCountries[index]);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Divider(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        );
      },
    );
  }
}
