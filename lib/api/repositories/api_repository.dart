import 'dart:async';
import 'package:meta/meta.dart';
import 'api_client.dart';

enum RequestType{ GET, POST, PUT, PATCH }

class ApiRepository {
  final ApiClient apiClient;

  ApiRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future fetchApi(String methods, {RequestType requestType = RequestType.GET}) async {
    return await apiClient.fetchApi(methods, requestType: requestType);
  }
}
