import 'package:bloc/bloc.dart';

class LoadingCubit extends Cubit<bool> {
  LoadingCubit() : super(false);
  show() => emit(true);
  hide() => emit(false);
}
