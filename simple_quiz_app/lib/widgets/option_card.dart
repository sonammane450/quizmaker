import 'package:flutter/material.dart';
import '../constants.dart';

class OptionCard extends StatefulWidget {
  const OptionCard({
    Key? key,
    required this.option,
    required this.color,
    this.onTap,
  }) : super(key: key);
  
  final String option;
  final Color color;
  final VoidCallback? onTap;

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTap() {
    setState(() {
      _isPressed = true;
    });
    
    _scaleController.forward();
    
    Future.delayed(Duration(milliseconds: 150), () {
      if (mounted) {
        _scaleController.reverse();
        setState(() {
          _isPressed = false;
        });
      }
    });
    
    // Call the parent's onTap callback
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = widget.color == successColor;
    final bool isIncorrect = widget.color == errorColor;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
            decoration: BoxDecoration(
              gradient: isCorrect
                  ? successGradient
                  : isIncorrect
                      ? errorGradient
                      : cardGradient,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: _isPressed ? elevatedShadow : cardShadow,
              border: Border.all(
                color: isCorrect
                    ? successColor
                    : isIncorrect
                        ? errorColor
                        : surfaceVariant,
                width: isCorrect || isIncorrect ? 2.0 : 1.0,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _onTap,
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  child: Row(
                    children: [
                      // Option indicator
                      Container(
                        width: 32.0,
                        height: 32.0,
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? Colors.white.withOpacity(0.3)
                              : isIncorrect
                                  ? Colors.white.withOpacity(0.3)
                                  : primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Center(
                          child: Icon(
                            isCorrect
                                ? Icons.check
                                : isIncorrect
                                    ? Icons.close
                                    : Icons.radio_button_unchecked,
                            color: isCorrect || isIncorrect
                                ? Colors.white
                                : primaryColor,
                            size: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      // Option text
                      Expanded(
                        child: Text(
                          widget.option,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: isCorrect || isIncorrect
                                ? Colors.white
                                : textPrimary,
                            height: 1.4,
                          ),
                        ),
                      ),
                      // Status icon
                      if (isCorrect || isIncorrect)
                        Icon(
                          isCorrect ? Icons.check_circle : Icons.cancel,
                          color: Colors.white,
                          size: 24.0,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
