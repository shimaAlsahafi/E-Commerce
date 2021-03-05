import 'package:commerceapps/screens/register_page.dart';
import 'package:commerceapps/widget/custom_button.dart';
import 'package:commerceapps/widget/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constans.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _logInFormLoading=false;
  String _loginEmail='';
  String _loginPassword='';
  FocusNode _passowrdFocusNode;

  Future<void>_alertDialogBuilder(String error)async{
    return showDialog(barrierDismissible: false,context: context, builder: (context){
      return AlertDialog(

        title: Text('error'),

        content: Container(child: Text(error),),
        actions: [
          FlatButton(onPressed: (){Navigator.pop(context);}, child: Text('Close'))
        ],
      );
    });
  }
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
  void _submitForm() async{
    setState(() {
      _logInFormLoading=true;
    });
    String _logInFeddback= await _loginAccount();
    if(_logInFeddback !=null){
      _alertDialogBuilder(_logInFeddback);
      setState(() {
        _logInFormLoading=false;
      });

    }


  }

  @override
  void initState() {
    // TODO: implement initState
    _passowrdFocusNode=FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _passowrdFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

            Container(padding: EdgeInsets.all(30),child: Text('Welcome User, \n Login to your account ',textAlign: TextAlign.center,style: Constans.boldHeading,))

            ,Column(children: [
              CustomInput(
                hintText: 'Email..',
                onChange:(value){
                  _loginEmail=value;
                } ,onSubmit: (value){

                _passowrdFocusNode.requestFocus();
              },textInputAction: TextInputAction.next,),


              CustomInput(
                isPassowrdFiled: true,
                hintText: "Passowrd..",
                onChange:(value){
                  _loginPassword=value;
                },focusNode:_passowrdFocusNode , onSubmit: (value){
                _submitForm();
              },),

              Custombtn(text: 'Login',isLoading: _logInFormLoading,
                  onpressed: (){
               
      _submitForm();

      },
        outlineBtn: false,)

      ],)

           , Padding(
             padding: const EdgeInsets.only(bottom: 16),
             child: Custombtn(text: 'Creat New Account ',onpressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage())); },outlineBtn: true,),
           )
          ],),
        ),),
    );

  }
}
