import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Image> images = <Image>[];

    return MaterialApp(
      home: Scroller(
        images: images,
      ),
    );
  }
}

class Scroller extends StatefulWidget {
  const Scroller({
    Key? key,
    required this.images,
    this.testingController,
  }) : super(key: key);

  // This is a parameter to support testing in this repo
  final Controller? testingController;
  final List<Image> images;

  @override
  State<Scroller> createState() => _ScrollerState();
}

class _ScrollerState extends State<Scroller> {
  late Controller controller;

  @override
  initState() {
    controller = widget.testingController ?? Controller()
      ..addListener((event) {
        _handleCallbackEvent(event.direction, event.success);
      });

    // controller.jumpToPosition(4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TikTokStyleFullPageScroller(
        contentSize: widget.images.length,
        swipePositionThreshold: 0.2,
        // ^ the fraction of the screen needed to scroll
        swipeVelocityThreshold: 2000,
        // ^ the velocity threshold for smaller scrolls
        animationDuration: const Duration(milliseconds: 400),
        // ^ how long the animation will take
        controller: controller,
        // ^ registering our own function to listen to page changes
        builder: (BuildContext context, int index) {
          return Container(
            // color: widget.images[index],
            decoration: BoxDecoration(
              image: DecorationImage(
                image: widget.images[index].image,
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(children: [
              Center(
                child: Text(
                  'Type:' +
                      widget.images[index].image.runtimeType.toString() +
                      '\n' +
                      (widget.images[index].image as NetworkImage).url,
                  key: Key('$index-text'),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  color: Colors.white.withAlpha(125),
                  child: Column(
                    children: [
                      const Text(
                          "--- Buttons For Testing Controller Functions ---"),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text("Jump To:"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ...Iterable<int>.generate(widget.images.length)
                                .toList()
                                .map(
                                  (e) => MaterialButton(
                                    color: Colors.white.withAlpha(125),
                                    child: Text(
                                      "$e",
                                      key: Key('$e-jump'),
                                    ),
                                    onPressed: () =>
                                        controller.jumpToPosition(e),
                                  ),
                                )
                                .toList(),
                          ]),
                      const Text("Animate To:"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ...Iterable<int>.generate(widget.images.length)
                                .toList()
                                .map(
                                  (e) => MaterialButton(
                                    color: Colors.white.withAlpha(125),
                                    child: Text(
                                      "$e",
                                      key: Key('$e-animate'),
                                    ),
                                    onPressed: () =>
                                        controller.animateToPosition(e),
                                  ),
                                )
                                .toList(),
                          ]),
                    ],
                  ),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  void _handleCallbackEvent(ScrollDirection direction, ScrollSuccess success,
      {int? currentIndex}) {
    print(
        "Scroll callback received with data: {direction: $direction, success: $success and index: ${currentIndex ?? 'not given'}}");
  }
}
