import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'ui/widgets/zoom_swiper.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  /// List of image URLs to display in the slider.
  static const images = <String>[
    'assets/images/image1.png',
    'assets/images/image2.jpeg',
    'assets/images/image3.png',
    'assets/images/image4.png',
    'assets/images/image5.jpeg',
    'assets/images/image6.jpg'
  ];

  /// List of image URLs to display in the slider.
  static const images1 = <String>[
    'assets/images/image7.jpg',
    'assets/images/image8.jpg',
    'assets/images/image9.jpg',
    'assets/images/image10.jpg',
    'assets/images/image11.jpg',
    'assets/images/image12.jpg'
  ];

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _animationController
      ..forward()
      ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const text = 'Zoom and swipe through images';
    const zoomS = 'Zoom Swiper';
    const swiper = 'Swiper...';
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    zoomS.length,
                    (index) => TextShimmer(
                      key: ValueKey('$index'),
                      animationController: _animationController,
                      length: zoomS.hashCode,
                      char: zoomS[index],
                      index: index + 3,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(Icons.zoom_in_map),
            const SizedBox(
              width: 10.0,
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    swiper.length,
                    (index) => TextShimmer(
                      key: ValueKey('$index'),
                      animationController: _animationController,
                      length: swiper.length,
                      char: swiper[index],
                      index: index + 1,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 10.0,
            ),
            const Icon(Icons.zoom_in_map),
            const SizedBox(
              width: 10.0,
            ),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    zoomS.length,
                    (index) => TextShimmer(
                      key: ValueKey('$index'),
                      animationController: _animationController,
                      length: zoomS.hashCode,
                      char: zoomS[index],
                      index: index + 3,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      text.length,
                      (index) => TextShimmer(
                        key: ValueKey('$index'),
                        animationController: _animationController,
                        length: text.length,
                        char: text[index],
                        index: index + 1,
                      ),
                    ),
                  );
                },
              ),
            ),
            // The following examples show how to use the ZoomSwiper widget with different
            // zoom modes.
            const SizedBox(
              height: 350,
              child: ZoomSwiper(
                // List of image URLs to display
                images: Beranda.images,
                // Images will zoom out when swiped
                zoomMode: ZoomMode.zoomOut,
                // Fraction of the viewport for each image
                viewPortFraction: 0.85,
              ),
            ),
            const SizedBox(
              height: 350,
              child: ZoomSwiper(
                // List of image URLs to display
                images: Beranda.images1,
                // Images will zoom in when swiped
                zoomMode: ZoomMode.zoomIn,
                // Fraction of the viewport for each image
                viewPortFraction: 0.85,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextShimmer extends StatefulWidget {
  final AnimationController animationController;
  final int length;
  final String char;
  final int index;

  const TextShimmer({
    super.key,
    required this.animationController,
    required this.length,
    required this.char,
    required this.index,
  });

  @override
  State<TextShimmer> createState() => _TextShimmerState();
}

class _TextShimmerState extends State<TextShimmer> {
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    double startValue = (widget.index / widget.length) * 0.5;
    double endValue = math.min(startValue + 0.2, 1.0);
    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.25)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.25, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50.0,
      ),
    ]).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(startValue, endValue),
      ),
    );

    _colorAnimation = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(
          begin: const Color(0xFF56CED0),
          end: const Color(0xFFbcfbff),
        ),
        weight: 50.0,
      ),
      TweenSequenceItem(
        tween: ColorTween(
          begin: const Color(0xFFbcfbff),
          end: const Color(0xFF3A777B),
        ),
        weight: 50.0,
      ),
    ]).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(startValue, endValue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Text(
        widget.char,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: _colorAnimation.value!,
            ),
      ),
    );
  }
}
