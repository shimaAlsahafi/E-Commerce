import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerceapps/constans.dart';
import 'package:commerceapps/screens/cart_page.dart';
import 'package:commerceapps/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasbackground;


   CustomActionBar({Key key, this.title, this.hasBackArrow, this.hasTitle,this.hasbackground}) : super(key: key);

  final CollectionReference _UserRef=FirebaseFirestore.instance.collection('Users');
  FirebaseServices _firebaseServices=FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow=hasBackArrow??false;
    bool _hasTitle=hasTitle??false;
    bool _hasbackground=hasbackground??true;


    return Container(
      decoration: BoxDecoration(
        gradient:_hasbackground? LinearGradient(
          colors: [Colors.white,Colors.white.withOpacity(0),]
             , begin:Alignment (0,0),end: Alignment(0,1)
        ):null
      ),
      padding: EdgeInsets.only(
        top: 56,
        left: 24,
        right: 24,
        bottom: 24
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
if(_hasBackArrow)
  GestureDetector(onTap: (){
    Navigator.pop(context);
  },
    child: Container(alignment: Alignment.center,height: 42,width: 42,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(8.0)),

      child:Image(image: AssetImage('assets/images/back_arrow.png'),width: 16,height: 16,color: Colors.white,),),
  )

,if(_hasTitle)
          Text(title??'Action Bar',style: Constans.boldHeading,),
          GestureDetector(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
          },
            child: Container(alignment: Alignment.center,height: 42,width: 42,decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(8.0)),

            child:StreamBuilder(
              // to get all data in cart
              stream: _UserRef.doc(_firebaseServices.getUserid()).collection('Cart').snapshots(),
              builder: (context,snapshot){
                int totalitem=0;
                if(snapshot.connectionState==ConnectionState.active){
                  List _documents=snapshot.data.docs;
                  totalitem=_documents.length;

                }

              return  Text('$totalitem'??"0",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),);
            },),),
          )

        ],
      ),
    );
  }
}
