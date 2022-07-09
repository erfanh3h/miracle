import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  // late StreamSubscription<InternetConnectionStatus> _connectionListener;

  RxBool isPageLoading = RxBool(false);
  RxBool isPageLoadingMore = RxBool(false);
  RxStatus pageStatus = RxStatus.empty();

  showLoading() => isPageLoading.value = true;
  hideLoading() => isPageLoading.value = false;
}
