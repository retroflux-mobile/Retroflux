import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retroflux/providers/test_img.dart';
import 'package:retroflux/providers/test_img_provider.dart';
import 'package:retroflux/widgets/test_img_item.dart';

class ProviderTestScreen extends StatefulWidget {
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

      body: TestImgGrid()
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
