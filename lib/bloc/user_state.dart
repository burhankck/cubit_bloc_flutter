// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cubit_bloc_flutter/model/user_model.dart';
import 'package:flutter/foundation.dart';

abstract class UserState {
  const UserState();
}

class CatsInitial extends UserState {
  const CatsInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserCompleted extends UserState {
  final List<UserModel?> userModelList;

  UserCompleted({required this.userModelList});
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);
}
