import 'package:firebase_core/firebase_core.dart';
import 'package:whole_choice_admin_pannel/const/const.dart';
import 'package:whole_choice_admin_pannel/views/auth_screen/login_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:whole_choice_admin_pannel/views/home_screen/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  var isLoggedin = false;
  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        isLoggedin = false;
      } else {
        isLoggedin = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print(Colors.black.value);
    print(Colors.white.value);
    print(Colors.green.value);
    print(Colors.blue.value);
    print(Colors.red.value);
    print(Colors.orange.value);
    print(Colors.pink.value);
    print(Colors.purple.value);
    print(Colors.indigo.value);
    print(Colors.deepOrange.value);
    print(Colors.blueAccent.value);
    print(Colors.blueGrey.value);
    print(Colors.lightBlue.value);
    print(Colors.lightGreen.value);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent, elevation: 0.0)),
      home: isLoggedin ? const Home() : const LoginScreen(),
    );
  }
}
