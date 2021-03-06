// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'basic.dart';
import 'framework.dart';

/// A widget that rebuilds when the given animation changes status.
abstract class StatusTransitionWidget extends StatefulWidget {
  /// Initializes fields for subclasses.
  ///
  /// The [animation] argument must not be null.
  StatusTransitionWidget({
    Key key,
    @required this.animation
  }) : super(key: key) {
    assert(animation != null);
  }

  /// The animation to which this widget is listening.
  final Animation<double> animation;

  /// Override this method to build widgets that depend on the current status
  /// of the animation.
  Widget build(BuildContext context);

  @override
  _StatusTransitionState createState() => new _StatusTransitionState();
}

class _StatusTransitionState extends State<StatusTransitionWidget> {
  @override
  void initState() {
    super.initState();
    widget.animation.addStatusListener(_animationStatusChanged);
  }

  @override
  void didUpdateWidget(StatusTransitionWidget oldWidget) {
    if (widget.animation != oldWidget.animation) {
      oldWidget.animation.removeStatusListener(_animationStatusChanged);
      widget.animation.addStatusListener(_animationStatusChanged);
    }
  }

  @override
  void dispose() {
    widget.animation.removeStatusListener(_animationStatusChanged);
    super.dispose();
  }

  void _animationStatusChanged(AnimationStatus status) {
    setState(() {
      // The animation's state is our build state, and it changed already.
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}
