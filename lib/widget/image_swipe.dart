import 'package:flutter/material.dart';
class ImageSwipe extends StatefulWidget {
  final List imagelist;

  const ImageSwipe({Key key, this.imagelist}) : super(key: key);

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}
int selectedpage=0;
class _ImageSwipeState extends State<ImageSwipe> {
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(height: 400,child:PageView(onPageChanged: (num){
          setState(() {
            selectedpage=num;
          });
        },
          children: [
            for(var i=0;i< widget.imagelist.length;i++)
              Container(child: Image(image: NetworkImage(widget.imagelist[i]),fit: BoxFit.cover,),)
          ],
        )),
        Positioned(bottom: 20,left: 0,right: 0,child: Container(child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for(var i=0;i< widget.imagelist.length;i++)
              AnimatedContainer(duration: Duration(microseconds: 300),curve: Curves.easeInCubic,
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 12,width:selectedpage==i?35:12,decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12)
              ),
              )

          ],
        ) ,))
      ],
    );
  }
}
