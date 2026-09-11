import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Core/delneveshteh_repository.dart';
import 'package:miracle/Models/delneveshteh_model.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Resources/app_consts.dart';
import 'package:miracle/Widgets/review_dialog.dart';

class DelneveshtehReadController extends BaseController {
  final DelneveshtehRepository _repo = DelneveshtehRepository();

  DelneveshtehReadController();

  late DelneveshtehModel data;

  void addReviewButton() {
    ReviewDialog(
      label: 'نظر شما',
      successLabel: 'نظرشماباموفقیت ارسال شد',
    ).showDialog(reviewType: ReviewTypes.delneveshteh, targetId: data.id);
  }

  @override
  void onInit() {
    data = Get.arguments;
    super.onInit();
  }
}
