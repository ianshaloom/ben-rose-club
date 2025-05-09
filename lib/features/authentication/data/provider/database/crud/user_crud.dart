import 'package:isar/isar.dart';

import '../../../../../../core/datasources/database/isar_init.dart';
import '../models/user.dart';

class UserCrud {
  final Isar isar = IsarService.isar;

  Future<UserIsar?> getUserById(int id) {
    return isar.userIsars.get(id);
  }

  Future<void> insertUser(UserIsar user) async {
    await isar.writeTxn(() async {
      await isar.userIsars.put(user);
    });
  }

  Future<void> updateUser(UserIsar user) async {
    await isar.writeTxn(() async {
      await isar.userIsars.put(user);
    });
  }

  Future<void> deleteUser(UserIsar user) async {
    await isar.writeTxn(() async {
      await isar.userIsars.delete(user.id);
    });
  }
}
