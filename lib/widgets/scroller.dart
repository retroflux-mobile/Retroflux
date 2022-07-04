import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

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
  late List<ItemScrollController> itemControllers;

  Future scrollToItem(int listIdx, int itemIdx) async {
    if(!itemControllers[listIdx].isAttached){
      print('null controller');
    }
    itemControllers[listIdx].scrollTo(
        index: itemIdx + 1, duration: const Duration(milliseconds: 500));
  }

  @override
  initState() {
    super.initState();
    controller = widget.testingController ?? Controller()
      ..addListener((event) {
        _handleCallbackEvent(event.direction, event.success);
      });
    itemControllers = List<ItemScrollController>.generate(
        widget.images.length, (int index) => ItemScrollController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TikTokStyleFullPageScroller(
        contentSize: widget.images.length,
        swipePositionThreshold: 0.05,
        // ^ the fraction of the screen needed to scroll
        swipeVelocityThreshold: 1000,
        // ^ the velocity threshold for smaller scrolls
        animationDuration: const Duration(milliseconds: 300),
        // ^ how long the animation will take
        controller: controller,
        // ^ registering our own function to listen to page changes
        builder: (BuildContext context, int listIdx) {
          return ScrollablePositionedList.builder(
            scrollDirection: Axis.horizontal,
            itemScrollController: itemControllers[listIdx],
            itemCount: 5,
            itemBuilder: (BuildContext context, int itemIdx) {
              return InkWell(
                  onTap: () {
                    scrollToItem(listIdx, itemIdx);
                  },
                  child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                            listIdx.toString() + ', ' + itemIdx.toString()),
                      )));
            },
          );
        },
      ),
    );
  }

  void _handleCallbackEvent(ScrollDirection direction, ScrollSuccess success,
      {int? currentIndex}) {
    print(
        "Scroll callback received with data: {direction: $direction, success: $success and index: ${currentIndex ??
            'not given'}}");
  }
}