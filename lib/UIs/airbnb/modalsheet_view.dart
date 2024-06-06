import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/UIs/airbnb/home_view.dart';

class AirBnbModalSheetView extends StatefulWidget {
  const AirBnbModalSheetView({Key? key,required this.heroId}) : super(key: key);
  final String heroId;

  @override
  State<AirBnbModalSheetView> createState() => _AirBnbModalSheetViewState();
}

class _AirBnbModalSheetViewState extends State<AirBnbModalSheetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(),
      body: Center(
        child: AvatarCard(heroId: widget.heroId)
      ),
    );
  }
}
