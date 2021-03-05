import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedtab;
  final Function (int) ontabPressed;

  BottomTabs({this.selectedtab,this.ontabPressed});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab=0;
@override

  @override
  Widget build(BuildContext context) {
  _selectedTab=widget.selectedtab??0;
    return Container(
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(
        topLeft:Radius.circular(12),
        topRight:Radius.circular(12)
      ),boxShadow: [BoxShadow(
        color: Colors.black.withOpacity(0.05),spreadRadius: 1,blurRadius: 30
      )]),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
        BottomTabsbnt(image:'assets/images/tab_home.png',selected:_selectedTab==0? true:false,onpressed: (){
          widget.ontabPressed(0);
        },),
        BottomTabsbnt(image:'assets/images/tab_search.png',selected:_selectedTab==1? true:false,onpressed: (){
          widget.ontabPressed(1);
    },),
        BottomTabsbnt(image:'assets/images/tab_saved.png',selected:_selectedTab==2? true:false,onpressed: (){
          widget.ontabPressed(2);
    },),
        BottomTabsbnt(image:'assets/images/tab_logout.png',selected:_selectedTab==3? true:false,onpressed: (){

         FirebaseAuth.instance.signOut();
    },),

      ],),
    );
  }
}

class BottomTabsbnt extends StatelessWidget {
  final String image;
  final bool selected;
  final Function onpressed;
  BottomTabsbnt({this.image,this.selected,this.onpressed});
  @override
  Widget build(BuildContext context) {
  bool _selected= selected??false;
    return GestureDetector(onTap:onpressed ,
      child: Container(decoration: BoxDecoration(border: Border(
        top: BorderSide(color:_selected?Theme.of(context).accentColor:Colors.transparent,width: 2)
      )),padding: EdgeInsets.symmetric(vertical: 22,horizontal: 24),
        child:Image(image:  AssetImage(image),height: 26,width: 26,color: _selected?Theme.of(context).accentColor:Colors.black,),
      ),
    );
  }
}

