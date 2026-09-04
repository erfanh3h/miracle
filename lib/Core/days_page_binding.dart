import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/days.dart';

class DaysPageBinding implements Binding {
  @override
  List<DaysController> dependencies() => [
    Get.put(DaysController(), tag: Get.arguments.toString()),
  ];
}
