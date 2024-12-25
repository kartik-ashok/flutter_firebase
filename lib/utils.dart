import 'package:uuid/uuid.dart';

class UtilityFunctions {
  static String generateUniqueId() {
    var uuid = Uuid(); // Create an instance of Uuid
    return uuid.v4(); // Generate a random unique ID (v4 UUID)
  }
}
