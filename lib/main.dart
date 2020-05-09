import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:may_8/blocs/apiBloc/apiBloc.dart';
import 'package:may_8/services/apiRepository.dart';
import 'package:may_8/views/pages/httpWithDio.dart';
import 'package:may_8/views/pages/imageSlider.dart';
import 'package:may_8/views/pages/jitsiPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApiBloc(apiRepository: ApiRepositoryImpl()),
      child: MaterialApp(
        title: '8 May',
        initialRoute: '/',
        routes: {
          '/': (ctx) => HomePage(),
          '/jitsi': buildJitsiPage,
          '/slider': buildImageSlider,
          '/dio': buildHttpWithDio,
        },
      ),
    );
  }

  Widget buildJitsiPage(BuildContext context) {
    return JitsiPage();
  }

  Widget buildImageSlider(BuildContext context) {
    return ImageSlider();
  }

  Widget buildHttpWithDio(BuildContext context) {
    return HttpWithDio();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    TextStyle style = TextStyle(color: Colors.white);
    Random random = Random();
    return Scaffold(
      appBar: AppBar(
        title: Text('8 May'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              color: Color.fromRGBO(random.nextInt(255) + 1,
                  random.nextInt(255) + 1, random.nextInt(255) + 1, 1),
              onPressed: () => nav.pushNamed('/jitsi'),
              child: Text(
                'Build Jitsi Page',
                style: style,
              ),
            ),
            RaisedButton(
              color: Color.fromRGBO(random.nextInt(255) + 1,
                  random.nextInt(255) + 1, random.nextInt(255) + 1, 1),
              onPressed: () => nav.pushNamed('/slider'),
              child: Text(
                'Build Carousel Slider Page',
                style: style,
              ),
            ),
            RaisedButton(
              color: Color.fromRGBO(random.nextInt(255) + 1,
                  random.nextInt(255) + 1, random.nextInt(255) + 1, 1),
              onPressed: () => nav.pushNamed('/dio'),
              child: Text(
                'Build HTTP With Dio',
                style: style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
