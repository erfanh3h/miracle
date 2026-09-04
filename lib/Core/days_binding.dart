import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/days_add.dart';
import 'package:miracle/Controllers/days_show.dart';

class DaysBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<DaysAddController>(() => DaysAddController(), fenix: true);
    Get.lazyPut<DaysShowController>(() => DaysShowController(), fenix: true);
  }
}
