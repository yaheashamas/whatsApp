part of 'login_cubit.dart';

class LoginState extends Equatable {
  final Phone phone;
  final StateWidget stateWidget;
  final List<CodePhoneNumberModel>? allCountries;
  final CodePhoneNumberModel? chooseCountry;

  const LoginState({
    required this.phone,
    required this.stateWidget,
    required this.allCountries,
    required this.chooseCountry,
  });

  factory LoginState.inial() {
    return const LoginState(
      phone: Phone.pure(),
      stateWidget: StateWidget.loading,
      allCountries: [],
      chooseCountry: null,
    );
  }

  @override
  List<Object?> get props => [
        phone,
        allCountries,
        chooseCountry,
        stateWidget,
      ];

  LoginState copyWith({
    Phone? phone,
    StateWidget? stateWidget,
    List<CodePhoneNumberModel>? allCountries,
    CodePhoneNumberModel? chooseCountry,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      stateWidget: stateWidget ?? this.stateWidget,
      allCountries: allCountries ?? this.allCountries,
      chooseCountry: chooseCountry ?? this.chooseCountry,
    );
  }
}
