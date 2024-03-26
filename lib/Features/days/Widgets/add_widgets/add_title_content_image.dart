import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Global/Core/global_repository.dart';
import 'package:miracle/Core/Global/Widgets/global_input_box.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';
import 'package:miracle/Features/days/Models/days.dart';

class AddTitleContentImageBox extends StatefulWidget {
  const AddTitleContentImageBox({
    Key? key,
    required this.ontapFunction,
    required this.dayNumber,
  }) : super(key: key);

  final Function ontapFunction;
  final int dayNumber;

  @override
  State<AddTitleContentImageBox> createState() =>
      _AddTitleContentImageBoxState();
}

class _AddTitleContentImageBoxState extends State<AddTitleContentImageBox> {
  Uint8List? image;
  bool isLoading = false;
  PlatformFile? selectedFile;
  final GlobalRepository _repo = Get.find<GlobalRepository>();
  changeImage() async {
    try {
      var fls = await FilePicker.platform.pickFiles(
        type: FileType.image,
        // allowedExtensions: ['jpg', 'jpeg', 'bmp', 'png'],
        allowMultiple: false,
        withData: true,
      );
      if (fls!.files.isNotEmpty) {
        setState(() {
          image = fls.files.first.bytes;
          selectedFile = fls.files.first;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleCtrl = TextEditingController();
    final TextEditingController contentCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Container(
      // height: 260,
      constraints: BoxConstraints(maxHeight: Get.height),
      padding: AppSpacings.s10All,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Form(
        key: formKey,
        child: Stack(
          children: [
            ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                image != null
                    ? InkWell(
                        // onTap: () => removeImage(context),
                        child: Container(
                          padding: AppSpacings.s10All,
                          margin: AppSpacings.s10Bottom,
                          decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //   color: AppColors.primary,
                              //   width: 2,
                              // ),
                              ),
                          child: Image.memory(
                            image!,
                            width: Get.width / 2,
                            height: Get.width / 2,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Container(
                        width: Get.width / 2,
                        height: Get.width / 2,
                        margin: AppSpacings.s10Bottom,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        child: TextButton(
                          onPressed: changeImage,
                          child: Text(
                            'ثبت عکس',
                            textDirection: TextDirection.rtl,
                            style: Get.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                GlobalInputBox(
                  label: 'عنوان',
                  controller: titleCtrl,
                  maxLines: 1,
                  validator: (String value) {
                    if ((value).isEmpty) {
                      return 'این فیلد را پر کنید';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: AppSpacings.s10Vertical,
                  child: GlobalInputBox(
                    label: 'توضیحات',
                    controller: contentCtrl,
                    minLines: 8,
                    validator: (String value) {
                      if ((value).isEmpty) {
                        return 'این فیلد را پر کنید';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            Visibility(
              visible: image != null,
              child: Positioned(
                bottom: 0,
                right: 0,
                child: FloatingActionButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    String imageId = '';
                    if (selectedFile != null) {
                      var response =
                          await _repo.uploadFile(fileData: selectedFile!);
                      if (response.resultData != null) {
                        imageId = response.resultData!;
                      } else {}
                    }
                    widget.ontapFunction(
                      DaysModel(
                        dayNumber: widget.dayNumber,
                        title: titleCtrl.text,
                        content: contentCtrl.text,
                        image: image,
                        imageId: imageId,
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.save,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
