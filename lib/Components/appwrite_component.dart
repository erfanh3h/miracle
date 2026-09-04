import 'package:appwrite/appwrite.dart' as ap;
import 'package:miracle/Routes/server_routes.dart';

class AppwriteComponent {
  AppwriteComponent._();

  static final AppwriteComponent instance = AppwriteComponent._();

  late ap.Client client;

  void init() {
    client = ap.Client();
    client
        .setEndpoint(ServerRoutes.appwriteBaseUrl)
        .setProject(ServerRoutes.appwriteProjectId);
  }
}
