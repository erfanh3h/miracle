import 'package:refreshed/refreshed.dart';
import 'package:miracle/Features/days/Controllers/days.dart';
import 'package:miracle/Features/days/Core/days_repository.dart';

class DaysPageBinding implements BindingsInterface {
  @override
  dependencies() => [
        Get.put(
          DaysController(
            Get.find<DaysRepository>(),
          ),
          tag: Get.arguments.toString(),
        )
      ];
}
