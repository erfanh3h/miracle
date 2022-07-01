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

  fetchFromServer() async {
    isPageLoading.value = true;
    var response = await _repo.getDayDataServer(dayNumber: dayNumber);
    if (response.resultData != null) {
      data.value = response.resultData!;
    } else {
      Get.back();
    }
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

  deleteFromServer(int index) async {
    isPageLoading.value = true;
    await _repo.deleteDayDataServer(dataId: data.value[index].id!);
    isPageLoading.value = false;
    Get.back();
    fetchFromServer();
  }

  @override
  void onInit() {
    dayNumber = Get.arguments;
    exerciseContent = exercises[dayNumber - 1];
    fetchFromServer();
    super.onInit();
  }
}
