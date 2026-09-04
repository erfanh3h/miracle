import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:miracle/Widgets/global/global_loading_widget.dart';
import 'package:miracle/Controllers/days_add.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Widgets/global/global_input_box.dart';
import 'package:miracle/Resources/app_colors.dart';
import 'package:miracle/Resources/app_spacings.dart';
import 'package:miracle/Models/days.dart';

class AddTitleContentImageBox extends StatefulWidget {
  const AddTitleContentImageBox({super.key, required this.controller});

  final DaysAddController controller;

  @override
  State<AddTitleContentImageBox> createState() =>
      _AddTitleContentImageBoxState();
}

class _AddTitleContentImageBoxState extends State<AddTitleContentImageBox> {
  Uint8List? image;
  bool isLoading = false;
  PlatformFile? selectedFile;
  Future<void> changeImage() async {
    try {
      var fls = await FilePicker.pickFile(
        type: FileType.image,
        // allowedExtensions: ['jpg', 'jpeg', 'bmp', 'png'],
      );
      if (fls != null) {
        image = await fls.xFile.readAsBytes();
        setState(() {
          selectedFile = fls;
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
      constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
      padding: AppSpacings.s10All,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
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
                          child: Image.memory(
                            image!,
                            width: MediaQuery.sizeOf(context).width / 2,
                            height: MediaQuery.sizeOf(context).width / 2,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.sizeOf(context).width / 2,
                        height: MediaQuery.sizeOf(context).width / 2,
                        margin: AppSpacings.s10Bottom,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.theme.inputDecorationTheme.fillColor,
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
                            style: Get.context!.textTheme.bodyLarge,
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
                left: 0,
                right: 0,
                child: Obx(
                  () => widget.controller.isUploadingImage.value
                      ? const Center(child: GlobalLoadingWidget())
                      : FloatingActionButton(
                          onPressed: () async {
                            if (!formKey.currentState!.validate()) return;
                            widget.controller.createData(
                              DaysModel(
                                dayNumber: widget.controller.dayNumber,
                                title: titleCtrl.text,
                                content: contentCtrl.text,
                                image: image,
                              ),
                              uploadFile: selectedFile,
                            );
                          },
                          child: const Icon(Icons.save, color: AppColors.white),
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
