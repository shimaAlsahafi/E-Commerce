import 'package:commerceapps/widget/custom_button.dart';
import 'package:commerceapps/widget/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constans.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _registerFormLoading=false;
  String _registerEmail='';
  String _registerPassword='';
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
  //creat New yser account
  Future<String> _createAccount() async {
    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);

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
      _registerFormLoading=true;
    });
    String _creatAcounrFeddback= await _createAccount();
    if(_creatAcounrFeddback !=null){
      _alertDialogBuilder(_creatAcounrFeddback);
      setState(() {
        _registerFormLoading=false;
      });

    }
else{Navigator.pop(context);}

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

            Container(padding: EdgeInsets.all(30),child: Text('Creat A New Account ',textAlign: TextAlign.center,style: Constans.boldHeading,))

            ,Column(children: [

              CustomInput(
                hintText: 'Email..',
                onChange:(value){
                  _registerEmail=value;
                } ,onSubmit: (value){

                _passowrdFocusNode.requestFocus();
              },textInputAction: TextInputAction.next,),


              CustomInput(
                isPassowrdFiled: true,
                hintText: "Passowrd..",
                  onChange:(value){
                    _registerPassword=value;
                  },focusNode:_passowrdFocusNode , onSubmit: (value){
                _submitForm();
              },),


              Custombtn(text: 'Create New Account',isLoading: _registerFormLoading,
                onpressed: (){
                  _submitForm();
             },
                outlineBtn: false,)

            ],)

            , Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Custombtn(text: 'Back To Login',onpressed: (){Navigator.pop(context);},outlineBtn: true,),
            )
          ],),
        ),),
    );

  }
}
