import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Core/delneveshteh_repository.dart';
import 'package:miracle/Models/delneveshteh_model.dart';
import 'package:getxify/getxify.dart';

class DelneveshtehController extends BaseController {
  final DelneveshtehRepository _repo = DelneveshtehRepository();

  DelneveshtehController();

  RxList<DelneveshtehModel> data = RxList([]);

  Future readData() async {
    isPageLoading.value = true;
    var result = await _repo.getDataServer();
    if (result.resultData != null) {
      data.addAll(result.resultData!);
    }
    isPageLoading.value = false;
  }

  void onTapAdd() {}

  @override
  void onInit() {
    readData();
    super.onInit();
  }
}
