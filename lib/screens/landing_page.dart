import 'package:commerceapps/constans.dart';
import 'package:commerceapps/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initlazation=Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: _initlazation,builder: (context,snapshot){
      if(snapshot.hasError){
        return Scaffold(body: Center(child: Text('erorr:${snapshot.error}',style: Constans.regularHeading,),),);
      }
      if(snapshot.connectionState==ConnectionState.done){
        return StreamBuilder(stream:FirebaseAuth.instance.authStateChanges(),builder: (context,stremsnapshot){
          if(stremsnapshot.hasError){
            return Scaffold(body: Center(child: Text('erorr:${stremsnapshot.error}',style: Constans.regularHeading,),),);
          }

          if(stremsnapshot.connectionState==ConnectionState.active){
            User _user=stremsnapshot.data;
            print(_user);

          if(_user==null){

            return LoginPage();
          }
          else{
            print('home page');
            return HomePage();
          }
          }

          return Scaffold(body: Center(child: Text('check authentication'),),);
        });
      }
      return Scaffold(body: Center(child: Text('iniatlization app..'),),);
    });
  }
}
