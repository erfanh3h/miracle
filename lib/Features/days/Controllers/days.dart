import 'package:refreshed/refreshed.dart';
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

  fetchData() async {
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

  fetchFromStorage() async {
    // isPageLoading.value = false;
    data.value = await _repo.getDayDataStorage(dayNumber: dayNumber);
    // isPageLoading.value = false;
  }

  fetchFromServer() async {
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

  deleteData(int index) async {
    deleteFromStorage(index);
    // if (Get.find<GlobalController>().syncData) {
    //   deleteFromServer(index);
    // } else {
    //   deleteFromStorage(index);
    // }
  }

  deleteFromStorage(int index) async {
    Get.closeAllDialogs();
    data.value.removeAt(index);
    await _repo.deleteDayDataStorage(
      dayNumber: dayNumber,
      index: index,
    );
    isPageLoading.value = false;
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
    fetchData();
    super.onInit();
  }
}
