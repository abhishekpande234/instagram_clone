import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';
import '../widgets/text_field_input.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void navigateToSignUp() {
    // Navigator.pop(context);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }

  void navigateToHomeScreen() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomScreen()),
    );
  }

  void navigateToResponsiveLayout() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )),
    );
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    setState(() {
      _isLoading = false;
    });
    if (res == "Success") {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomScreen()));
      navigateToResponsiveLayout();
      // showSnackBar(res, context);
    } else {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
          // textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(
              child: const Text("Don't have an account?"),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            GestureDetector(
              onTap: () {
                navigateToSignUp();
              },
              child: Container(
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Flexible(child: Container(), flex : 2),
                  //svg img
                  const Image(
                      image: AssetImage('assets/devbee.png'),
                      color: primaryColor,
                      height: 64),
                  // SvgPicture.asset('assets/insta.svg' , color: primaryColor, height:64),
                  const SizedBox(
                    height: 64,
                  ),
                  //mail
                  TextFieldInput(
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),

                  const SizedBox(
                    height: 24,
                  ),
                  //pass
                  TextFieldInput(
                    hintText: 'Enter your password',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  //login button
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      loginUser();
                      // setState(() {
                      //   _emailController.clear();
                      //   _passwordController.clear();
                      // });
                    },
                    child: Container(
                      child: _isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : const Text("Log In"),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  // Flexible(child: Container(), flex : 2),
                  //transition to sign up

                  // const SizedBox(height: 24,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
