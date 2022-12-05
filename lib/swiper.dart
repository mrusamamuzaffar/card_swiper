import 'package:flutter/material.dart';

typedef SwiperWidgetBuilder = Widget Function(int index);

class Swiper extends StatefulWidget {
  final SwiperWidgetBuilder widgetBuilder;
  final int itemCount;
  final int visiblePageCount;
  final double dx;
  final double dy;
  final double aspectRatio;
  final double depthFactor;
  final double paddingStart;
  final double verticalPadding;

  const Swiper.builder({
    super.key,
    required this.widgetBuilder,
    required this.itemCount,
    this.visiblePageCount = 4,
    this.dx = 60,
    this.dy = 20,
    this.aspectRatio = 2 / 3,
    this.depthFactor = 0.2,
    this.paddingStart = 32,
    this.verticalPadding = 8,
  });

  @override
  SwiperState createState() => SwiperState();
}

class SwiperState extends State<Swiper> {
  late PageController _pageController;
  double _pagePosition = 0;
  final List<Widget> _widgetList = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _pagePosition = _pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          _getPages(),
          PageView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            itemCount: widget.itemCount,
            itemBuilder: (context, index) => Container(),
          ),
        ],
    );
  }

  Widget _getPages() {
    final List<Widget> pageList = [];
    final int currentPageIndex = _pagePosition.floor();
    final int lastPage = currentPageIndex + widget.visiblePageCount;
    final double width = MediaQuery.of(context).size.width;
    final double delta = _pagePosition - currentPageIndex;
    double top = -widget.dy * delta + widget.verticalPadding;
    double start = -widget.dx * delta + widget.paddingStart;
    pageList.add(_getWidgetForValues(top, -width * delta + widget.paddingStart, currentPageIndex));
    int i;
    int rIndex = 1;
    for (i = currentPageIndex + 1; i < lastPage; i++) {
      start += widget.dx;
      top += widget.dy;
      if (i >= widget.itemCount) continue;
      pageList.add(_getWidgetForValues(top, start * _getDepthFactor(rIndex, delta), i));
      rIndex++;
    }
    if (i < widget.itemCount) {
      start += widget.dx * delta;
      top += widget.dy;
      pageList.add(_getWidgetForValues(top, start * _getDepthFactor(rIndex, delta), i));
    }
    return Stack(children: pageList.reversed.toList());
  }

  double _getDepthFactor(int index, double delta) {
    return (1 - widget.depthFactor * (index - delta) / widget.visiblePageCount);
  }

  Widget _getWidgetForValues(double top, double start, int index) {
    Widget childWidget;
    if (index < _widgetList.length) {
      childWidget = _widgetList[index];
    } else {
      childWidget = widget.widgetBuilder(index);
      _widgetList.insert(index, childWidget);
    }
    return Positioned.directional(
      top: top,
      bottom: top,
      start: start,
      textDirection: TextDirection.ltr,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: childWidget,
      ),
    );
  }
}
