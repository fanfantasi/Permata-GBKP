const String fileImage = "image";
const String fileVideo = "video";
const String fileTypeFile = "file";

class Utilities {
  static String getFileType(String _extension) {
    List<String> imageExt = ['png', 'jpg', 'jpeg'];
    List<String> videoExt = ['mov', 'mp4', 'mpeg', 'mkv', 'webm', 'flv', 'wmv'];
    if (imageExt.contains(_extension.toLowerCase())) {
      return fileImage;
    } else if (videoExt.contains(_extension.toLowerCase())) {
      return fileVideo;
    } else {
      return fileTypeFile;
    }
  }
}
