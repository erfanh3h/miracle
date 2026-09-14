import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Core/delneveshteh_repository.dart';
import 'package:miracle/Models/delneveshteh_model.dart';
import 'package:getxify/getxify.dart';

class DelneveshtehController extends BaseController {
  final DelneveshtehRepository _repo = DelneveshtehRepository();

  DelneveshtehController();

  RxList<DelneveshtehModel> data = RxList([]);

  String? lastFetchId;
  RxString selectedCategory = RxString("");
  bool isLocked = false;
  Future readData({bool mustRefresh = false}) async {
    if (mustRefresh) {
      data.clear();
      lastFetchId = null;
      isLocked = false;
    }
    isPageLoading.value = true;
    var result = await _repo.getDelneveshtehList(
      categoryId: selectedCategory.value.isNotEmpty
          ? selectedCategory.value
          : null,
      cursorAfter: lastFetchId,
    );
    if (result.resultData != null) {
      data.addAll(result.resultData!);
      if (result.resultData!.isNotEmpty) {
        lastFetchId = result.resultData!.last.id;
      } else {
        isLocked = true;
      }
    }
    isPageLoading.value = false;
  }

  void onChangeCategory(String id) {
    selectedCategory.value = id;
    readData(mustRefresh: true);
  }

  @override
  void onInit() {
    readData();
    super.onInit();
  }
}
