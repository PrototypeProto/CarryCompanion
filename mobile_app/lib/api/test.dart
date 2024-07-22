import 'dart:convert';
import 'dart:developer';

import 'api.dart';

void main(List<String> args) async {
  // ApiService serv = ApiService(baseUrl: "http://localhost:5000");
  ApiService serv =
      ApiService(baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com");

  String jwt = ''; // grab on Login

  /* Sample weapon Map */
  Map<String, dynamic> weaponData = {
    "type": "Pistol",
    "datePurchased": "111",
    "manufacturer": "Magnum Research",
    "model": "Desert Eagle"
  };

  /* VARIABLES USED FOR TESTING */
  String validUser = 'a';
  String validPass = '11111111';

  /* Change current password VARIABLES */
  String curPass = "11111111";
  String newPass = '1111111';

  /* SIGN UP VARIABLES */
  String user = 'aaaa';
  String fname = 'hey';
  String lname = 'mam';
  String email = 'bobbbdl@dsaffi.com';
  String newEmail = "genomegalul@gmail.com";
  String pwd = 'Test123!';
  String weaponID = '669da9e43c8c69202d1eabc8';

  /* Test LOGIN, REQUIRED*/
  Map<String, dynamic> ret =
      await serv.login({"username": validUser, "password": validPass});
  try {
    print('');
    if (ret['success']) {
      jwt = ret['data']['token'];
      print('Login successful. Token: $jwt');
      print('\nUser:');
      ret['data']['user'].forEach((key, value) {
        print('$key: $value');
      });
    } else {
      print('Login failed: ${ret['message']}');
    }
  } catch (e) {
    print('Error: $e');
  }
    print('');
}


  /* Test SIGNUP*/
  // try {
  //   Map<String, dynamic> ret = await serv.signup({
  //     "username": user,
  //     "password": newPass,
  //     "firstName": fname,
  //     "lastName": lname,
  //     "email": email,
  //     "verification": false,
  //   });
  //   // Properly print the response
  //   if (ret['success']) {
  //     print('Signup response: ${ret['data']['message']}');
  //   } else {
  //     print('Signup failed: ${ret['message']}');
  //   }
  // } catch (e) {
  //   print('Error: $e');
  // }

  /* reset password */
  // try {
  //   Map<String, dynamic> ret = await serv.resetPassword({"currentPassword": curPass, "newPassword": newPass}, jwt);

  //   if (ret['success']) {
  //     print('Password reset successful. Response data: ${ret['data']['message']}');
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

  // /* verify email TODO: IDK IF WE NEED IT */
  // try {
  //   Map<String, dynamic> ret = await serv.verifyEmail(jwt);

  //   if (ret['success']) {
  //     print('Email verification successful. Response data: ${ret['data']['message']}');
  //   } else {
  //     print('Email verification failed: ${ret['message']}');
  //   }
  // } catch (e) {
  //   print('Error: $e');
  // }

  // /* Forgot passowrd wip TODO: FIX */
  // try {
  //   Map<String, dynamic> ret = await serv.forgotPassword(email);

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
  //   Map<String, dynamic> ret = await serv.addWeapon(weaponData, jwt);

  //   if (ret['success']) {
  //     print('Weapon added successfully. Response data: \n${ret["data"]["weapon"]["_id"]}');
  //     print('Weapon added successfully. Response data: \n${ret["data"]["weapon"]}');
  //   } else {
  //     print('Failed to add weapon: ${ret['message']}');
  //   }
  // } catch (e) {
  //   print('Error: $e');
  // }

  // /* TODO: FIX  */
  // try {
  //   Map<String, dynamic> ret = await serv.editWeapon(weaponID, weaponData, jwt);

  //   if (ret['success']) {
  //     print('Weapon edited successfully. Response data: ${ret["message"]}');
  //   } else {
  //     print('Failed to edit weapon: ${ret["message"]}');
  //   }
  // } catch (e) {
  //   print('Error: $e');
  // }

  // /* TODO: FIX */
  // try {
  //   await serv.deleteWeapon(weaponID, jwt);
  //   print('Weapon deleted successfully.');
  // } catch (e) {
  //   print('Error: $e');
  // }

  // /* works  */
  // try {
  //   List<dynamic> weapons = await serv.searchWeapons('', jwt);
  //   print('Weapons found: ${weapons}');
  // } catch (e) {
  //   print('Error: $e');
  // }

