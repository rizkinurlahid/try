import 'package:equatable/equatable.dart';

abstract class ApiEvent extends Equatable {}

class FetchApiEvent extends ApiEvent {
  @override
  List<Object> get props => null;
}
