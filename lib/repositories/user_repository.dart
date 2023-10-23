import 'package:cubit_bloc_flutter/model/user_model.dart';

class UserRepository {
  Future<List<UserModel>?> getUserInformationRepository() async {
    try {
      List<UserModel> userModelList = [
        UserModel(name: "Burhan", surName: "KOÇAK", age: 29),
        UserModel(name: "Ebru", surName: "ERDOĞAN", age: 29)
      ];
      return userModelList;
    } catch (e) {
      rethrow;
    }
  }
}
