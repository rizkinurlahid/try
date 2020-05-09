import 'package:flutter/material.dart';
import 'package:may_8/models/postModel.dart';
import 'package:may_8/services/dioRepository.dart';

class HttpWithDio extends StatefulWidget {
  @override
  _HttpWithDioState createState() => _HttpWithDioState();
}

class _HttpWithDioState extends State<HttpWithDio> {
  DioRepository dioRepository = DioRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: dioRepository.getDataPostFromApi,
            builder: (BuildContext context,
                AsyncSnapshot<List<PostModel>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  break;
                case ConnectionState.waiting:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  break;
                case ConnectionState.active:
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                  break;
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return Container(
                      child: Center(
                        child: Text('Something Wrong!'),
                      ),
                    );
                  } else {
                    return BuildListView(
                      postModel: snapshot.data,
                    );
                  }
                  break;
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class BuildListView extends StatelessWidget {
  final List<PostModel> postModel;
  const BuildListView({
    Key key,
    @required this.postModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: postModel.length,
      itemBuilder: (context, index) {
        final x = postModel[index];
        return ListTile(
          leading: Text(x.id.toString()),
          title: Text(x.title),
          subtitle: Text(x.body),
        );
      },
    );
  }
}
