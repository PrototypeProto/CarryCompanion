import 'api.dart';

void main(List<String> args) async {
  ApiService serv = ApiService(baseUrl: "https://carry-companion-02c287317f3a.herokuapp.com");
  
  try {
    Map<String, dynamic> ret = await serv.login({"username" : "Testing", "password" : "Testing420!"});
    print(ret);
  } catch (e) {
    print('Error: $e');
  }

}