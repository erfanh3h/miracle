import 'package:file_picker/file_picker.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/days/Core/days_repository.dart';
import 'package:miracle/Features/days/Models/days.dart';

class DaysAddController extends BaseController {
  final DaysRepository _repo;
  final GlobalRepository _globalRepository;

  late int dayNumber;

  DaysAddController(this._repo, this._globalRepository);

  createData(DaysModel? addData, {PlatformFile? uploadFile}) async {
    if (uploadFile != null) {
      final imageResult =
          await _globalRepository.uploadFile(fileData: uploadFile);
      if (imageResult.resultData != null) {
        final String imageId = imageResult.resultData!;
        addData = addData!.copyWith(imageId: imageId);
      }
    }
    await createDataStorage(addData);
    createDataServer(addData);
    // if (Get.find<GlobalController>().syncData) {
    //   createDataServer(addData);
    // } else {
    //   createDataStorage(addData);
    // }
  }

  createDataStorage(DaysModel? addData) async {
    await _repo.writeDayDataStorage(
        data: addData ?? DaysModel(dayNumber: dayNumber));
  }

  createDataServer(DaysModel? addData) async {
    _repo.writeDayDataServer(
        dayData: addData ?? DaysModel(dayNumber: dayNumber));
    isPageLoading.value = false;
    Get.back();
  }

  @override
  void onInit() {
    dayNumber = Get.arguments;
    super.onInit();
  }
}
