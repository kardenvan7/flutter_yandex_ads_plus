class UniqueIdGenerator {
  const UniqueIdGenerator._();

  static String generate() {
    return DateTime.now().hashCode.toString();
  }
}
