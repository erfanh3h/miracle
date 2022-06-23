import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/days/Core/days_repository.dart';
import 'package:miracle/Features/days/Models/days.dart';

class DaysAddController extends BaseController {
  final DaysRepository _repo;

  late int dayNumber;

  DaysAddController(this._repo);

  createData(DaysModel? addData) async {
    await _repo.writeDayDataStorage(
        data: addData ?? DaysModel(dayNumber: dayNumber));
    isPageLoading.value = false;
    Get.back(result: true);
  }

  @override
  void onInit() {
    dayNumber = Get.arguments;
    super.onInit();
  }
}
