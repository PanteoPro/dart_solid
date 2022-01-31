class Image {
  final int width;
  final int height;
  final ISave _saver;
  Image(this.width, this.height, this._saver);

  void saveTo(String path) {
    _saver.save(path, this);
  }
}

abstract class ISave {
  void save(String path, Image image);
}

class SaveToBMP implements ISave {
  @override
  void save(String path, Image image) {
    print('save image: ${image.width}, ${image.height} to bmp');
  }
}

class SaveToJPG implements ISave {
  @override
  void save(String path, Image image) {
    print('save image: ${image.width}, ${image.height} to jpg');
  }
}

class SaveToPNG implements ISave {
  @override
  void save(String path, Image image) {
    print('save image: ${image.width}, ${image.height} to png');
  }
}
