import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/providers/test_img.dart';
import 'package:retroflux/providers/test_img_provider.dart';
import 'package:retroflux/widgets/test_img_item.dart';

class ProviderTestScreen extends StatefulWidget {
  static const String routeName = '/ProviderTestScreen';
  const ProviderTestScreen({Key? key}) : super(key: key);

  @override
  State<ProviderTestScreen> createState() => _ProviderTestScreenState();
}

class _ProviderTestScreenState extends State<ProviderTestScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider Test"),
      ),
      body: const TestImgGrid(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_)=> AddPhotoDialog()
          );
        },
      ),
    );
  }
}


class TestImgGrid extends StatelessWidget {
  const TestImgGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final testImgsData = Provider.of<TestImgs>(context);
    final testImgs = testImgsData.loadedImgs;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: testImgs.length,
      itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
        value: testImgs[i],
        child: const TestImgItem(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
      ),

    );
  }
}


class AddPhotoDialog extends StatefulWidget {
  const AddPhotoDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPhotoDialog> createState() => _AddPhotoDialogState();
}

class _AddPhotoDialogState extends State<AddPhotoDialog> {

  late TextEditingController _nameController;

  late TextEditingController _genreController;

  late TextEditingController _linkController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _linkController = TextEditingController();
    _genreController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _linkController.dispose();
    _genreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final testImgsData = Provider.of<TestImgs>(context);
    return AlertDialog(
      title: const Text('Add a new photo'),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Photo Name',
              ),
            ),
            TextField(
              controller: _genreController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Genre',
              ),
            ),
            TextField(
              controller: _linkController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Network Link',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Cancel")
        ),
        TextButton(
            onPressed: (){
              if(_nameController.text.isNotEmpty && _genreController.text.isNotEmpty &&_linkController.text.isNotEmpty){
                testImgsData.addImg(
                    TestImg(name: _nameController.text, link: _linkController.text, genre: _genreController.text)
                );
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("如果kai没写bug的话应该是加上了"),
                    ));
                Navigator.pop(context);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("全填完再点行不行啊(ﾟ皿ﾟﾒ)"),
                ));
              }
              },
          child:const Text("Add") ,
        )
      ],
    );
  }
}