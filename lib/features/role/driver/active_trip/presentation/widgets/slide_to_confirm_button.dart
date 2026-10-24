import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideToConfirmButton extends StatefulWidget {
  final VoidCallback onConfirmed;
  final String text;

  const SlideToConfirmButton({
    super.key,
    required this.onConfirmed,
    this.text = 'Slide to confirm arrival',
  });

  @override
  State<SlideToConfirmButton> createState() => _SlideToConfirmButtonState();
}

class _SlideToConfirmButtonState extends State<SlideToConfirmButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  bool _isConfirmed = false;

  late AnimationController _animController;
  late Animation<double> _returnAnimation;

  final double _thumbWidth = 46.0;
  final double _padding = 4.0;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener(() {
        setState(() {
          _dragPosition = _returnAnimation.value;
        });
      });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details, double maxDrag) {
    if (_isConfirmed) return;
    setState(() {
      _dragPosition = (_dragPosition + details.delta.dx).clamp(0.0, maxDrag);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details, double maxDrag) {
    if (_isConfirmed) return;

    if (_dragPosition >= maxDrag * 0.70) {
      // Confirmed! Animate smoothly to maxDrag, then trigger callback
      _returnAnimation = Tween<double>(
        begin: _dragPosition,
        end: maxDrag,
      ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut),
      );
      _animController.forward(from: 0.0).then((_) {
        setState(() {
          _isConfirmed = true;
        });
        widget.onConfirmed();
      });
    } else {
      // Snap back to initial position (0.0)
      _returnAnimation = Tween<double>(
        begin: _dragPosition,
        end: 0.0,
      ).animate(
        CurvedAnimation(parent: _animController, curve: Curves.easeOut),
      );
      _animController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = 54.h;
    final double thumbSize = buttonHeight - (_padding * 2);

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxDrag =
            (constraints.maxWidth - thumbSize - (_padding * 2)).clamp(0.0, 9999.0);
        final double progress = maxDrag > 0 ? (_dragPosition / maxDrag) : 0.0;

        return Container(
          width: double.infinity,
          height: buttonHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF1B2B68),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1B2B68).withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// Centered "Slide to confirm arrival" Text (fades as slider approaches end)
              Opacity(
                opacity: (1.0 - (progress * 1.5)).clamp(0.0, 1.0),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ),

              /// Draggable White Thumb with Navy Chevron `>`
              Positioned(
                left: _padding + _dragPosition,
                top: _padding,
                bottom: _padding,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) =>
                      _onHorizontalDragUpdate(details, maxDrag),
                  onHorizontalDragEnd: (details) =>
                      _onHorizontalDragEnd(details, maxDrag),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: const Color(0xFF1B2B68),
                        size: 24.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
