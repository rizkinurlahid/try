import 'dart:convert';

import 'package:may_8/models/apiResultModel.dart';
import 'package:http/http.dart' as http;
import 'package:may_8/utils/string/strings.dart';

abstract class ApiRepository {
  Future<List<ApiResultModel>> getApi();
}

class ApiRepositoryImpl implements ApiRepository {
  @override
  Future<List<ApiResultModel>> getApi() async {
    var response = await http.get(AppStrings.apiUrl);
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      // List<ApiResultModel> res = ApiResultModel.fromJson(data).author;
      List<ApiResultModel> list =
          data.map((f) => ApiResultModel.fromJson(f)).toList();
      return list;

      // List list = jsonDecode(jsonEncode(response.body));
      // List<ApiResultModel> listData =
      //     list.map((f) => ApiResultModel.fromJson(f)).toList();
      // print(listData.length);

      // return list;
    } else {
      throw Exception();
    }
  }
}
