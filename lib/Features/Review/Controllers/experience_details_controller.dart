import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';

class ReviewController extends BaseController {
  final ReviewRepository _repo;

  ReviewController(this._repo);
}
