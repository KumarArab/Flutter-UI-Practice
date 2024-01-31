// ignore_for_file: constant_identifier_names

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testapp/UIs/crossSell/custom_bottom_sheet/ellipse/ellipse_widget.dart';

const GOLDEN_RATIO = 1.6180339;
const GOLDEN_RATIO_A = GOLDEN_RATIO / (1 + GOLDEN_RATIO);
const GOLDEN_RATIO_B = 1 - GOLDEN_RATIO_A;

class BottomSheetState {
  Offset _currentOffset = Offset.zero;
  Offset _currentDelta = Offset.zero;
  bool _isAnimatingTheFirstTime = true;
  final double minVisibleFraction;

  BottomSheetState(this.minVisibleFraction);

  void translateByDeltaIfPossible(Offset delta) {
    _currentDelta = delta;
  }
}

class MyCustomFlowDelegate extends FlowDelegate {
  static const UPPER_BODY_ID = 0;
  static const BLUR_EFFECT_ID = 1;
  static const BOTTOM_SHEET_ID = 2;

  final BottomSheetState state;
  final AnimationController animationController;
  MyCustomFlowDelegate(this.state, this.animationController) : super(repaint: animationController);

  @override
  void paintChildren(FlowPaintingContext context) {
    final proposedOffset = proposeNewOffset(context);

    state._currentOffset = proposedOffset;

    final extraHeight = 30 * getBlurOpacity(context);

    final upperBodyOffsetY = getUpperBodyOffsetY(context);
    context.paintChild(UPPER_BODY_ID, transform: Matrix4.translationValues(0, upperBodyOffsetY, 0));
    // context.paintChild(BLUR_EFFECT_ID,
    //     transform: Matrix4.translationValues(0, state._currentOffset.dy - extraHeight, 0));
    context.paintChild(BOTTOM_SHEET_ID, transform: Matrix4.translationValues(0, state._currentOffset.dy, 0.0));
  }

  Offset proposeNewOffset(FlowPaintingContext context) {
    final screenHeight = context.size.height;
    final maxBottomSheetHeight = context.getChildSize(BOTTOM_SHEET_ID)!.height;
    final minBottomSheetHeight = maxBottomSheetHeight * state.minVisibleFraction;
    late Offset proposedOffset;

    // For setting initial height
    if (state._isAnimatingTheFirstTime) {
      final proposedfraction = animationController.value;
      proposedOffset = Offset(0, screenHeight - (maxBottomSheetHeight * proposedfraction));
      return proposedOffset;
    }

    // handle animation

    if (animationController.isAnimating) {
      state._currentDelta = Offset.zero;
      final proposedfraction = animationController.value.clamp(state.minVisibleFraction, 1);
      proposedOffset = Offset(0, screenHeight - (maxBottomSheetHeight * proposedfraction));
      return proposedOffset;
    } else {
      // print("${state._currentOffset.dy} from inside");
      double proposedOffsetY = state._currentOffset.dy + state._currentDelta.dy * GOLDEN_RATIO;
      proposedOffsetY = proposedOffsetY.clamp(screenHeight - maxBottomSheetHeight, screenHeight - minBottomSheetHeight);
      proposedOffset = Offset(0, proposedOffsetY);
      return proposedOffset;
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }

  double getBlurOpacity(FlowPaintingContext context) {
    final maxBottomSheetHeight = context.getChildSize(BOTTOM_SHEET_ID)!.height;
    final minBottomSheetHeight = maxBottomSheetHeight * state.minVisibleFraction;
    final differenceBottomSheetHeight = maxBottomSheetHeight - minBottomSheetHeight;
    final currentBottomSheetHeight = context.size.height - state._currentOffset.dy;
    final currentBottomSheetHeightAfterMinimum = currentBottomSheetHeight - minBottomSheetHeight;
    return 1 - 2 * (currentBottomSheetHeightAfterMinimum / differenceBottomSheetHeight);
  }

  double getUpperBodyOffsetY(FlowPaintingContext context) {
    final maxBottomSheetHeight = context.getChildSize(BOTTOM_SHEET_ID)!.height;
    final minBottomSheetHeight = maxBottomSheetHeight * state.minVisibleFraction;
    final currentBottomSheetHeight = context.size.height - state._currentOffset.dy;
    final currentBottomSheetHeightAfterMinimum = currentBottomSheetHeight - minBottomSheetHeight;
    return min(0, -currentBottomSheetHeightAfterMinimum);
  }
}

class CBBottomSheet extends StatefulWidget {
  final double minVisibleFraction;
  final Widget backGroundScreen;
  const CBBottomSheet(this.minVisibleFraction, {Key? key, required this.backGroundScreen}) : super(key: key);

  @override
  State<CBBottomSheet> createState() => _CBBottomSheetState();
}

class _CBBottomSheetState extends State<CBBottomSheet> with SingleTickerProviderStateMixin {
  late BottomSheetState bottomSheetState;
  late AnimationController _animationController;
  final bottomSheetKey = GlobalKey();

  @override
  void initState() {
    bottomSheetState = BottomSheetState(widget.minVisibleFraction);
    _animationController = AnimationController(vsync: this);
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 600));
      _animationController.value = 0;
      setState(() {
        _animationController
            .animateTo(
              widget.minVisibleFraction,
              duration: const Duration(milliseconds: 600),
              curve: Curves.decelerate,
            )
            .whenComplete(() => bottomSheetState._isAnimatingTheFirstTime = false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flow(
        delegate: MyCustomFlowDelegate(
          bottomSheetState,
          _animationController,
        ),
        children: [
          widget.backGroundScreen,
          const Stack(
            children: [
              Align(alignment: Alignment.topLeft, child: EllipseWidget()),
              Align(alignment: Alignment.topCenter, child: EllipseWidget())
            ],
          ),
          Listener(
            behavior: HitTestBehavior.translucent,
            onPointerUp: (event) {
              if (_animationController.isAnimating) return;

              setState(() {
                final screenHeight = context.size!.height;
                final currentBottomSheetHeight = screenHeight - bottomSheetState._currentOffset.dy;

                final bottomSheetRenderBox = bottomSheetKey.currentContext?.findRenderObject() as RenderBox?;
                final maxBottomSheetHeight = bottomSheetRenderBox!.size.height;

                _animationController.value = currentBottomSheetHeight / maxBottomSheetHeight;

                final minBottomSheetHeight = maxBottomSheetHeight * widget.minVisibleFraction;
                final differenceBottomSheetHeight = maxBottomSheetHeight - minBottomSheetHeight;

                final currentBottomSheetHeightAfterMinimum = currentBottomSheetHeight - minBottomSheetHeight;

                _animationController.value = (currentBottomSheetHeight) / maxBottomSheetHeight;

                final isMovingDown = bottomSheetState._currentDelta.dy > 0;
                final goldenRatioThreshold = isMovingDown ? GOLDEN_RATIO_A : GOLDEN_RATIO_B;

                if (currentBottomSheetHeightAfterMinimum > differenceBottomSheetHeight * goldenRatioThreshold) {
                  print("${_animationController.value} ${1} ");
                  _animateTo(1);
                } else {
                  _animateTo(widget.minVisibleFraction);
                }
              });
            },
            onPointerMove: (event) {
              if (_animationController.isAnimating) return;
              setState(() {
                final delta = event.localDelta;
                bottomSheetState._currentDelta = delta;

                final screenHeight = context.size!.height;

                final currentBottomSheetHeight = screenHeight - bottomSheetState._currentOffset.dy;
                final bottomSheetRenderBox = bottomSheetKey.currentContext?.findRenderObject() as RenderBox?;
                final maxBottomSheetHeight = bottomSheetRenderBox!.size.height;
                _animationController.value = currentBottomSheetHeight / maxBottomSheetHeight;

                if (delta.dy.abs() > 10 * GOLDEN_RATIO) {
                  final double targetValue = delta.dy < 0 ? 1 : widget.minVisibleFraction;
                  _animateTo(targetValue);
                } else {
                  bottomSheetState.translateByDeltaIfPossible(event.localDelta);
                }
              });
            },
            child: Container(
              key: bottomSheetKey,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.18),
                // color: Colors.black,
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.cyanAccent,
                    Colors.black,
                  ],
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.7,
            ),
          )
        ],
      ),
    );
  }

  TickerFuture _animateTo(double fraction) {
    return _animationController.animateTo(
      fraction,
      duration: Duration(milliseconds: (100 * GOLDEN_RATIO * GOLDEN_RATIO * GOLDEN_RATIO).toInt()),
      curve: Curves.decelerate,
    );
  }
}
