// import 'dart:async';

// import 'package:get/get.dart';

// import 'storege_service.dart';

// class LocalizeStoreService extends GetxController {
//   LocalizeStoreService(this._storage);

//   final LocalStorage _storage;
//   static const lang = 'LANG';
//   static const langResource = 'LANGRESOURCE';

//   static LocalizeStoreService get to => Get.find();

//   Future<LocalizeStoreService> init() async {
//     return this;
//   }

//   Map<String, dynamic> get languages =>
//       _storage.read(langResource) as Map<String, dynamic>;
//   set languages(final Map langs) => _storage.write(langResource, langs);
// }
