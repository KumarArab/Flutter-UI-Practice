import 'package:flutter/material.dart';

class PageViewSample extends StatefulWidget {
  const PageViewSample({Key? key}) : super(key: key);

  @override
  State<PageViewSample> createState() => _PageViewSampleState();
}

class _PageViewSampleState extends State<PageViewSample> {

  PageController _controller = PageController();
  int prevPage = 0;
  String title = "", subtitle = "";

 @override
  initState(){
    super.initState();

    _controller..addListener(() {

      if(_controller.page!.toInt() == 0){

      } 
      else if(_controller.page!.toInt() == 1){
        setState(() {
          title = "Hello";
          subtitle ="World";
        });
      }
     });

  }

  onTap(){
    _controller.animateToPage(_controller.page!.toInt()+1, duration: Duration(seconds: 1), curve: Curves.linear);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          SizedBox(
            height: 50,
            child: Placeholder(),
            width: 150,
          ),
          Expanded(
              child: PageView(
                controller: _controller,
                physics: NeverScrollableScrollPhysics(),
            children: [
              PageViewCard(onPush: onTap),
              PageViewCard(onPush: onTap),
              PageViewCard(onPush: onTap),
              PageViewCard(onPush: onTap),
            ],
          )),
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: Column(
              children: [
                Text(title),
                Text(subtitle),
              ],
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

class PageViewCard extends StatelessWidget {
  const PageViewCard({
    Key? key,
    required this.onPush
  }) : super(key: key);

final Function onPush;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text("Top Text"),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 200,
            child: Placeholder(),
          ),
          SizedBox(
            height: 30,
          ),
          Text("Title"),
          Text("Subtitle"),
          MaterialButton(onPressed: ()=>  onPush(), child: Text("Push me"))
        ]),
      ),
    );
  }
}
