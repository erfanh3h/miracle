import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Data/exercises.dart';
import 'package:miracle/Features/days/Core/days_repository.dart';
import 'package:miracle/Features/days/Models/days.dart';

class DaysController extends BaseController {
  late int dayNumber;
  late String exerciseContent;
  final DaysRepository _repo;

  DaysController(this._repo);

  Rx<List<DaysModel>> data = Rx([]);

  fetchFromStorage() async {
    data.value = await _repo.getDayDataStorage(dayNumber: dayNumber);
    isPageLoading.value = false;
  }

  

  deleteFromStorage(int index) async {
    data.value.removeAt(index);
    await _repo.deleteDayDataStorage(
      dayNumber: dayNumber,
      index: index,
    );
    isPageLoading.value = false;
    Get.back();
    fetchFromStorage();
  }

  @override
  void onInit() {
    dayNumber = Get.arguments;
    exerciseContent = exercises[dayNumber - 1];
    fetchFromStorage();
    super.onInit();
  }
}
