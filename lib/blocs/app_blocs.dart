import 'package:todobloc/blocs/app_states.dart';
import 'package:todobloc/blocs/app_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repos/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      // final users = await _userRepository.getUsers();
      // emit(UserLoadingState());
      // emit(UserLoadedState(users));

      emit(UserLoadingState());

      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
        print('user loaded state');
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
