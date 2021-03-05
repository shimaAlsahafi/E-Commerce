import 'package:flutter/material.dart';
class ProductSize extends StatefulWidget {
  final List proudctSize;
final Function(String) onSelected;
  const ProductSize({Key key, this.proudctSize,this.onSelected}) : super(key: key);
  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  @override
  int selected=0;
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(children: [
        for(int i=0;i<widget.proudctSize.length;i++)
          GestureDetector(onTap: (){
            widget.onSelected('${widget.proudctSize[i]}');
            setState(() {
              selected=i;
            });
          },

            child: Container(margin: EdgeInsets.symmetric(horizontal: 4),alignment: Alignment.center,height: 42,width: 42,
                decoration: BoxDecoration(color: selected==i?Theme.of(context).accentColor:Color(0xFFDCDCDC),borderRadius: BorderRadius.circular(12)),
                child: Text(widget.proudctSize[i],style: TextStyle(color:selected==i?Colors.white:Colors.black,fontWeight: FontWeight.w600,fontSize: 16),)),
          )
      ],),
    );
  }
}
