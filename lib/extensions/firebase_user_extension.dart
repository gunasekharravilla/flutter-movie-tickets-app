part of 'extensions.dart';

extension FirebaseUserExtension on auth.User {
  User convertToUser(
          {String name = "No Name",
          List<String> selectedGenres = const [],
          String selectedLanguage = "English",
          int balance = 0}) =>
      User(this.uid, this.email,
          name: name,
          balance: balance,
          selectedGenres: selectedGenres,
          selectedLanguage: selectedLanguage);

  Future<User> fromFireStore() async => await UserServices.getUser(this.uid);
}
