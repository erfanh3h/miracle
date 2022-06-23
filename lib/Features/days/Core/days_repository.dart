import 'package:hive/hive.dart';
import 'package:miracle/Features/days/Models/days.dart';

abstract class DaysRepository {
  Future<List<DaysModel>> getDayDataStorage({
    required final int dayNumber,
  });
  Future<bool> writeDayDataStorage({
    required final DaysModel data,
  });
  Future<bool> deleteDayDataStorage({
    required final int index,
    required final int dayNumber,
  });
}

class DaysRepositoryImp extends DaysRepository {
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

  @override
  Future<bool> writeDayDataStorage({required DaysModel data}) async {
    final Box<DaysModel> storage =
        await Hive.openBox<DaysModel>('days${data.dayNumber}');
    await storage.add(data);
    await storage.close();
    return true;
  }

  @override
  Future<bool> deleteDayDataStorage({
    required int index,
    required int dayNumber,
  }) async {
    final Box<DaysModel> storage =
        await Hive.openBox<DaysModel>('days$dayNumber');
    await storage.deleteAt(index);
    await storage.close();
    return true;
  }
}
