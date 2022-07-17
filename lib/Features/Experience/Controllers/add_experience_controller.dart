import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Components/voice_recorder.dart';
import 'package:miracle/Features/Experience/Core/experience_repository.dart';
import 'package:miracle/Features/days/Models/days.dart';

class AddExperienceController extends BaseController {
  final ExperienceRepository _repo;

  late int dayNumber;
  VoiceRecorderComponent recorderComponent = VoiceRecorderComponent();
  AddExperienceController(this._repo);

  createData(DaysModel? addData) async {}
}
