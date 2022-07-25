import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String userName;
  late String password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, //ortaya çekiyor
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode
                      .always, //kullanıcı adı giriniz yazısı hep yazıyor
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      labelText: 'kullanıcı adı'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "kullanıcı adını giriniz";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    userName = value!;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode
                      .always, //kullanıcı adı giriniz yazısı hep yazıyor
                  decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple),
                      ),
                      labelText: 'şifre'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "şifrenizi giriniz";
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      child: Text("üye ol"),
                      onPressed: () {},
                    ),
                    MaterialButton(
                      child: Text("şifremi unuttum "),
                      onPressed: () {},
                    )
                  ],
                ),
                _loginButton()
              ],
            ),
          )),
    );
  }

  Widget _loginButton() => RaisedButton(
        child: Text("Giriş Yap"),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );
}
