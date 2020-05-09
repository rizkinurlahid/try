import 'package:may_8/models/postModel.dart';
import 'package:may_8/providers/dioProvider.dart';

class DioRepository {
  DioProvider _provider = DioProvider();

  Future<List<PostModel>> get getDataPostFromApi =>
      _provider.getDataPostFromApiAsync();
}
