import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

class MyCameraDelegate extends ImagePickerCameraDelegate {
  dynamic _takeAPhoto;
  dynamic _takeAVideo;

  @override
  Future<XFile?> takePhoto(
      {ImagePickerCameraDelegateOptions options =
      const ImagePickerCameraDelegateOptions()}) async {
    return _takeAPhoto(options.preferredCameraDevice);
  }

  @override
  Future<XFile?> takeVideo(
      {ImagePickerCameraDelegateOptions options =
      const ImagePickerCameraDelegateOptions()}) async {
    return _takeAVideo(options.preferredCameraDevice);
  }
}
// ···
void setUpCameraDelegate() {
  final ImagePickerPlatform instance = ImagePickerPlatform.instance;
  if (instance is CameraDelegatingImagePickerPlatform) {
    instance.cameraDelegate = MyCameraDelegate();
  }
}