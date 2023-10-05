extension ObjectExt<T> on T {
  R let<R>(R Function(T value) op) => op(this);
}