import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Scroller extends StatefulWidget {
  final List<List<Widget>> widgetList;

  const Scroller({
    Key? key,
    required this.widgetList,
  }) : super(key: key);

  @override
  State<Scroller> createState() => _ScrollerState();
}

class _ScrollerState extends State<Scroller> {
  late Controller controller;
  late List<ItemScrollController> itemControllers;

  Future scrollToItem(int listIdx, int itemIdx) async {
    itemControllers[listIdx].scrollTo(index: itemIdx, duration: const Duration(milliseconds: 200));
  }

  @override
  initState() {
    super.initState();
    controller = Controller()
      ..addListener((event) {
        _handleCallbackEvent(event.direction, event.success);
      });
    itemControllers = List<ItemScrollController>.generate(
        widget.widgetList.length, (int index) => ItemScrollController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TikTokStyleFullPageScroller(
        contentSize: widget.widgetList.length,
        swipePositionThreshold: 0.05,
        // ^ the fraction of the screen needed to scroll
        swipeVelocityThreshold: 1000,
        // ^ the velocity threshold for smaller scrolls
        controller: controller,
        // ^ registering our own function to listen to page changes
        builder: (BuildContext context, int listIdx) {
          return ScrollablePositionedList.builder(
            scrollDirection: Axis.horizontal,
            itemScrollController: itemControllers[listIdx],
            itemCount: widget.widgetList[listIdx].length,
            itemBuilder: (BuildContext context, int itemIdx) {
              return GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  if (details.primaryDelta! < 0.0) {
                    scrollToItem(listIdx, min(widget.widgetList[listIdx].length - 1, itemIdx + 1));
                  }
                  else {
                    scrollToItem(listIdx, max(0, itemIdx - 1));
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: widget.widgetList[listIdx][itemIdx],
                  )
                )
              );
            },
          );
        },
      ),
    );
  }

  void _handleCallbackEvent(ScrollDirection direction, ScrollSuccess success,{int? currentIndex}) {
    print("Scroll callback received with data: {direction: $direction, success: $success and index: ${currentIndex ?? 'not given'}}");
  }
}
