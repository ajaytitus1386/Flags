import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class DatabaseFailure extends Failure {
  final String message;

  DatabaseFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
