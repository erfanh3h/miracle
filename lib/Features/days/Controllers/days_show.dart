import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/days/Core/days_repository.dart';
import 'package:miracle/Features/days/Models/days.dart';

class DaysShowController extends BaseController {
  final DaysRepository _repo;

  late DaysModel data;
  late int dataIndex;
  DaysShowController(this._repo);

  deleteData() async {
    await deleteFromStorage();
    deleteFromServer();
    // if (Get.find<GlobalController>().syncData) {
    //   deleteFromServer();
    // } else {
    //   deleteFromStorage();
    // }
  }

  deleteFromStorage() async {
    Get.closeAllDialogs();
    await _repo.deleteDayDataStorage(
      dayNumber: data.dayNumber,
      index: dataIndex,
    );
  }

  deleteFromServer() async {
    isPageLoading.value = true;
    await _repo.deleteDayDataServer(dataId: data.id!);
    isPageLoading.value = false;
    Get.back();
  }

  @override
  void onInit() {
    data = Get.arguments[0];
    dataIndex = Get.arguments[1] - 1;
    super.onInit();
  }
}
