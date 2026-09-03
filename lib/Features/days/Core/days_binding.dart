import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Features/days/Controllers/days_add.dart';
import 'package:miracle/Features/days/Controllers/days_show.dart';
import 'package:miracle/Features/days/Core/days_repository.dart';

class DaysBinding implements Binding {
  @override
  void dependencies() {
    Get.lazyPut<DaysRepository>(() => DaysRepositoryImp(), fenix: true);
    Get.lazyPut<DaysAddController>(
      () => DaysAddController(
        Get.find<DaysRepository>(),
        Get.find<GlobalRepository>(),
      ),
      fenix: true,
    );
    Get.lazyPut<DaysShowController>(
      () => DaysShowController(Get.find<DaysRepository>()),
      fenix: true,
    );
  }
}
