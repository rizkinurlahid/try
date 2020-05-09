import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:may_8/blocs/apiBloc/apiEvent.dart';
import 'package:may_8/blocs/apiBloc/apiState.dart';
import 'package:may_8/models/apiResultModel.dart';
import 'package:may_8/services/apiRepository.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiRepository apiRepository;

  ApiBloc({@required this.apiRepository});

  @override
  ApiState get initialState => ApiInitialState();

  @override
  Stream<ApiState> mapEventToState(ApiEvent event) async* {
    if (event is FetchApiEvent) {
      yield ApiLoadingState();
      try {
        List<ApiResultModel> apiResultModel = await apiRepository.getApi();
        yield ApiLoadedState(apiResultModel: apiResultModel);
      } catch (e) {
        yield ApiErrorState(message: e.toString());
      }
    }
  }
}
