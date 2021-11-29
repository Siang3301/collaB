import 'dart:convert';

import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static User myUser = User(
    image:
        "https://www.iconspng.com/images/young-user-icon.jpg",
    name: 'Muhd Azaiman',
    email: 'devparty2021@gmail.com',
    phone: '(60) 11-65485427',
    aboutMeDescription:
        'Im secr student, i work with chen for this product, we are the dev tea party',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
