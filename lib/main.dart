import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBoyMOxWYKb0vALPIl0GKesDMeQCLBcsMk',
          appId: '1:1064815485536:web:e2c698dcf07a83cbedd905',
          messagingSenderId: "1064815485536",
          projectId: "instagram-clone-c6318",
        storageBucket: "instagram-clone-c6318.appspot.com",
      ),
    );
  }
  else{
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        // home: ,
        home: StreamBuilder(builder: (context , snapshot){
          print("___________________________________________________________________________________________________________________");

          print(snapshot.connectionState == ConnectionState.active);

          print(snapshot.hasData);

            if (snapshot.connectionState == ConnectionState.active) {
              print(snapshot.connectionState == ConnectionState.active);
              print("___________________________________________________________________________________________________________________");
              if(snapshot.hasData){
                print(snapshot.hasData);
                  return const ResponsiveLayout(mobileScreenLayout: MobileScreenLayout(), webScreenLayout: WebScreenLayout(),);
              }else{
                return Center(child : Text('${snapshot.error}'));
              }
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                  child : CircularProgressIndicator(
                    color: primaryColor,
                  )
              );
            }
            return const LoginScreen();
        },
        ),
      ),
    );
  }
}


