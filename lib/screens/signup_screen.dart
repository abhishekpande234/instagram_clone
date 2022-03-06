import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/utils.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading  = false;

  @override
  void dispose()
  {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  selectImage() async{
      Uint8List im =  await pickImage(ImageSource.gallery);

      setState(() {
        _image = im ;
      });
  }

  void navigateToLogin(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void signUpUser() async{
  setState((){
    _isLoading = true;
   });
  String res = await AuthMethods().signUpUser(
  email: _emailController.text,
  password: _passwordController.text,
  username: _usernameController.text,
  bio: _bioController.text,
  file : _image!,
  );
  setState((){
    _isLoading = false;
  });
  if(res == 'Success'){
    navigateToLogin();
    // showSnackBar(res, context);
  }else{
    showSnackBar(res, context);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 24),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child : const Text("Already have an account?"),
            padding: const EdgeInsets.symmetric(
                vertical: 8
            ),
          ),
          GestureDetector(
            onTap: (){
              navigateToLogin();
            },
            child: Container(
              child : const Text("Log in" , style: TextStyle(fontWeight: FontWeight.bold),),
              padding: const EdgeInsets.symmetric(
                  vertical: 8
              ),
            ),
          ),
        ],
      ),),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Flexible(child: Container(), flex : 2),
                  //svg img
                  const Image(image: AssetImage('assets/devbee.png'), color: primaryColor , height:64),
                  // SvgPicture.asset('assets/insta.svg' , color: primaryColor, height:64),
                  const SizedBox(height: 24,),
                  //circular image selector
                  Stack(
                    children :[
                      _image!=null
                          ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                          :  const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://as2.ftcdn.net/v2/jpg/02/15/84/43/1000_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg'),
                      ),
                      Positioned(
                        bottom: -10,
                        left:80,
                        child: IconButton(onPressed: () {
                          selectImage();
                        },
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24,),
                  // username
                  TextFieldInput(
                    hintText: 'Enter your username',
                    textInputType:  TextInputType.text,
                    textEditingController: _usernameController,
                  ),
                  const SizedBox(height: 24,),

                  //mail
                  TextFieldInput(
                    hintText: 'Enter your email',
                    textInputType:  TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),
                  const SizedBox(height: 24,),
                  //pass
                  TextFieldInput(
                    hintText: 'Enter your password',
                    textInputType:  TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),
                  const SizedBox(height: 24,),

                  // bio
                  TextFieldInput(
                    hintText: 'Enter your bio',
                    textInputType:  TextInputType.text,
                    textEditingController: _bioController,
                  ),
                  const SizedBox(height: 24,),

                  //login button
                  InkWell(
                    onTap: () async{
                      signUpUser();
                    },
                    child: Container(
                      child: _isLoading
                          ? const Center(child: CircularProgressIndicator (
                        color: primaryColor,
                      ),
                      )
                          : const Text("Sign up"),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24,),
                  // Flexible(child: Container(), flex : 2),
                  //transition to sign up
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
