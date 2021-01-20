class Util {
  /// 判断字符串数组中是否存在目标字符串
  static bool isInList(List<String> l, String s) {
    bool isIn = false;

    for (int i = 0; i < l.length; i++) {
      if (s == l[i]) {
        isIn = true;
      }
    }

    return isIn;
  }

  /// 从文件路径中获取文件名，
  static String getFileName(String filePath) {
    String fileName = '';

    final int index = filePath.lastIndexOf('/');
    if (index >= 0 && index < filePath.length - 1) {
      fileName = filePath.substring(index + 1, filePath.length);
    }

    return fileName;
  }
}
