import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  Future<XFile?> pickImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        return pickedFile;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

// ^ Gallery
  Future<XFile?> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        return pickedFile;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
