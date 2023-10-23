import 'package:cubit_bloc_flutter/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cubit_bloc_flutter/bloc/cats_state.dart';

class UserCubit extends Cubit<UserState> with _CubitProperties {
  UserCubit() : super(CatsInitial());

  final UserRepository _repository = UserRepository();

  Future<void> getCats() async {
    try {
      emit(UserLoading());
      await Future.delayed(Duration(seconds: 4));

      await _repository.getUserInformationRepository().then((responseValue) {
        if (responseValue != null && responseValue.isNotEmpty) {
          emit(UserCompleted(userModelList: responseValue));
        } else {
          emit(UserError("Hata mesajı"));
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        emit(UserError("Bilinmeyen bir hata oluştu"));
      });
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  void emitInitial() {
    emit(CatsInitial());
  }
}

mixin _CubitProperties {
  String testParameter = 'Burhan';
}
