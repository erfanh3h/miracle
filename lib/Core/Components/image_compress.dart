import 'package:file_picker/file_picker.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

class ImageCompressorComponent {
  final PlatformFile? file;

  ImageCompressorComponent({
    required this.file,
  });

  Future<PlatformFile> compress() async{
    ImageFile input = ImageFile(
      filePath: file!.path!,
      rawBytes: file!.bytes!,
    ); // set the input image file
    Configuration config = const Configuration(
      // outputType: ImageOutputType.webpThenJpg,
      // can only be true for Android and iOS while using ImageOutputType.jpg or ImageOutputType.pngÏ
      useJpgPngNativeCompressor: false,
      // set quality between 0-100
      quality: 35,
    );

    final param = ImageFileConfiguration(input: input, config: config);
    final output = await compressor.compress(param);

    // print("Input size : ${input.sizeInBytes}");
    // print("Output size : ${output.sizeInBytes}");
    return PlatformFile(
      name: 'name',
      size: output.sizeInBytes,
      path: output.filePath,
      bytes: output.rawBytes,
    );
  }
}
