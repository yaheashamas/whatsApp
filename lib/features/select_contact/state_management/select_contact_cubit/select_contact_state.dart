part of 'select_contact_cubit.dart';

class SelectContactState extends Equatable {
  final List<UserModel> contacts;
  final List<UserModel> contactsSearch;
  final StateWidget stateWidget;
  final String message;

  const SelectContactState({
    required this.contacts,
    required this.contactsSearch,
    required this.stateWidget,
    required this.message,
  });

  factory SelectContactState.inail() {
    return const SelectContactState(
      contacts: [],
      contactsSearch: [],
      stateWidget: StateWidget.loading,
      message: "",
    );
  }

  @override
  List<Object> get props => [contacts,contactsSearch, stateWidget, message];

  SelectContactState copyWith({
    List<UserModel>? contacts,
    List<UserModel>? contactsSearch,
    StateWidget? stateWidget,
    String? message,
  }) {
    return SelectContactState(
      contacts: contacts ?? this.contacts,
      contactsSearch: contactsSearch ?? this.contactsSearch,
      stateWidget: stateWidget ?? this.stateWidget,
      message: message ?? this.message,
    );
  }
}
