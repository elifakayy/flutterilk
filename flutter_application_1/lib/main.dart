// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/responsive/mobile_screen_layout.dart';
import 'package:flutter_application_1/responsive/responsive_layout_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GuideHack',
      //home: SignupScreen(),
      home: LoginScreen(),
      //home: HomeScreen(),
    );
  }
}

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  //gelen verileri almak için

  girisYap() {
    Navigator.pushNamed(context, "/Profil",
        arguments: VeriModeli(kullaniciAdi: t1.text, sifre: t2.text));
    //giriş yap butonuna tıklandığında Profil ekranına geçiyor.
    //veriler profil sayfasına iletilecek
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Giriş Ekranı")),
        body: Container(
            margin: const EdgeInsets.all(50),
            child: Center(
              child: Column(children: <Widget>[
                TextFormField(
                  controller: t1,
                ),
                TextFormField(
                  controller: t2,
                ),
                RaisedButton(
                  onPressed: girisYap,
                  child: const Text("Giriş yap"),
                )
              ]),
            )));
  }
}

class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({Key? key}) : super(key: key);

  @override
  State<ProfilEkrani> createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State<ProfilEkrani> {
  cikisYap() {
    Navigator.pop(context); //son açılan sayfayı kapatıyor.
  }

  @override
  Widget build(BuildContext context) {
    VeriModeli iletilenArgumanlar =
        ModalRoute.of(context)!.settings.arguments as VeriModeli;
    //iletilen argumanların içeriğine erişip değişkene atandı

    return Scaffold(
      appBar: AppBar(title: const Text("Profil Ekranı")),
      body: Column(
        children: [
          RaisedButton(
            onPressed: cikisYap,
            child: const Text("Çıkış yap"),
          ),
          Text(iletilenArgumanlar.kullaniciAdi),
          Text(iletilenArgumanlar.sifre),
        ],
      ),
    );
  }
}

class VeriModeli {
  var kullaniciAdi, sifre;
  VeriModeli({this.kullaniciAdi, this.sifre});
  //constructorla bunları alacağız , veri modeli oluştuerduk

}
