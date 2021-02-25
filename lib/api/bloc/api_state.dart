import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class IsEmpty extends ApiState {}

class IsLoading extends ApiState {}

class IsLoaded extends ApiState {
  final response;

  const IsLoaded({@required this.response}) : assert(response != null);

  @override
  List<Object> get props => [response];
}

class IsError extends ApiState {}

class IsNetworkError extends ApiState {}
