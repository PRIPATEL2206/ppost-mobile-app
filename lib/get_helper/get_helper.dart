class GetHelper {
  static final List _geterClasses = [];

  static bool put(Object object) {
    for (var element in _geterClasses) {
      if (element.runtimeType == object.runtimeType) {
        return false;
      }
    }
    _geterClasses.add(object);
    return true;
  }

  static T? get<T>() {
    for (var element in _geterClasses) {
      if (T == element.runtimeType) {
        // print("get class From Get is $element");
        return element as T;
      }
    }
    return null;
  }
}
