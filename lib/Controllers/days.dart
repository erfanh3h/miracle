import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Components/dialog_component.dart';
import 'package:miracle/Controllers/auth_controller.dart';
import 'package:miracle/Core/auth_repository.dart';
import 'package:miracle/Data/exercises.dart';
import 'package:miracle/Core/days_repository.dart';
import 'package:miracle/Models/days.dart';

class DaysController extends BaseController {
  late int dayNumber;
  late String exerciseContent;
  final DaysRepository _repo = DaysRepository();

  DaysController();

  Rx<List<DaysModel>> data = Rx([]);
  final currentDay = Get.find<AuthController>().currentDay ?? 1;

  Future<void> fetchData() async {
    await fetchFromStorage();
    if (data.value.isEmpty) {
      fetchFromServer();
    }
    // if (Get.find<GlobalController>().syncData) {
    //   fetchFromServer();
    // } else {
    //   fetchFromStorage();
    // }
  }

  Future<void> finishDay() async {
    final repo = AuthRepository();
    final result = await repo.updateCurrentDay(day: currentDay + 1);
    if (result.resultData != null) {
      DialogCompanent(message: "امروز تکمیل شد✨");
      Get.closeAllDialogs();
      Get.back();
    }
  }

  Future<void> fetchFromStorage() async {
    // isPageLoading.value = false;
    data.value = await _repo.getDayDataStorage(dayNumber: dayNumber);
    // isPageLoading.value = false;
  }

  Future<void> fetchFromServer() async {
    isPageLoading.value = true;
    var response = await _repo.getDayDataServer(dayNumber: dayNumber);
    if (response.resultData != null) {
      data.value = response.resultData!;
      for (var dataRaw in data.value) {
        _repo.writeDayDataStorage(data: dataRaw);
      }
    } else {
      // Get.back();
    }
    isPageLoading.value = false;
  }

  Future<void> deleteData(int index) async {
    deleteFromServer(index);
    deleteFromStorage(index);
    // if (Get.find<GlobalController>().syncData) {
    //   deleteFromServer(index);
    // } else {
    //   deleteFromStorage(index);
    // }
  }

  Future<void> deleteFromStorage(int index) async {
    Get.closeAllDialogs();
    data.value.removeAt(index);
    await _repo.deleteDayDataStorage(dayNumber: dayNumber, index: index);
    isPageLoading.value = false;
    fetchFromStorage();
  }

  Future<void> deleteFromServer(int index) async {
    _repo.deleteDayDataServer(
      dataId: data.value[index].id!,
      imageId: data.value[index].imageId,
    );
  }

  @override
  void onInit() {
    dayNumber = Get.arguments;
    exerciseContent = exercises[dayNumber - 1];
    fetchData();
    super.onInit();
  }
}
