// abstract class LocalStorage {
//   Future<void> write(final String key, final dynamic json);
//   dynamic read<S>(final String key);
//   // List<S> readList<S>(
//   //   String key, {
//   //   Function(Map<String, dynamic>)? map,
//   //   Function(List<S> list)? construct,
//   // });
//   // dynamic readList(
//   //   String key, {
//   //   Function(List<dynamic>)? map,
//   // });
//   void remove(final String key);
//   void removeAll();
// }

// class StorageService implements LocalStorage {
//   StorageService() {
//     // _init();
//   }

//   // late GetStorage storage;

//   // void _init() {
//   //   storage = GetStorage();
//   // }

//   @override
//   Future<void> write(final String key, final dynamic value) async {
//     // await storage.write(key, convert.jsonEncode(value));
//   }

//   @override
//   dynamic read<S>(final String key) {
//     // final value = storage.read(key);
//     // if (value == null) return;
//     // return convert.jsonDecode(value.toString());
//   }

//   // @override
//   // readList<S>(String key, {Function(List<S>) construct}) {
//   //   final jsonArray = GetStorage().read(key);
//   //   final resourceName = S;
//   //   final List<S> list = [];
//   //   for (var item in convert.json.decode(jsonArray)) list.add(resourceName.fromJson(item));

//   //   return construct(list);
//   // }

//   @override
//   void remove(final String key) {
//     // GetStorage().remove(key);
//   }

//   @override
//   void removeAll() {
//     throw UnimplementedError();
//   }

//   // @override
//   // readList(
//   //   String key, {
//   //   dynamic Function(List<dynamic>)? map,
//   // }) {
//   //   final result = GetStorage().read(key);
//   //   if (result == null) return;
//   //   final jsonArray = convert.jsonDecode(result);
//   //   final list = jsonArray.toList();
//   //   return map?.call(list) ?? list;
//   // }
// }
