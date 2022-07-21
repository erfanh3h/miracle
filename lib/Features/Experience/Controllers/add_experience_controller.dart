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

class AddExperienceController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final ExperienceRepository _repo;

  VoiceRecordereCompanent recorderComponent = VoiceRecordereCompanent();
  AddExperienceController(this._repo);

  Rx<PlatformFile?> selectedFile = Rx(null);

  // check type is normal or with voice
  RxBool isVoiceExperience = RxBool(false);

  // check voice is recording or not
  RxBool isRecording = RxBool(false);

  // check recording is paused or not
  RxBool isRecordingPaused = RxBool(false);

  // check recording is completed or not
  RxBool isRecordingComplete = RxBool(false);

  TimerCompanent timer = Get.find<TimerCompanent>();

  late AnimationController animation;
  late Animation<double> fadeInFadeOut;

  AudioController? audioController;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

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
    timer.startTimer(300, endFunction: stopRecord);
  }

  void pauseRecord() {
    isRecordingPaused.value = true;
    timer.pauseTimer();
    recorderComponent.pauseRecorder();
  }

  void stopRecord() async {
    timer.stopTimer();
    var resultPath = await recorderComponent.stopRecorder();
    File file = File(resultPath ?? '');
    audioController = Get.find<AudioController>();
    selectedFile.value = PlatformFile(
      name: 'record.mp4',
      size: file.lengthSync(),
      bytes: file.readAsBytesSync(),
      path: resultPath,
    );
    await audioController!.setSource(path: selectedFile.value!.path);
    isRecording.value = false;
  }

  void unpauseRecord() async {
    isRecordingPaused.value = false;
    timer.unpauseTimer(endFunction: stopRecord);
    await recorderComponent.unPauseRecorder();
  }

  void deleteRecord() {
    isRecording.value = false;
    isRecordingPaused.value = false;
    isRecordingComplete.value = false;
    selectedFile.value = null;
  }

  // void startPlay() async {
  //   audioController!.play();
  // }

  // void pausePlay() async {
  //   // audioController = Get.find<AudioController>();
  //   audioController!.pause();
  // }

  // void unPausePlay() async {
  //   // audioController = Get.find<AudioController>();
  //   audioController!.unPause();
  // }

  createData() async {}

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

  changeFileType() {
    deleteRecord();
    isVoiceExperience.value = !isVoiceExperience.value;
  }
  // @override
  // void dispose() {
  //   animation.dispose();
  //   super.dispose();
  // }

  @override
  void onClose() {
    animation.dispose();
    try {
      audioController!.stop();
    } catch (_) {}
    try {
      recorderComponent.release();
    } catch (_) {}
    super.onClose();
  }
}
