import 'dart:convert';
import 'dart:developer';

import 'api.dart';

void main(List<String> args) async {
  ApiService serv = ApiService(baseUrl: "http://localhost:5000");
  // ApiService serv = ApiService(baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com");

  String jwt = '';

  Map<String, dynamic> weaponData = {
    "_id": "669b294389d8d5154e22bdfa",
    "type": "Stratagem",
    "datePurchased": "111",
    "manufacturer": "Super Earth",
    "model": "Supply Pack"
  };

  String validUser = 'a';
  String validPass = 'a';

  String curPass = "Test123!";
  String newPass = 'Test1234!';
  String user = 'testUser';
  String fname = 'hey';
  String lname = 'mam';
  String email = 'bobbbdl@ffi.com';
  String newEmail = "genomegalul@gmail.com";
  String pwd = 'Test123!';

  /* Test LOGIN*/
  Map<String, dynamic> ret = await serv.login({"username": user, "password": curPass});
  try {
    if (ret['success']) {
      jwt = ret['data']['token'];
      print('Login successful. Token: $jwt');
      // print('Response data: ${ret['data']}');
    } else {
      print('Login failed: ${ret['message']}');
    }
  } catch (e) {
    print('Error: $e');
  }

  /* Test SIGNUP*/
  // try {
  //   Map<String, dynamic> ret = await serv.signup({
  //     "username": user,
  //     "password": pwd,
  //     "firstName": fname,
  //     "lastName": lname,
  //     "email": email,
  //     "verification": false,
  //   });

  //   // Properly print the response
  //   print('Signup response: $ret');
  // } catch (e) {
  //   print('Error: $e');
  // }

  /* reset password */
  // try {
  //   Map<String, dynamic> ret = await serv.resetPassword({"currentPassword": curPass, "newPassword": newPass}, jwt);

  //   if (ret['success']) {
  //     print('Password reset successful. Response data: ${ret['data']}');
  //   } else {
  //     print('Password reset failed: ${ret['message']}');
  //   }
  // } catch (e) {
  //   print('Error: $e');
  // }

  // /* reset email */
  // try {
  //   ret = await serv.resetEmail({ "password": curPass, "newEmail": newEmail}, jwt);

  //   if (ret['success']) {
  //     print('Email reset successful. Response data: \n${ret['data']['message']}');
  //   } else {
  //     print('Email reset failed: ${ret['message']}');
  //   }
  // } catch (e) {
  //   print('Error: $e');
  // }

  // /* reset  */
  try {
    Map<String, dynamic> ret = await serv.verifyEmail(jwt);

    if (ret['success']) {
      print('Email verification successful. Response data: ${ret['data']['message']}');
    } else {
      print('Email verification failed: ${ret['message']}');
    }
  } catch (e) {
    print('Error: $e');
  }

  // /* reset  */
  // try {
  //   Map<String, dynamic> ret = await serv.forgotPassword(emailData);

  //   if (ret['success']) {
  //     print('Password reset request successful. Response data: ${ret['data']}');
  //   } else {
  //     print('Password reset request failed: ${ret['message']}');
  //   }
  // } catch (e) {
  //   print('Error: $e');
  // }

  // /* reset  */
  // try {
  //   Map<String, dynamic> ret = await serv.addWeapon(weaponData, token);

  //   if (ret['success']) {
  //     print('Weapon added successfully. Response data: ${ret['data']}');
  //   } else {
  //     print('Failed to add weapon: ${ret['message']}');
  //   }
  // } catch (e) {
  //   print('Error: $e');
  // }

  // /* reset  */
  // try {
  //   Map<String, dynamic> ret = await serv.editWeapon(id, weaponData, token);

  //   if (ret['success']) {
  //     print('Weapon edited successfully. Response data: ${ret['data']}');
  //   } else {
  //     print('Failed to edit weapon: ${ret['message']}');
  //   }
  // } catch (e) {
  //   print('Error: $e');
  // }

  // /* reset  */
  // try {
  //   await serv.deleteWeapon(id, token);
  //   print('Weapon deleted successfully.');
  // } catch (e) {
  //   print('Error: $e');
  // }

  // /* reset  */
  // try {
  //   List<dynamic> weapons = await serv.searchWeapons(query, token);
  //   print('Weapons found: $weapons');
  // } catch (e) {
  //   print('Error: $e');
  // }
}
