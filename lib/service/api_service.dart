import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe_app/core/constants/api_constants.dart';
import 'package:tic_tac_toe_app/service/socket_service.dart';

class ApiService {
  // Prefs
  static Future<void> savePrefs(String token) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('token') != null) {
        prefs.remove('token');
    }

    await prefs.setString('token', token);
  }

  static Future<String> get getToken  async{
     final SharedPreferences prefs = await SharedPreferences.getInstance();

     final token = prefs.getString('token');

     return token!; 
  }


  // LOGIN
  Future<String?> login(String email, String password) async {
    try {
      final url = Uri.parse('${ApiConstants.baseUri}/auth/login');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      final data = jsonDecode(response.body);

      final message = data['message'];

      if (response.statusCode == 200) {
        // Save the data in SharedPrefrence
        await savePrefs(data['token']);

        await SocketService().initializeSocket(data['token']);
       

        return null;
      }

      return message;
    } catch (e) {
      throw Exception(e);
    }
  }

  // REGISTER
  Future<String?> register(String username, String email, String password) async{
    try {
      final url = Uri.parse('${ApiConstants.baseUri}/auth/register');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      final message = data['message'];

      if (response.statusCode == 201) {
        return null;
      }

      return message;
    } catch (e) {
      throw Exception(e);
    }
  } 


  // CREATE ROOM
  Future<List<dynamic>> createRoom(String symbol) async{
    final roomData = [];
    try {
      final url = Uri.parse('${ApiConstants.baseUri}/rooms/create');

      final token = await getToken;

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
          },
        body: jsonEncode({
          "hostSymbol": symbol
        })
        );

    roomData.add(response.statusCode);
    final data = jsonDecode(response.body);
    roomData.add(data);

    return roomData;
    
    } catch (e){
      throw Exception(e);
    }
  }

  // JOIN ROOM
  Future<List<dynamic>> joinRoom(String roomCode) async{
    final roomData = [];
    try {
      final url = Uri.parse('${ApiConstants.baseUri}/rooms/join');

      final token = await getToken;

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'authorization': 'Bearer $token',
          },
        body: jsonEncode({
          "roomCode": roomCode
        })
        );

    roomData.add(response.statusCode);
    final data = jsonDecode(response.body);
    roomData.add(data);

    return roomData;
    
    } catch (e){
      throw Exception(e);
    }
  }

}
