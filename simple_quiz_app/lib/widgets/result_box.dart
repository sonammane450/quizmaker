import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../constants.dart';

class ResultBox extends StatefulWidget {
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLength,
    required this.onPressed,
    this.userName = '',
  }) : super(key: key);
  
  final int result;
  final int questionLength;
  final VoidCallback onPressed;
  final String userName;

  @override
  State<ResultBox> createState() => _ResultBoxState();
}

class _ResultBoxState extends State<ResultBox> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _confettiController = ConfettiController(duration: const Duration(seconds: 3));

    _scaleController.forward();
    _pulseController.repeat(reverse: true);
    
    // Start confetti after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _confettiController.play();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pulseController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double percentage = (widget.result / widget.questionLength) * 100;
    final bool isExcellent = percentage >= 80;
    final bool isGood = percentage >= 60;
    final bool isAverage = percentage >= 40;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          // Confetti Animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 1.57, // Downward
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.yellow,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
          // Main Content
          AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    gradient: cardGradient,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: elevatedShadow,
                    border: Border.all(
                      color: surfaceVariant,
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isExcellent
                                  ? Icons.celebration
                                  : isGood
                                      ? Icons.thumb_up
                                      : isAverage
                                          ? Icons.sentiment_neutral
                                          : Icons.sentiment_dissatisfied,
                              color: isExcellent
                                  ? successColor
                                  : isGood
                                      ? primaryColor
                                      : isAverage
                                          ? warningColor
                                          : errorColor,
                              size: 32.0,
                            ),
                            const SizedBox(width: 12.0),
                            Text(
                              'Quiz Complete!',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24.0),
                        
                        // Personalized Message
                        if (widget.userName.isNotEmpty)
                          Text(
                            'Congratulations ${widget.userName}! 🎉',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        if (widget.userName.isNotEmpty) const SizedBox(height: 16.0),
                        
                        // Score Circle
                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  gradient: isExcellent
                                      ? successGradient
                                      : isGood
                                          ? primaryGradient
                                          : isAverage
                                              ? LinearGradient(
                                                  colors: [warningColor, warningColor.withOpacity(0.7)],
                                                )
                                              : errorGradient,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: (isExcellent
                                              ? successColor
                                              : isGood
                                                  ? primaryColor
                                                  : isAverage
                                                      ? warningColor
                                                      : errorColor)
                                          .withOpacity(0.3),
                                      blurRadius: 20.0,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${widget.result}',
                                        style: const TextStyle(
                                          fontSize: 36.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '/${widget.questionLength}',
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        
                        const SizedBox(height: 24.0),
                        
                        // Percentage
                        Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: isExcellent
                                ? successColor
                                : isGood
                                    ? primaryColor
                                    : isAverage
                                        ? warningColor
                                        : errorColor,
                          ),
                        ),
                        
                        const SizedBox(height: 16.0),
                        
                        // Message
                        Text(
                          isExcellent
                              ? 'Outstanding! 🎉'
                              : isGood
                                  ? 'Great Job! 👏'
                                  : isAverage
                                      ? 'Not Bad! 💪'
                                      : 'Keep Trying! 💪',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: textPrimary,
                          ),
                        ),
                        
                        const SizedBox(height: 8.0),
                        
                        Text(
                          isExcellent
                              ? 'You\'re a quiz master!'
                              : isGood
                                  ? 'Well done!'
                                  : isAverage
                                      ? 'You can do better!'
                                      : 'Practice makes perfect!',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: textSecondary,
                          ),
                        ),
                        
                        const SizedBox(height: 32.0),
                        
                        // Action Button
                        Container(
                          width: double.infinity,
                          height: 56.0,
                          decoration: BoxDecoration(
                            gradient: primaryGradient,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.3),
                                blurRadius: 20.0,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: widget.onPressed,
                              borderRadius: BorderRadius.circular(16.0),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      'Try Again',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
