part of 'services.dart';

class UserServices {
  static CollectionReference _userColloection =
      Firestore.instance.collection('users');

  static Future<void> updateUser(User user) async {
    _userColloection.document(user.id).setData({
      'email': user.email,
      'name': user.name,
      'balance': user.balance,
      'selectedGenres': user.selectedGenres,
      'selectedLanguage': user.selectedLanguage,
      'profilePicture': user.profilePicture ?? ""
    });
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userColloection.document(id).get();

    return User(id, snapshot.data['email'],
        balance: snapshot.data['balance'],
        profilePicture: snapshot.data['profilPicture'],
        selectedGenres: (snapshot.data['selectedGenres'] as List)
            .map((e) => e.toString())
            .toList(),
        selectedLanguage: snapshot.data['selectedLanguage'],
        name: snapshot.data['name']);
  }
}
