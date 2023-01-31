import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return PageView(children: [Page1(), Page2()]);
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  List<String>? imageList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  loadImages() async {
    await Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          imageList = [
            "https://images.unsplash.com/photo-1661961110218-35af7210f803?ixlib=rb-4.0.3&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80",
            "https://images.unsplash.com/photo-1670871137637-fe0782c32e9c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80"
          ];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return imageList == null
        ? const CircularProgressIndicator()
        : ListView.builder(
            itemBuilder: (ctx, i) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                imageList![i],
                width: size.width * 0.8,
              ),
            ),
          );
  }
}

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  List<String>? imageList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  loadImages() async {
    await Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          imageList = [
            "https://plus.unsplash.com/premium_photo-1665657351594-14473b25fe22?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80",
            "https://images.unsplash.com/photo-1671035812269-7c4dfd2e0ccf?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1666&q=80"
          ];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return imageList == null
        ? const CircularProgressIndicator()
        : ListView.builder(
            itemBuilder: (ctx, i) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                imageList![i],
                width: size.width * 0.8,
              ),
            ),
          );
  }
}
