import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Core/days_repository.dart';
import 'package:miracle/Models/days.dart';

class DaysShowController extends BaseController {
  final DaysRepository _repo = DaysRepository();

  late DaysModel data;
  late int dataIndex;
  DaysShowController();

  Future<void> deleteData() async {
    deleteFromServer();
    await deleteFromStorage();
    // if (Get.find<GlobalController>().syncData) {
    //   deleteFromServer();
    // } else {
    //   deleteFromStorage();
    // }
  }

  Future<void> deleteFromStorage() async {
    Get.closeAllDialogs();
    await _repo.deleteDayDataStorage(
      dayNumber: data.dayNumber,
      index: dataIndex,
    );
  }

  Future<void> deleteFromServer() async {
    await _repo.deleteDayDataServer(dataId: data.id!, imageId: data.imageId);
  }

  @override
  void onInit() {
    data = Get.arguments[0];
    dataIndex = Get.arguments[1] - 1;
    super.onInit();
  }
}
