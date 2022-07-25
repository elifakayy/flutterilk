import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/resources/auth_methods.dart';
import 'package:flutter_application_1/utils/colors.dart';
import 'package:flutter_application_1/widgets/text_field_input.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../utils/utils.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  Uint8List? _image;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void SignUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        job: _jobController.text,
        file: _image!);

    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                'assets/guidehack.svg',
                color: Color(0xFFFF9000),
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),

              //circular widget to accept and show our selected file
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image!),
                          backgroundColor: Colors.red,
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          backgroundColor: Colors.red,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),

              /* 
            Stack(
              children: const [
                CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://pbs.twimg.com/profile_images/1277609861669412865/pIXfLwWQ_400x400.jpg'),
                ),
              ],
            ),
            */
              const SizedBox(
                height: 24,
              ),

              //text field input for username
              TextFieldInput(
                hintText: 'kullanıcı adı giriniz',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(
                height: 24,
              ),
              //text field input for email
              TextFieldInput(
                hintText: 'Email giriniz',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 24,
              ),
              //text field input for password
              TextFieldInput(
                hintText: 'Şifre giriniz',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              //text field input for job
              TextFieldInput(
                hintText: 'mesleğinizi giriniz',
                textInputType: TextInputType.text,
                textEditingController: _jobController,
              ),
              const SizedBox(
                height: 24,
              ),
              //login button
              InkWell(
                child: Container(
                  child: !_isLoading
                      ? const Text(
                          'Kayıt ol',
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                  //child: const Text('Giriş'),
                  width: double.infinity,

                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                      ),
                      color: Colors.green),
                ),
                onTap: SignUpUser,
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );

    /*
    ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    showSnackBar(
      BuildContext context, String text) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text),),
      );
      },
  */
  }
}
