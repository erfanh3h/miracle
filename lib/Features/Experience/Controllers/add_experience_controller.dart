import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Base/base_controller.dart';
import 'package:miracle/Core/Components/image_compress.dart';
import 'package:miracle/Core/Components/show_message.dart';
import 'package:miracle/Core/Components/timer.dart';
import 'package:miracle/Core/Components/voice_recorder.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Features/Audio/Controllers/audio_controller.dart';
// import 'package:miracle/Core/Components/voice_recorder.dart';
import 'package:miracle/Features/Experience/Core/experience_repository.dart';
import 'package:miracle/Features/Experience/Models/experience.dart';

class AddExperienceController extends BaseController
    with GetSingleTickerProviderStateMixin {
  final ExperienceRepository _repo;
  final GlobalRepository _globalRepo;
  VoiceRecordereCompanent recorderComponent = VoiceRecordereCompanent();
  AddExperienceController(this._repo, this._globalRepo);

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

  RxBool letAddReview = RxBool(true);

  final formKey = GlobalKey<FormState>();

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

  sendData() async {
    if (!formKey.currentState!.validate() || isPageLoading.value) return;
    if (isVoiceExperience.value) {
      uploadWithVoice();
    } else {
      if (selectedFile.value != null) {
        uploadWithImage();
      } else {
        uploadNormal();
      }
    }
  }

  uploadWithVoice() async {
    if (selectedFile.value == null) {
      ShowMessageCompanent(message: 'لطفا وویس خود را ضبط کنید').show();
      return;
    } else {
      isPageLoading.value = true;
      String fileId = '';
      var fileUploadResult = await _globalRepo.uploadFile(
        fileData: selectedFile.value!,
      );
      if (fileUploadResult.resultData != null) {
        fileId = fileUploadResult.resultData!;
        var result = await _repo.sendExperience(
          experienceData: ExperienceModel(
            title: titleController.text,
            content: contentController.text,
            isVoice: isVoiceExperience.value,
            fileId: fileId,
            letReview: letAddReview.value,
          ),
        );
        if (result.resultData != null) {
          ShowMessageCompanent(
            message: 'تجربه شما ثبت و پس از بازبینی منتشر می شود',
            color: AppColors.green,
          ).show();
          Get.back();
        } else {
          isPageLoading.value = false;
        }
      }
    }
  }

  uploadWithImage() async {
    isPageLoading.value = true;
    String fileId = '';
    selectedFile.value =
        await ImageCompressorComponent(file: selectedFile.value).compress();
    var fileUploadResult = await _globalRepo.uploadFile(
      fileData: selectedFile.value!,
    );
    if (fileUploadResult.resultData != null) {
      fileId = fileUploadResult.resultData!;
      var result = await _repo.sendExperience(
        experienceData: ExperienceModel(
          title: titleController.text,
          content: contentController.text,
          isVoice: false,
          letReview: letAddReview.value,
          fileId: fileId,
        ),
      );
      if (result.resultData != null) {
        ShowMessageCompanent(
          message: 'تجربه شما ثبت و پس از بازبینی منتشر می شود',
          color: AppColors.green,
        ).show();
        Get.back();
      } else {
        isPageLoading.value = false;
      }
    }
  }

  uploadNormal() async {
    isPageLoading.value = true;
    var result = await _repo.sendExperience(
      experienceData: ExperienceModel(
        title: titleController.text,
        content: contentController.text,
        isVoice: false,
        letReview: letAddReview.value,
      ),
    );
    if (result.resultData != null) {
      ShowMessageCompanent(
        message: 'تجربه شما ثبت و پس از بازبینی منتشر می شود',
        color: AppColors.green,
      ).show();
      Get.back();
    } else {
      isPageLoading.value = false;
    }
  }

  changeImage() async {
    try {
      var fls = await FilePicker.platform.pickFiles(
        type: FileType.image,
        // allowedExtensions: ['jpg', 'jpeg', 'bmp', 'png'],
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

  changeLetAddReview(bool value) {
    letAddReview.value = value;
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
