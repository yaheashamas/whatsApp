part of 'select_contact_cubit.dart';

class SelectContactState extends Equatable {
  final List<Contact> contacts;
  final StateWidget stateWidget;
  final String message;

  const SelectContactState({
    required this.contacts,
    required this.stateWidget,
    required this.message,
  });

  factory SelectContactState.inail() {
    return const SelectContactState(
      contacts: [],
      stateWidget: StateWidget.loading,
      message: "",
    );
  }

  @override
  List<Object> get props => [contacts, stateWidget, message];

  SelectContactState copyWith({
    List<Contact>? contacts,
    StateWidget? stateWidget,
    String? message,
  }) {
    return SelectContactState(
      contacts: contacts ?? this.contacts,
      stateWidget: stateWidget ?? this.stateWidget,
      message: message ?? this.message,
    );
  }
}
