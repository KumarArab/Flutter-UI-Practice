import 'package:flutter/material.dart';

class BarcodePage extends StatefulWidget {
  BarcodePage({Key? key, required this.result}) : super(key: key);
  ValueChanged<String> result;
  @override
  State<BarcodePage> createState() => _BarcodePageState();
}

class _BarcodePageState extends State<BarcodePage> {
  Future _scanBarcode() async {
    try {
      // ScanResult scanResult = await BarcodeScanner.scan();
      // String barcodeResult = scanResult.rawContent;
      setState(() {
        widget.result("barcodeResult");
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan Bar Code")),
      body: Center(
          child: ElevatedButton(
        child: const Text("Scan Code"),
        onPressed: () {
          _scanBarcode();
        },
      )),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String recipeUrl = "No recipe url detected";
  String barcodeResult = "Scan an item!";

  String baseUrl = "https://";
  String jsonEnd = "/pizza";
  void join() {
    setState(() {
      recipeUrl = baseUrl + barcodeResult + jsonEnd;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: 100,
        itemBuilder: (context, i) {
          final _expansionTileKey = GlobalKey();
          return ExpansionTile(
            initiallyExpanded: false,
            textColor: Colors.black,
            key: _expansionTileKey,
            leading: const CircleAvatar(
                backgroundImage: AssetImage(
                    "https://images.unsplash.com/photo-1674618487633-dd14c2cbcbc3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1740&q=80")),
            onExpansionChanged: (value) =>
                {}, //widget.onExpansionChanged(_expansionTileKey),
            trailing: const Icon(
              Icons.keyboard_arrow_down,
            ),
            subtitle: Text(
              "$i - $i",
            ),
            title: Text(
              '$i',
            ),
            children: <Widget>[
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 20,
                itemBuilder: (_, index) {
                  return Container(
                    color: Colors.white,
                    child: Text("$index"),
                  );
                },
                separatorBuilder: (_, i) => const Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Divider(
                    height: 1,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}


// I'm writing my answer assuming you don't have a proper state management in your app yet otherwise this is not even a problem.

// If BarcodePage is first and TestPage is second then you can go with @navidanchitrali 's answer but if it is the opposite, I'd like to suggest you to use the **ValueChanged** feature of Flutter.

// What ValueChange does is you can update your string variable present in your previous screen on the next screen on which you currently are.

// Here, we have a barcodeResult variable that needs to be updated with the value we get in the next screen after the scan so here is my proposed code for the same.

// This is the Testpage where we pass a valuechange function to Barcode screen

//     class TestPage extends StatefulWidget {
//       const TestPage({Key? key}) : super(key: key);
    
//       @override
//       State<TestPage> createState() => _TestPageState();
//     }
    
//     class _TestPageState extends State<TestPage> {
//       String recipeUrl = "No recipe url detected";
//       String barcodeResult = "Scan an item!";
    
//       String baseUrl = "https://";
//       String jsonEnd = "/pizza";
//       void join() {
//         setState(() {
//           recipeUrl = baseUrl + barcodeResult + jsonEnd;
//         });
//       }
    
//       @override
//       Widget build(BuildContext context) {
//         return Scaffold(
//           body: Container(
//             width: MediaQuery.of(context).size.width,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(recipeUrl),
//                 const SizedBox(height: 40),
//                 ElevatedButton(
//                   child: const Text("Scan Code"),
//                   onPressed: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (ctx) => BarcodePage(
//                           result: (url) {
//                             setState(() {
//                               barcodeResult = url;
//                               join();
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         );
//       }
//     }

// and here is the Barcode page where we have a function which updates the value for the barcoderesult variable. 

//     class BarcodePage extends StatefulWidget {
  

//     BarcodePage({Key? key, required this.result}) : super(key: key);
//       ValueChanged<String> result;
//       @override
//       State<BarcodePage> createState() => _BarcodePageState();
//     }
    
//     class _BarcodePageState extends State<BarcodePage> {
//       Future _scanBarcode() async {
//         try {
//           // ScanResult scanResult = await BarcodeScanner.scan();
//           // String barcodeResult = scanResult.rawContent;
//           setState(() {
//             widget.result("barcodeResult");
//           });
//         } catch (e) {}
//       }
    
//       @override
//       Widget build(BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(title: const Text("Scan Bar Code")),
//           body: Center(
//               child: ElevatedButton(
//             child: const Text("Scan Code"),
//             onPressed: () {
//               _scanBarcode();
//             },
//           )),
//         );
//       }
//     }