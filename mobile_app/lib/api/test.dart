import 'api.dart';

void main(List<String> args) async {
  ApiService serv = ApiService(baseUrl: "http://localhost:5000");
  ApiService servAuthenticated = ApiService(baseUrl: "http://localhost:5000");
  
  String jwt = ''; 

  try {
    Map<String, dynamic> ret = await serv.login({"username" : "testUser", "password" : "Test123!"});
    jwt = ret['token'];
    print(jwt);
    print(ret);
    
  } catch (e) {
    print('Error: $e');
  }
  try {
    List ret = await serv.searchWeapons('', jwt);
    print(ret);
  } catch (e) {
    print('Error: $e');
  }

  

}