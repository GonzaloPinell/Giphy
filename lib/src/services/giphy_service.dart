import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> giphyService() async {
  const String authority = 'api.giphy.com';

  const String unencodedPath = '/v1/gifs/trending';

  final Map<String, String> queryParameters = {
    'api_key': 'OIrOe183I0LQ7Uhwbppbydb55igyi2GT',
    'limit': '5',
    'offset': Random().nextInt(5000).toString(),
    'rating': 'r',
  };

  Map<String, dynamic> decodedResponse;

  final http.Response response = await http.get(
    Uri.https(
      authority,
      unencodedPath,
      queryParameters,
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=utf-8',
    },
  );

  print(response.body);

  try {
    decodedResponse = json.decode(response.body);
  } catch (exception) {
    return Future.error('Ocurrío un error');
  }

  return decodedResponse;
}
