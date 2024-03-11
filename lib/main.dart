import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_ecomerce/screens/homescreen.dart';
import 'package:getx_ecomerce/screens/login_page.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          HomePage(), //LoginScreen(), //HomeScreen(), //LoginScreen(), // HomeScreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userdate = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userdate.writeIfNull('isLogged', false);
    Future.delayed(Duration.zero, () async {
      checkiflogged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void checkiflogged() {
    userdate.read('isLogged')
        ? Get.offAll(HomeScreen())
        : Get.offAll(LoginScreen());
  }
}
