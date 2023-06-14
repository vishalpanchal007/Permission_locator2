import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Permission> permissions = [
    Permission.camera,
    Permission.microphone,
    Permission.location,
    Permission.audio,
    Permission.bluetooth,
    Permission.contacts,
    Permission.calendar,
    // Add more permissions as needed
  ];

  Future<bool> checkPermissionStatus(Permission permission) async {
    final status = await Permission.camera;
    return await permission.status.isGranted;;
  }

  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();
    print('Permission status: $status');
  }

  void openAppSettings() {
    openAppSettings();
  }

  void openPermissionAlertDialog(BuildContext context, Permission permission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(permission.toString()),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final status = await checkPermissionStatus(permission);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Status: $status')),
                  );
                },
                child: Text('Check Status'),
              ),
              ElevatedButton(
                onPressed: () {
                  requestPermission(permission);
                  Navigator.of(context).pop();
                },
                child: Text('Request Permission',
                style: TextStyle()),
              ),
              ElevatedButton(
                onPressed: () {
                  openAppSettings();
                },
                child: Text('Open App Settings'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Permissions'),
      ),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.all(10),

          itemCount: permissions.length,
          itemBuilder: (BuildContext context, int index) {
            final permission = permissions[index];
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Container(
                    color: Colors.cyan,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(permission.toString(),
                      style: TextStyle(
                        fontWeight:  FontWeight.bold,
                        fontSize: 20
                      )),
                    ),
                  ),
                  onTap: () {
                    openPermissionAlertDialog(context, permission);
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
