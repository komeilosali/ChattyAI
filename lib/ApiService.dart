import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTModel {
  String message;
  String sender;

  ChatGPTModel({
    required this.message,
    required this.sender,
  });
}

class ChatGPT {
  static const String apiUrl = "https://api.openai.com/v1/";

  final String apiKey;

  ChatGPT(this.apiKey);

  // Future because we should wait for response (api key), await and async use together, we wait for response
  Future<String> sendMessage(String message) async {
    final response = await http.post(Uri.parse('${apiUrl}completions'),
        //https://api.openai.com/v1/completions
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "text-davinci-003",
          'prompt': message, //message(command) that we send in app to ai.
          'temperature': 0.5,
          'max_tokens': 2000,
        }));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      var finalResponse = jsonResponse['choices'][0]['text'].toString();
      print(finalResponse);
      return finalResponse;
    } else {
      print(response.statusCode);
      throw Exception('Error');
    }
  }
}
