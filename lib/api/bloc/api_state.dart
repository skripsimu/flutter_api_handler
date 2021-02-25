import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class ApiEmpty extends ApiState {}

class ApiLoading extends ApiState {}

class ApiLoaded extends ApiState {
  final response;

  const ApiLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class ApiError extends ApiState {}

class ApiNetworkError extends ApiState {}
