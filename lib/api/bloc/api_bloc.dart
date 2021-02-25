import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_handler/api/repositories/api_client.dart';
import 'package:flutter_api_handler/api/repositories/repositories.dart';
import 'package:flutter_api_handler/api/bloc/bloc.dart';
import 'package:flutter_api_handler/common/common.dart';


class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final ApiRepository repository = ApiRepository(apiClient: ApiClient());
  final String methods;
  final BuildContext context;
  RequestType requestType = RequestType.GET;

  ApiBloc({this.methods, this.requestType, this.context}) : assert(methods != null), super(ApiEmpty());
  @override
  Stream<ApiState> mapEventToState(ApiEvent event) async* {
    if (event is FetchApi) {
      yield ApiLoading();
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          try {
            final response = await repository.fetchApi(methods, requestType: requestType);
            yield ApiLoaded(response: response);
          } catch (_) {
            Utility.customToast(context, message: 'Error connection with server, please try again later');
            yield ApiError();
          }
        }
      } catch (_) {
        Utility.customToast(context, message: 'No internet connection, please try again later');
        yield ApiNetworkError();
      }
    }
  }
}
