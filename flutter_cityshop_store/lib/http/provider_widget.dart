import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
 
 final Widget Function(BuildContext contex,T value, Widget child) builder;
 final T model;
 final Widget child;
 final Function(T) onReady;

 const ProviderWidget({Key key, this.builder, this.model, this.onReady, this.child}) : super(key: key);


  @override
  _ProviderWidgetState createState() => _ProviderWidgetState();
}

class _ProviderWidgetState extends State<ProviderWidget> {

  @override
  void initState() { 
    super.initState();
    if (widget.onReady != null) {
       widget.onReady(widget.model);
    } 
  } 


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(_) => widget.model,
       child: Consumer(
         builder: widget.builder,
          child: widget.child,
         ),
      );
  }
}

class T {
}