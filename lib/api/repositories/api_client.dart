import 'dart:convert';
import 'package:flutter_api_handler/api/config.dart';
import 'package:http/http.dart' as http;

enum RequestType{ GET, POST, PUT, PATCH }

class ApiClient {
  final http.Client httpClient = http.Client();

  Future fetchApi(String methods, {RequestType requestType = RequestType.GET}) async {
    final url = '${Config.baseUrl}/$methods';
    var response = await this.httpClient.get(url);
    switch (requestType) {
      case RequestType.GET:
      response = await this.httpClient.get(url);
      break;
      case RequestType.POST:
      response = await this.httpClient.post(url);
      break;
      case RequestType.PUT:
      response = await this.httpClient.put(url);
      break;
      case RequestType.PATCH:
      response = await this.httpClient.patch(url);
      break;
      return response;
    }
    print(response.statusCode);
    print(response.request);
    print(response.body);

    if (response.statusCode != 200) {
      throw new Exception('error getting Api');
    }

    final json = jsonDecode(response.body);
    return json;
  }
}
