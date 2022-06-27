import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/test_img.dart';

class TestImgItem extends StatelessWidget {
  const TestImgItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final testImg = Provider.of<TestImg>(context);
    return GridTile(
        child: Image.network(testImg.link,fit:BoxFit.cover),
        footer: GridTileBar(
          trailing: Consumer<TestImg>(
            builder: (context,TestImg,child) => IconButton(
              icon: Icon(Icons.favorite,color: testImg.isLiked? Colors.red:Colors.grey,),
              onPressed: (){
                testImg.clickLike();
              },
            ),
          ),
          title: Text(testImg.name),
        )
    );
  }
}

