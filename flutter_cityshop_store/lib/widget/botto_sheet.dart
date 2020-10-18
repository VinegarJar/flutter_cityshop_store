import 'package:flutter/material.dart';

Future<T> showCustomModalSheet<T>({
  bool isScrollControlled = false,
  @required BuildContext context,
  @required Widget builder,
}) {
  assert(context != null);
  assert(builder != null);
  assert(isScrollControlled != null);
  return Navigator.of(context).push(_modalBottomSheetRoute(
    builder: builder,
    isScrollControlled: isScrollControlled
  ));
}

Route _modalBottomSheetRoute({
  Widget builder,
  @required isScrollControlled,
}) {
  return PageRouteBuilder(
    opaque: false,
    pageBuilder: (context, animation, secondaryAnimation) =>
        BottomSheet(builder: builder,isScrollControlled:isScrollControlled,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.linear;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class BottomSheet extends StatefulWidget {
  final Widget builder;
  final bool   isScrollControlled;
  BottomSheet({Key key, 
              this.builder, 
              this.isScrollControlled}) : super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    return 
    
    GestureDetector(
        onTap: () {
          Navigator.pop(context);
          print("关闭");
        },
        child: Scaffold(
            backgroundColor: Colors.black54,
            body: CustomSingleChildLayout(
              delegate: FixedSizeLayoutDelegate(isScrollControlled: widget.isScrollControlled),
              child: widget.builder,
     )));
  }
}

class FixedSizeLayoutDelegate extends SingleChildLayoutDelegate {
  FixedSizeLayoutDelegate({this.progress = 1.0, this.isScrollControlled});

  final double progress;
  final bool isScrollControlled;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: isScrollControlled
          ? constraints.maxHeight
          : constraints.maxHeight * 9.0 / 16.0,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(FixedSizeLayoutDelegate oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
