import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testapp/utils/size_config.dart';

typedef Package = Map<String?, dynamic>;

//appName: packageName
class InstalledApps extends StatefulWidget {
  const InstalledApps({Key? key}) : super(key: key);

  @override
  State<InstalledApps> createState() => _InstalledAppsState();
}

class _InstalledAppsState extends State<InstalledApps> {
  List<Package> packages = [];
  List<Package> res = [];
  bool isLoading = true;
  static const platform = MethodChannel('testApp/installedApps');

  getInstalledApplications() async {
    try {
      final List result = await platform.invokeMethod('getInstalledApps');
      for (var e in result) {
        packages.add(parseData(e));
        print(packages.length);
      }
      setState(() {});
    } on PlatformException catch (e) {
      log("Failed to fetch installed applications $e");
    }
    isLoading = false;
  }

  @override
  void initState() {
    getInstalledApplications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Available Apps",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : packages.isEmpty
              ? Center(
                  child: Image.network(
                  "https://cdni.iconscout.com/illustration/premium/thumb/employee-unable-to-access-data-3391065-2829991.png",
                  width: SizeConfig.width! * 0.5,
                ))
              : ListView.separated(
                  separatorBuilder: (context, index) =>
                      index != packages.length - 1
                          ? const Divider(
                              color: Colors.white12,
                            )
                          : const SizedBox(),
                  itemCount: packages.length,
                  itemBuilder: (ctx, i) => ListTile(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.width! * 0.02,
                        horizontal: SizeConfig.width! * 0.04),
                    title: Text(
                      packages[i]["appName"] ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      packages[i]["packageName"] ?? "",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.memory(packages[i]["icon"] ?? ""),
                    ),
                  ),
                ),
    );
  }

  Package parseData(Map<dynamic, dynamic> data) {
    final appName = data["app_name"];
    final packageName = data["package_name"];
    final icon = data["icon"];
    return {"appName": appName, "packageName": packageName, "icon": icon};
  }
}
