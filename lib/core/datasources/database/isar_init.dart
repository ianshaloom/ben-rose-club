import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../../features/authentication/data/provider/database/models/user.dart';

class IsarService {
  static late Isar isar;

  static Future<void> initialize() async {
    final appDir = await path_provider.getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      isar = await Isar.open(
        [UserIsarSchema],
        directory: appDir.path,
      );
    }
  }
}
