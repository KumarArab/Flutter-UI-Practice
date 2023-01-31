import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      showPerformanceOverlay: true,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.all(size.width * 0.08),
          width: size.width,
          height: size.height * 0.4,
          color: const Color(0xff7A6F6F),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Row(
            children: [
              Expanded(
                child: Container(
                    height: size.height * 0.3, color: const Color(0xff89B681)),
              ),
              SizedBox(width: size.width * 0.08),
              Expanded(
                child: Container(
                    height: size.height * 0.3, color: const Color(0xff8992DD)),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: size.width * 0.06),
          child: Column(
            children: List.generate(
              5,
              (i) => Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.08,
                  vertical: size.width * 0.02,
                ),
                height: size.width * 0.1,
                color: const Color(0xff434C52),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
