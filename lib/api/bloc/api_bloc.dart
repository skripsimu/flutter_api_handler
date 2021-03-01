import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_handler/api/repositories/repositories.dart';
import 'package:flutter_api_handler/api/bloc/bloc.dart';
import 'package:flutter_api_handler/common/common.dart';


class ApiBloc extends Bloc<ApiEvent, ApiState> {
  final String methods;
  final BuildContext context;
  final bool showSuccessToast;
  RequestType requestType = RequestType.GET;
  ApiClient apiClient = ApiClient();

  ApiBloc({this.methods, this.requestType, this.context, this.showSuccessToast = false}) : assert(methods != null), super(IsEmpty());
  @override
  Stream<ApiState> mapEventToState(ApiEvent event) async* {
    if (event is FetchApi) {
      yield IsLoading();
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          try {
            final response = await apiClient.fetchApi(methods, requestType: requestType);
            if (showSuccessToast) {
              Utility.customToast(context, message: 'Post "${response['title']}" Successfully!', color: Colors.green);
            }
            yield IsLoaded(response: response);
          } catch (_) {
            Utility.customToast(context, message: 'Error connection with server, please try again later');
            yield IsError();
          }
        }
      } catch (_) {
        Utility.customToast(context, message: 'No internet connection, please try again later');
        yield IsNetworkError();
      }
    }
  }
}
