
import 'package:flutter/material.dart';

class RadioButtonTest extends StatefulWidget {
  const RadioButtonTest({Key? key}) : super(key: key);

  @override
  _RadioButtonTestState createState() => _RadioButtonTestState();
}

class _RadioButtonTestState extends State<RadioButtonTest> {
  int selectedTileIndex = -1; // Default value, no tile selected

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Radio Tile Example'),
        ),
        body: Column(
          children: [
            Expanded(
              child: RadioListTile(
                    title:const Text('Item 0'),
                    value: 0,
                    toggleable: true,
                    groupValue: selectedTileIndex,
                    onChanged: (value) {
                      setState(() {
                        // Toggle selection when tapped again
                        selectedTileIndex = selectedTileIndex != -1  ? -1 : 0;
                      },);
                    },
                  ),),
            ElevatedButton(
              onPressed: ()=> selectedTileIndex = selectedTileIndex != -1  ? -1 : 0,
              child: const Text('Solid Button'),
            ),
          ],
        ),
      ),
    );
  }
}
