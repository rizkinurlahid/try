import 'dart:convert';

import 'package:dio/dio.dart' as httpDio;
import 'package:may_8/models/postModel.dart';
import 'package:may_8/utils/string/strings.dart';

class DioProvider {
  httpDio.Dio dio = httpDio.Dio();

  Future<List<PostModel>> getDataPostFromApiAsync() async {
    httpDio.Response response = await dio.get(AppStrings.apiDio);

    if (response.statusCode == 200) {
      final List list2 = jsonDecode(jsonEncode(response.data));
      List<PostModel> listPostModel =
          list2.map((f) => PostModel.fromJson(f)).toList();

      return listPostModel;
    } else {
      return null;
    }
  }
}
