import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/days_add.dart';
import 'package:miracle/Controllers/days_show.dart';

class DaysAddBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<DaysAddController>(() => DaysAddController(), fenix: true);
  }
}

class DaysShowBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<DaysShowController>(() => DaysShowController(), fenix: true);
  }
}
