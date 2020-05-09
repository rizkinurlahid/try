import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:may_8/models/apiResultModel.dart';

abstract class ApiState extends Equatable {}

class ApiInitialState extends ApiState {
  @override
  List<Object> get props => null;
}

class ApiLoadingState extends ApiState {
  @override
  List<Object> get props => null;
}

class ApiLoadedState extends ApiState {
  final List<ApiResultModel> apiResultModel;

  ApiLoadedState({@required this.apiResultModel});

  @override
  List<Object> get props => null;
}

class ApiErrorState extends ApiState {
  final String message;

  ApiErrorState({@required this.message});

  @override
  List<Object> get props => null;
}
