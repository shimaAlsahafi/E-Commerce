import 'package:flutter/material.dart';

class Custombtn extends StatelessWidget {
  final String text;
  final Function onpressed;
  final bool outlineBtn;
  final bool isLoading;


  const Custombtn({Key key, this.text, this.onpressed, this.outlineBtn,this.isLoading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _outlineBtn =outlineBtn??false;
    bool _isLoading =isLoading??false;
    return GestureDetector(

      onTap: onpressed,
      child: Container(alignment: Alignment.center,
        height: 65,margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        decoration: BoxDecoration(
          color: _outlineBtn?Colors.transparent:Colors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black,width: 2)
        ),
        child: Stack(children:[
          Visibility(visible: _isLoading?false:true,child: Center(child: Text(text??'text',style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: _outlineBtn?Colors.black:Colors.white),))),
Visibility(visible:_isLoading ,child: Center(child: SizedBox(height: 30,width: 30,child: CircularProgressIndicator(),))),    ],)
      ) );
  }
}
