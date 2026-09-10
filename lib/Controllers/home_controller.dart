import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_controller.dart';
import 'package:miracle/Routes/app_routes.dart';

class HomeController extends BaseController {
  RxInt activeTab = RxInt(1);
  void changeActiveTab(int index) {
    activeTab.value = index;
  }

  void goAddDelneveshteh() {
    Get.toNamed(AppRoutes.addDelneveshteh);
  }
}
