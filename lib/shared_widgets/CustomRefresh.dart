import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

class CustomRefreshWrapper extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const CustomRefreshWrapper({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<CustomRefreshWrapper> createState() => _CustomRefreshWrapperState();
}

class _CustomRefreshWrapperState extends State<CustomRefreshWrapper>
    with SingleTickerProviderStateMixin {
  static const double _triggerOffset = 110;
  static const double _maxIndicatorHeight = 124;

  late final AnimationController _spinController;

  double _dragOffset = 0;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  void _handleVerticalDragUpdate(DragUpdateDetails details) {
    if (_isRefreshing || details.delta.dy <= 0) return;

    setState(() {
      _dragOffset = (_dragOffset + (details.delta.dy * 0.9)).clamp(
        0.0,
        _maxIndicatorHeight,
      );
    });
  }

  Future<void> _handleVerticalDragEnd(DragEndDetails details) async {
    if (_isRefreshing) return;

    if (_dragOffset >= _triggerOffset) {
      setState(() {
        _isRefreshing = true;
        _dragOffset = _maxIndicatorHeight * 0.82;
      });

      _spinController.repeat();

      await widget.onRefresh();

      if (!mounted) return;

      _spinController.stop();

      setState(() {
        _isRefreshing = false;
        _dragOffset = 0;
      });
    } else {
      setState(() {
        _dragOffset = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_dragOffset / _triggerOffset).clamp(0.0, 1.0);
    final indicatorVisible = _dragOffset > 0 || _isRefreshing;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: _handleVerticalDragUpdate,
      onVerticalDragEnd: _handleVerticalDragEnd,
      child: Stack(
        children: [
          AnimatedSlide(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            offset: Offset(0, indicatorVisible ? _dragOffset / 260 : 0),
            child: widget.child,
          ),
          IgnorePointer(
            ignoring: true,
            child: SafeArea(
              bottom: false,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                height: indicatorVisible ? math.max(0, _dragOffset) : 0,
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: indicatorVisible ? 1 : 0,
                  child: Transform.translate(
                    offset: Offset(0, math.min(_dragOffset * 0.18, 18)),
                    child: _RefreshIndicatorCard(
                      progress: progress,
                      isRefreshing: _isRefreshing,
                      spinController: _spinController,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RefreshIndicatorCard extends StatelessWidget {
  final double progress;
  final bool isRefreshing;
  final AnimationController spinController;

  const _RefreshIndicatorCard({
    required this.progress,
    required this.isRefreshing,
    required this.spinController,
  });

  @override
  Widget build(BuildContext context) {
    final easedProgress = Curves.easeOutBack.transform(progress);
    final borderOpacity = 0.12 + (progress * 0.14);
    final cardScale = 0.9 + (math.min(progress, 1) * 0.1);

    return Transform.scale(
      scale: isRefreshing ? 1 : cardScale,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Appcolors.primarycolor.withValues(alpha: borderOpacity),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: isRefreshing ? null : progress,
                    strokeWidth: 2.6,
                    color: Appcolors.primarycolor,
                    backgroundColor: Appcolors.primarycolor.withValues(
                      alpha: 0.12,
                    ),
                  ),
                  RotationTransition(
                    turns: Tween<double>(
                      begin: 0,
                      end: isRefreshing ? 1 : easedProgress * 0.35,
                    ).animate(spinController),
                    child: Icon(
                      isRefreshing ? Icons.sync_rounded : Icons.south_rounded,
                      size: 16,
                      color: Appcolors.primarycolor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              child: Text(
                isRefreshing
                    ? 'جارٍ تحديث البيانات...'
                    : progress >= 1
                    ? 'اترك لإعادة التحديث'
                    : 'اسحب لأسفل للتحديث',
                key: ValueKey('${isRefreshing}_$progress'),
                style: cairoStyle(
                  fontSize: 13,
                  fontweight: FontWeight.w600,
                  fontcolor: Color(0xFF344054),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
