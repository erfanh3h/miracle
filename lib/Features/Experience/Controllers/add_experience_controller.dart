import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Components/timer.dart';
import 'package:miracle/Core/Components/voice_recorder.dart';
import 'package:miracle/Features/Audio/Controllers/audio_controller.dart';
// import 'package:miracle/Core/Components/voice_recorder.dart';
import 'package:miracle/Features/Experience/Core/experience_repository.dart';
import 'package:miracle/Features/days/Models/days.dart';

class AddExperienceController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final ExperienceRepository _repo;

  VoiceRecordereCompanent recorderComponent = VoiceRecordereCompanent();
  AddExperienceController(this._repo);

  Rx<PlatformFile?> selectedFile = Rx(null);
  RxBool isVoiceExperience = RxBool(true);
  RxBool isRecording = RxBool(false);
  RxBool isRecordingPaused = RxBool(false);
  RxBool isRecordingComplete = RxBool(false);

  TimerCompanent timer = Get.find<TimerCompanent>();

  late AnimationController animation;
  late Animation<double> fadeInFadeOut;

  @override
  void onInit() {
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    fadeInFadeOut = Tween<double>(begin: 0.0, end: 0.5).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();
    super.onInit();
  }

  void startRecord() async {
    isRecording.value = true;
    await recorderComponent.startRecorder();
    timer.startTimer(300);
  }

  void pauseRecord() {
    isRecordingPaused.value = true;
    timer.pauseTimer();
    recorderComponent.pauseRecorder();
  }

  void stopRecord() async {
    isRecording.value = false;
    timer.stopTimer();
    var resultPath = await recorderComponent.stopRecorder();
    File file = File(resultPath ?? '');
    print(file.lengthSync());
    selectedFile.value = PlatformFile(
      name: 'record.mp4',
      size: file.lengthSync(),
      bytes: file.readAsBytesSync(),
      path: resultPath,
    );
  }

  void unpauseRecord() {
    isRecordingPaused.value = false;
    timer.unpauseTimer();
  }

  void startPlay() async {
    var audioController = Get.find<AudioController>();
    await audioController.setSource(path: selectedFile.value!.path);
    audioController.play();
  }

  void pausePlay() async {
    var audioController = Get.find<AudioController>();
    audioController.pause();
  }

  createData(DaysModel? addData) async {}

  changeImage() async {
    try {
      var fls = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'bmp', 'png', 'webp'],
        allowMultiple: false,
        withData: true,
      );
      if (fls!.files.isNotEmpty) {
        selectedFile.value = fls.files.first;
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    animation.dispose();
    super.onClose();
  }
}
