import 'package:getxify/getxify.dart';
import 'package:miracle/Controllers/days.dart';
import 'package:miracle/Core/days_repository.dart';

class DaysPageBinding implements Binding {
  @override
  List<DaysController> dependencies() => [
    Get.put(
      DaysController(Get.find<DaysRepository>()),
      tag: Get.arguments.toString(),
    ),
  ];
}
