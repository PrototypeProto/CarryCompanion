import 'dart:convert';
import 'dart:developer';

import 'api.dart';

void main(List<String> args) async {
  // ApiService serv = ApiService(baseUrl: "http://localhost:5000");
  // ApiService serv = ApiService(baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com");
  ApiService serv = ApiService(baseUrl: "http://www.thisisforourclass.xyz");

  String jwt = '';

  /* armory stuff */
  String weaponID = '669e9b109ce260e59fac03a6';

  Map<String, dynamic> weaponData = {
    "type": "Rifle",
    "datePurchased": "111",
    "manufacturer": "Kalashnikov Concern",
    "model": "Avtomat Kalashnikova"
  };

  Map<String, dynamic> newWeaponData = {
    "type": "Handgun",
    "datePurchased": "111",
    "manufacturer": "Magnum Research Park",
    "model": "Desert Eagle 55"
  };

/* VARIABLES USED FOR TESTING */
  String validUser = 'a';
  String validPass = '11111111';
/* Change current password VARIABLES */
  String curPass = "11111111";
  String newPass = '1111111';

  /* SIGN UP VARIABLES */
  String newUsername = 'aaaaaaa';
  String fname = 'hey';
  String lname = 'mam';
  String email = 'bobbbdl@dsaffi.com';
  String newEmail = "genoamedsdsgalul@gmail.com";
  String pwd = 'Test123!';

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
    print('');
  }

  // signup(newUsername, newPass, fname, lname, newEmail);
  // resetPassword(curPass, newPass, jwt);
  // forgotPassword(email);
  // addWeapon(weaponData, jwt);
  // editWeapon(weaponID, newWeaponData, jwt);

  // deleteWeapon(weaponID, jwt);
  // searchWeapon("", jwt);
  forgotPassword("carrycompanion@gmail.com");
}

Future<void> resetPassword(String curPass, String newPass, String jwt) async {
    ApiService serv = ApiService(baseUrl: "http://www.thisisforourclass.xyz");

  try {
    print('');
    Map<String, dynamic> ret = await serv.resetPassword(
        {"currentPassword": curPass, "newPassword": newPass}, jwt);
    if (ret['success']) {
      print(
          'Password reset successful. Response data: ${ret['data']['message']}');
    } else {
      print('Password reset failed: ${ret['message']}');
    }
  } catch (e) {
    print('Error: $e');
  }
  print('');
}

/* Test SIGNUP*/
Future<void> signup(String username, String newPass, String fname, String lname,
    String email) async {
  print('');
    ApiService serv = ApiService(baseUrl: "http://www.thisisforourclass.xyz");


  try {
    Map<String, dynamic> ret = await serv.signup({
      "username": username,
      "password": newPass,
      "firstName": fname,
      "lastName": lname,
      "email": email,
      "verification": false,
    });
    // Properly print the response
    if (ret['success']) {
      print('Signup response: ${ret['data']['message']}');
    } else {
      print('Signup failed: ${ret['message']}');
    }
  } catch (e) {
    print('Error: $e');
  }
  print('');
}


// /* Forgot passowrd wip TODO: FIX */
void forgotPassword(String email) async {
  // ApiService serv =
  // ApiService(baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com");
  ApiService serv = ApiService(baseUrl: "http://www.thisisforourclass.xyz");

  try {
    print('');
    Map<String, dynamic> ret = await serv.forgotPassword(email);

    if (ret['success']) {
      print(
          'Password reset request successful. Response data: ${ret['data']['message']}');
    } else {
      print('Password reset request failed: ${ret['message']}');
    }
  } catch (e) {
    print('Error: $e');
  }
  print('');
}

/* Add weapon to user  */
void addWeapon(Map<String, dynamic> weaponData, String jwt) async {
    ApiService serv = ApiService(baseUrl: "http://www.thisisforourclass.xyz");


  try {
    print('');
    Map<String, dynamic> ret = await serv.addWeapon(weaponData, jwt);

    if (ret['success']) {
      print(
          'Weapon added successfully. _id data: \n${ret["data"]["weapon"]["_id"]}');
      print('');
      // print('Weapon added successfully. Response data: \n${ret["data"]["weapon"]}');
      ret['data']['weapon'].forEach((key, value) {
        print('$key: $value');
      });
    } else {
      print('Failed to add weapon: ${ret['message']}');
    }
  } catch (e) {
    print('Error: $e');
  }
  print('');
}

/* edit user weapon  */
void editWeapon(
    String weaponID, Map<String, dynamic> newWeaponData, String jwt) async {
    ApiService serv = ApiService(baseUrl: "http://www.thisisforourclass.xyz");


  try {
    print('');
    Map<String, dynamic> ret =
        await serv.editWeapon(weaponID, newWeaponData, jwt);

    if (ret['success']) {
      // print('Weapon edited successfully. Response data: ${ret["data"]["message"]}');
      // print('');
      ret['data']['weapon'].forEach((key, value) {
        print('$key: $value');
      });
    } else {
      print('Failed to edit weapon: ${ret["message"]}');
    }
  } catch (e) {
    print('Error: $e');
  }
  print('');
}

void deleteWeapon(String weaponID, String jwt) async {
    ApiService serv = ApiService(baseUrl: "http://www.thisisforourclass.xyz");

  try {
    print('');
    await serv.deleteWeapon(weaponID, jwt);
    print('Weapon deleted successfully.');
  } catch (e) {
    print('Error: $e');
  }
  print('');
}

// /* TODO: FIX */

// /* works  */
void searchWeapon(String query, String jwt) async {
    ApiService serv = ApiService(baseUrl: "http://www.thisisforourclass.xyz");

  print('');
  try {
    List<dynamic> ret = await serv.searchWeapons(query, jwt);
    print('Weapons found: ${ret.length}');
    print('');
    for (int i = 0; i < ret.length; i++) {
      print("Weapon $i");
      ret[i].forEach((key, value) {
        print('$key: $value');
      });
      print('');
    }
  } catch (e) {
    print('Error: $e');
  }
  print('');
}
 
 
/* UNUSED APIS */

  // /* reset email - prob not using */
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

    // /* verify email : IDK IF WE NEED IT */
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