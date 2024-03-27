import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Features/days/Controllers/days_add.dart';
import 'package:miracle/Features/days/Controllers/days_show.dart';
import 'package:miracle/Features/days/Core/days_repository.dart';

class DaysBinding implements BindingsInterface {
  @override
  void dependencies() => [
        Get.lazyPut<DaysRepository>(
          () => DaysRepositoryImp(),
          fenix: true,
        ),
        Get.lazyPut<DaysAddController>(
          () => DaysAddController(
            Get.find<DaysRepository>(),
            Get.find<GlobalRepository>(),
          ),
          fenix: true,
        ),
        Get.lazyPut<DaysShowController>(
          () => DaysShowController(Get.find<DaysRepository>()),
          fenix: true,
        ),
      ];
}
