part of 'info_user_cubit.dart';

class InfoUserState extends Equatable {
  final File? image;
  final FullName fullName;
  final StateWidget stateWidget;

  const InfoUserState({
    required this.image,
    required this.fullName,
    required this.stateWidget,
  });
  factory InfoUserState.inial() {
    return const InfoUserState(
      image: null,
      fullName: FullName.pure(),
      stateWidget: StateWidget.loading,
    );
  }

  @override
  List<Object?> get props => [
        image,
        fullName,
        stateWidget,
      ];

  InfoUserState copyWith({
    File? image,
    FullName? fullName,
    StateWidget? stateWidget,
  }) {
    return InfoUserState(
      image: image ?? this.image,
      fullName: fullName ?? this.fullName,
      stateWidget: stateWidget ?? this.stateWidget,
    );
  }
}
