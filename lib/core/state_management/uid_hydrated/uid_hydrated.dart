import 'package:hydrated_bloc/hydrated_bloc.dart';

class UidCubit extends HydratedCubit<String?> {
  UidCubit() : super(null);
  void addUID(String uid) => emit(uid);
  void deleteUId() => emit(null);

  @override
  String? fromJson(Map<String, dynamic> json) {
    return json.isNotEmpty ? json['uid'] : null;
  }

  @override
  Map<String, dynamic>? toJson(String? state) {
    return state!.isNotEmpty ? {'uid': state} : null;
  }
}