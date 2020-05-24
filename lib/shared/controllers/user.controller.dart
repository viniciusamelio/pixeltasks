import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pixeltasks/shared/models/user.model.dart';
import 'package:pixeltasks/shared/services/hive.service.dart';

class UserController extends GetController with HiveService {
  User user;
  Box userBox;
  bool request = false;

  UserController() {
    user = User();
    openUserBox();
  }

  Future<void> openUserBox() async {
    this.userBox = await super.openBox('user');
  }

  Future<void> save() async {
    await this.userBox.put(this.user.id, this.user.toJson());
  }

  Future<bool> check() async {
    super.init();
    bool hasUser = await this.userBox.get(this.user.id) != null ? true : false;
    return hasUser;
  }

  Future<User> get(String userId) async {
    /* Se o usuário pesquisado pelo ID existir ele é setado e retornado */
    User _user = User.fromJson(await this.userBox.get(userId)) ?? User();
    return _user;
  }

  Future<void> updateExisting() async {
    await this.userBox.delete(this.user.id);
    await this.userBox.put(this.user.id, this.user.toJson());
  }

  void changeRequestStatus() {
    this.request = !this.request;
    update(this);
  }

  Future<bool> verifyPassword() async {
    final User findUser = await this.get(this.user.id) ?? User();
    final check = findUser.password == this.user.password;
    return check;
  }
}
