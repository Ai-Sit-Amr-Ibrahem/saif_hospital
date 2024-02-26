import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class ImageHelper {
  static Future<FormData> getFormData({imageFile}) async {
    return FormData.fromMap(
      {
        if (imageFile != null)
          'image': MultipartFile.fromFileSync(
            imageFile!.path,
            filename: imageFile!.path.split('/').last,
            contentType: MediaType("image", imageFile!.path.split(".").last),
          ),
      },
    );
  }
}
