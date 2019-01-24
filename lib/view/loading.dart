import 'package:flutter/material.dart';

class Loading {

  static _LoadingView _loadingView;

  static show(BuildContext context) {
    if (_loadingView != null){
      return;
    }
    var overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = new OverlayEntry(builder: (context) {
      return _buildToastLayout();
    });
    _loadingView = _LoadingView();
    _loadingView.overlayState = overlayState;
    _loadingView.overlayEntry = overlayEntry;
    _loadingView.show();
  }

  static dismiss(){
    if (_loadingView == null){
      return;
    }
    _loadingView.dismiss();
    _loadingView = null;
  }

  static LayoutBuilder _buildToastLayout() {
    return LayoutBuilder(builder: (context, constraints) {
      return IgnorePointer(
        ignoring: true,
        child: Container(
          child: Material(
            color: Colors.white.withOpacity(0),
            child: Container(
              width: 102.0,
              height: 102.0,
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                  color: const Color(0xfff2f2f2),
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              child: new CircularProgressIndicator(),
            ),
          ),
          alignment: Alignment.center,
        ),
      );
    });
  }
}

class _LoadingView {
  OverlayEntry overlayEntry;
  OverlayState overlayState;

  show() {
    overlayState.insert(overlayEntry);
//    await Future.delayed(Duration(milliseconds: 3500));
//    this.dismiss();
  }

  dismiss() {
    overlayEntry?.remove();
  }
}
