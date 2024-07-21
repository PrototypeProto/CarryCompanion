import 'api.dart';

void main(List<String> args) async {
  // ApiService serv = ApiService(baseUrl: "http://localhost:5000");
  ApiService serv = ApiService(baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com");
  
  String jwt = ''; 

 String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2N2UwM2U0MzI1YmVmNGRmYzc3NzY2NyIsInVzZXJuYW1lIjoiVGVzdGluZyIsImlhdCI6MTcyMTUxNTE5NCwiZXhwIjoxNzIxNTE4Nzk0fQ.EvJERn9BFw3VmNaW-GnGiKf--2T_ALHjJKhgu6M6R0w"; 
  Map<String, dynamic> weaponData = {
    "_id": "669b294389d8d5154e22bdfa",
    "type": "Stratagem",
    "datePurchased": "111",
    "manufacturer": "Super Earth",
    "model": "Supply Pack"
  };
  


  try {
    Map<String, dynamic> ret = await serv.login({"username" : "testUser00", "password" : "Password123!"});
    jwt = ret['token'];
    // print(jwt);
    print(ret);
    
  } catch (e) {
    print('Error: $e');
  }
  // try {
  //   List ret = await serv.searchWeapons('', jwt);
  //   print(ret);
  // } catch (e) {
  //   print('Error: $e');
  // }

  // print(await serv.addWeapon(weaponData, token));

}