import 'package:getxify/getxify.dart';
import 'package:miracle/Base/base_controller.dart';

class HomeController extends BaseController {
  RxInt activeTab = RxInt(1);
  void changeActiveTab(int index) {
    activeTab.value = index;
  }
}
