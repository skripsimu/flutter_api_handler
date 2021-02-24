import 'package:equatable/equatable.dart';

abstract class ApiEvent extends Equatable {
  const ApiEvent();
}

class FetchApi extends ApiEvent {
  const FetchApi();

  @override
  List<Object> get props => [];
}
