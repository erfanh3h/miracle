import 'package:hive/hive.dart';
import 'package:miracle/Features/days/Models/days.dart';

abstract class AuthRepository {
  Future<List<DaysModel>> getDayDataStorage({
    required final int dayNumber,
  });
}

class AuthRepositoryImp extends AuthRepository {
  @override
  Future<List<DaysModel>> getDayDataStorage({required int dayNumber}) async {
    final Box<DaysModel> storage =
        await Hive.openBox<DaysModel>('days$dayNumber');
    List<DaysModel> results = [];
    storage.values
        .where((item) => item.dayNumber == dayNumber)
        .forEach((data) => results.add(data));
    await storage.close();
    return results;
  }
}
