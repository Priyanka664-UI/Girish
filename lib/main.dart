import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const BoyfriendScrapbookApp());
}

// SPIDER-MAN COLORS
const Color elegantRed = Color(0xFFE23636);
const Color elegantBlue = Color(0xFF1B4B91);
const Color elegantBlack = Color(0xFF121212);
const Color elegantGold = Color(0xFFFFD700);
const Color elegantWhite = Color(0xFFFFFFFF); // Off-white for panels

class BoyfriendScrapbookApp extends StatelessWidget {
  const BoyfriendScrapbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boyfriend Day',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: elegantBlack,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.playfairDisplay(color: elegantWhite),
          bodyLarge: GoogleFonts.lora(color: elegantBlack),
          bodyMedium: GoogleFonts.lora(color: elegantBlack),
        ),
      ),
      home: const MainPagerScreen(),
    );
  }
}

// ==========================================
// MAIN PAGER (SWIPE THROUGH PAGES)
// ==========================================
class MainPagerScreen extends StatefulWidget {
  const MainPagerScreen({super.key});

  @override
  State<MainPagerScreen> createState() => _MainPagerScreenState();
}

class _MainPagerScreenState extends State<MainPagerScreen> {
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
  
  void _prevPage() {
    _pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Webs
            const Positioned.fill(child: SpiderWebBackground()),
            
            PageView(
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              children: [
                CoverPage(onNext: _nextPage),
                MyHeroPage(onNext: _nextPage, onPrev: _prevPage),
                LoveLetterPage(onNext: _nextPage, onPrev: _prevPage),
                MyDarlingPage(onNext: _nextPage, onPrev: _prevPage),
                ReasonsPage(onNext: _nextPage, onPrev: _prevPage),
                FinalWordsPage(onPrev: _prevPage),
              ],
            ),
            
            // Floating Spiders / Webs
            const Positioned.fill(child: IgnorePointer(child: FloatingSpideyGraphics())),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 1. COVER PAGE
// ==========================================
class CoverPage extends StatefulWidget {
  final VoidCallback onNext;
  const CoverPage({super.key, required this.onNext});

  @override
  State<CoverPage> createState() => _CoverPageState();
}

class _CoverPageState extends State<CoverPage> with SingleTickerProviderStateMixin {
  late AnimationController _heartbeatController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _heartbeatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _heartbeatController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _heartbeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.favorite, size: 280, color: elegantRed.withOpacity(0.9)),
                Transform.rotate(
                  angle: -0.05,
                  child: Text(
                    "Happy\nBoyfriend\nDay\nGirish! 🕸️",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 45, 
                      color: elegantGold, 
                      height: 1.1,
                      shadows: const [
                        Shadow(color: elegantRed, offset: Offset(3,3)), 
                        Shadow(color: Colors.black, offset: Offset(5,5))
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          GestureDetector(
            onTap: widget.onNext,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              decoration: BoxDecoration(
                color: elegantBlue,
                border: Border.all(color: elegantGold.withOpacity(0.3), width: 1),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 8))],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("NEXT", style: GoogleFonts.playfairDisplay(fontSize: 32, color: elegantWhite, letterSpacing: 2)),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward, color: elegantWhite),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ==========================================
// 2. MY HERO
// ==========================================
class MyHeroPage extends StatelessWidget {
  final VoidCallback onNext, onPrev;
  const MyHeroPage({super.key, required this.onNext, required this.onPrev});

  @override
  Widget build(BuildContext context) {
    return _buildPageLayout(
      onNext: onNext, onPrev: onPrev,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text("My Man ❤️🕷️", style: GoogleFonts.playfairDisplay(fontSize: 40, color: elegantWhite, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10).copyWith(bottom: 100),
              children: [
                Center(child: _buildComicPolaroid('assets/photos/girish1.jpeg', -0.04, "The Best!")),
                const SizedBox(height: 40),
                Center(child: _buildComicPolaroid('assets/photos/girish2.jpeg', 0.05, "My Spidey")),
                const SizedBox(height: 40),
                Center(child: _buildComicPolaroid('assets/photos/girish3.jpeg', -0.03, "Cutie Pie")),
                const SizedBox(height: 40),
                Center(child: _buildComicPolaroid('assets/photos/girish4.jpeg', 0.04, "My Love")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComicPolaroid(String imagePath, double angle, String caption) {
    return Transform.rotate(
      angle: angle,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: elegantWhite,
          border: Border.all(color: elegantGold.withOpacity(0.5), width: 1),
          boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 8))],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
              child: Image.asset(imagePath, width: 250, height: 250, fit: BoxFit.cover, errorBuilder: (c,e,s) => Container(width: 250, height: 250, color: Colors.grey)),
            ),
            const SizedBox(height: 15),
            Text(caption, style: GoogleFonts.montserrat(fontSize: 28, color: elegantBlue)),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. LOVE LETTER PAGE
// ==========================================
class LoveLetterPage extends StatefulWidget {
  final VoidCallback onNext, onPrev;
  const LoveLetterPage({super.key, required this.onNext, required this.onPrev});

  @override
  State<LoveLetterPage> createState() => _LoveLetterPageState();
}

class _LoveLetterPageState extends State<LoveLetterPage> with SingleTickerProviderStateMixin {
  late AnimationController _flowerController;

  @override
  void initState() {
    super.initState();
    _flowerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _flowerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPageLayout(
      onNext: widget.onNext, onPrev: widget.onPrev,
      child: Stack(
        children: [
          // Animated Background Flowers
          AnimatedBuilder(
            animation: _flowerController,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: 100 + (20 * _flowerController.value),
                    left: 20,
                    child: Transform.rotate(angle: _flowerController.value, child: const Text("🌸", style: TextStyle(fontSize: 40))),
                  ),
                  Positioned(
                    top: 300 - (15 * _flowerController.value),
                    right: 30,
                    child: Transform.rotate(angle: -_flowerController.value, child: const Text("🌺", style: TextStyle(fontSize: 50))),
                  ),
                  Positioned(
                    bottom: 150 + (25 * _flowerController.value),
                    left: 40,
                    child: Transform.rotate(angle: _flowerController.value * 1.5, child: const Text("🌻", style: TextStyle(fontSize: 35))),
                  ),
                  Positioned(
                    bottom: 250,
                    right: 20,
                    child: Transform.translate(offset: Offset(0, -30 * _flowerController.value), child: const Text("🌷", style: TextStyle(fontSize: 45))),
                  ),
                ],
              );
            },
          ),
          
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 40, bottom: 100, left: 20, right: 20),
            child: Column(
              children: [
                Transform.rotate(
                  angle: -0.02,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: elegantWhite,
                      border: Border.all(color: elegantGold.withOpacity(0.5), width: 1),
                      boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 8))],
                    ),
                    child: Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 3)),
                      child: Image.asset('assets/photos/prigir.jpeg', width: 250, height: 250, fit: BoxFit.cover, errorBuilder: (c,e,s) => Container(width: 250, height: 250, color: Colors.grey)),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                AnimatedBuilder(
                  animation: _flowerController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 10 * sin(_flowerController.value * pi * 2)),
                      child: Transform.rotate(
                        angle: 0.02 * cos(_flowerController.value * pi * 2),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    width: 340,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: elegantWhite,
                      border: Border.all(color: elegantGold.withOpacity(0.5), width: 1),
                      boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 8))],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("My love,", style: GoogleFonts.playfairDisplay(fontSize: 30, color: elegantRed)),
                        const SizedBox(height: 15),
                        Text(
                          "Thank God I got into diploma 🎓\n"
                          "Thank God he had a 1-year gap ⏳\n"
                          "Thank God I chose computer engineering 💻\n"
                          "Thank God I moved to TYCO1 🏫\n"
                          "Thank God I got into D batch 📚\n"
                          "Thank God I met Girish ❤️\n"
                          "Thank God he talked to me 🗣️\n"
                          "Thank God he messaged me 📱\n"
                          "Thank God I replied to him ✨\n"
                          "Thank God I met the person that is now my forever ♾️💖\n\n"
                          "Yours always,\n"
                          "[ugly suar]",
                          style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.bold, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 4. MY DARLING
// ==========================================
class MyDarlingPage extends StatefulWidget {
  final VoidCallback onNext, onPrev;
  const MyDarlingPage({super.key, required this.onNext, required this.onPrev});

  @override
  State<MyDarlingPage> createState() => _MyDarlingPageState();
}

class _MyDarlingPageState extends State<MyDarlingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScroll();
    });
  }

  void _autoScroll() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 30),
        curve: Curves.linear,
      ).then((_) {
        if (mounted) {
           _scrollController.jumpTo(0);
           _autoScroll();
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const lines = [
      "My darling ❤️", "My baby 🥹", "My love 💗", "My everything ✨", "My favourite person 🫶🏻",
      "My safe place 🤍", "My happy place 🌸", "My comfort person 🫂", "My home 🏡❤️",
      "My forever person ♾️", "My sunshine ☀️", "My happiness 💕", "My peace 🕊️",
      "My best friend 🫶🏻", "My biggest smile 😊", "My favourite notification 📱💗",
      "My late-night person 🌙", "My partner in everything 👫", "My biggest supporter 🤍",
      "My constant 🫂", "My precious one 💎", "My sweetest blessing ✨",
      "My reason to smile 🌷", "My favourite human 🥰", "My one and only ❤️",
      "My heart's favourite 🫀", "My dream come true ✨", "My forever and always ♾️",
      "My person, always 🫶🏻", "My whole heart ❤️", "My little world 🌎💗",
      "My favourite love story 📖", "My forever home 🏡", "My everything and more 🥹❤️",
      "Just you. Always you. ❤️"
    ];
    
    return _buildPageLayout(
      onNext: widget.onNext, onPrev: widget.onPrev,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Transform.rotate(
            angle: 0.02,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: elegantWhite,
                border: Border.all(color: elegantGold.withOpacity(0.5), width: 1),
                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 8))],
              ),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
                child: Image.asset('assets/photos/priynk.jpeg', width: 200, height: 200, fit: BoxFit.cover, errorBuilder: (c,e,s) => Container(width: 200, height: 200, color: Colors.grey)),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Expanded(
            child: Container(
              width: 340,
              margin: const EdgeInsets.only(bottom: 100),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: elegantWhite,
                border: Border.all(color: elegantGold.withOpacity(0.5), width: 1),
                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 8))],
              ),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: lines.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      lines[index],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(fontSize: 22, color: elegantRed),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 5. REASONS WHY I LOVE YOU
// ==========================================
class ReasonsPage extends StatefulWidget {
  final VoidCallback onNext, onPrev;
  const ReasonsPage({super.key, required this.onNext, required this.onPrev});

  @override
  State<ReasonsPage> createState() => _ReasonsPageState();
}

class _ReasonsPageState extends State<ReasonsPage> with TickerProviderStateMixin {
  late AnimationController _typewriterController;
  late Animation<int> _typewriterAnimation;
  final String _headingText = "My favorite person ❤️";
  bool _isPlaying = true;

  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _typewriterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _typewriterAnimation = IntTween(begin: 0, end: _headingText.length).animate(
      CurvedAnimation(parent: _typewriterController, curve: Curves.easeIn),
    );
    
    _typewriterController.forward();

    _videoController = VideoPlayerController.asset('assets/videos/us_video.mp4')
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.play();
      });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _videoController.play();
      } else {
        _videoController.pause();
      }
    });
  }

  String _formatDuration(Duration d) {
    String minutes = (d.inMinutes).toString().padLeft(2, '0');
    String seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "\$minutes:\$seconds";
  }

  @override
  void dispose() {
    _typewriterController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPageLayout(
      onNext: widget.onNext, onPrev: widget.onPrev,
      child: Center(
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: elegantBlue,
            border: Border.all(color: elegantGold.withOpacity(0.5), width: 1),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 8))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Video Player
              Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  border: Border.all(color: elegantGold.withOpacity(0.3), width: 1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 5))],
                  color: Colors.black,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _videoController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        )
                      : const Center(child: CircularProgressIndicator(color: elegantRed)),
                ),
              ),
              const SizedBox(height: 25),
              
              // Song Title (Typewriter)
              AnimatedBuilder(
                animation: _typewriterAnimation,
                builder: (context, child) {
                  return Text(
                    _headingText.substring(0, _typewriterAnimation.value),
                    style: GoogleFonts.playfairDisplay(fontSize: 32, color: elegantGold, letterSpacing: 1.5),
                    textAlign: TextAlign.center,
                  );
                }
              ),
              const SizedBox(height: 25),
              
              // Video Scrubber
              ValueListenableBuilder(
                valueListenable: _videoController,
                builder: (context, VideoPlayerValue value, child) {
                  final position = value.position;
                  final duration = value.duration;
                  return Column(
                    children: [
                      VideoProgressIndicator(
                        _videoController,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          playedColor: elegantRed,
                          backgroundColor: Colors.black54,
                          bufferedColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("10:10", style: TextStyle(color: elegantWhite, fontWeight: FontWeight.bold)),
                          Text("20:25", style: TextStyle(color: elegantWhite, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  );
                }
              ),
              const SizedBox(height: 20),
              
              // Playback Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.skip_previous_rounded, color: elegantWhite, size: 45),
                  GestureDetector(
                    onTap: _togglePlayPause,
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: elegantRed, boxShadow: [BoxShadow(color: Colors.black, offset: Offset(2,2))]),
                      padding: const EdgeInsets.all(12),
                      child: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: elegantWhite, size: 50),
                    ),
                  ),
                  const Icon(Icons.skip_next_rounded, color: elegantWhite, size: 45),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 6. FINAL WORDS PAGE
// ==========================================
class FinalWordsPage extends StatelessWidget {
  final VoidCallback onPrev;
  const FinalWordsPage({super.key, required this.onPrev});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: -0.05,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: elegantWhite,
                border: Border.all(color: elegantGold.withOpacity(0.5), width: 1),
                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 8))],
              ),
              child: Column(
                children: [
                  Text(
                    "I always love you forever and ever\n\nJust be my side\n\nAlways love you so much Girish ❤️🕸️😘",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(fontSize: 28, color: Colors.black, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),
          GestureDetector(
            onTap: onPrev,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: elegantRed,
                border: Border.all(color: elegantGold.withOpacity(0.3), width: 1),
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 10, offset: Offset(0, 5))],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.arrow_back, color: elegantWhite),
                  const SizedBox(width: 10),
                  Text("Go Back", style: GoogleFonts.playfairDisplay(fontSize: 24, color: elegantWhite, letterSpacing: 1)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// ==========================================
// HELPERS
// ==========================================
Widget _buildPageLayout({required VoidCallback onNext, required VoidCallback onPrev, required Widget child}) {
  return Stack(
    children: [
      child,
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: const Icon(Icons.arrow_back_ios, color: elegantWhite, size: 30), onPressed: onPrev),
              IconButton(icon: const Icon(Icons.arrow_forward_ios, color: elegantWhite, size: 30), onPressed: onNext),
            ],
          ),
        ),
      ),
    ],
  );
}

// Spider Web Background
class SpiderWebBackground extends StatelessWidget {
  const SpiderWebBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: WebPainter());
  }
}

class WebPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.02)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 12; i++) {
      final angle = (i * pi) / 6;
      final endPoint = Offset(
        center.dx + cos(angle) * size.height,
        center.dy + sin(angle) * size.height,
      );
      canvas.drawLine(center, endPoint, paint);
    }

    for (int i = 1; i <= 6; i++) {
      final radius = i * 80.0;
      final path = Path();
      for (int j = 0; j <= 12; j++) {
        final angle = (j * pi) / 6;
        final point = Offset(
          center.dx + cos(angle) * radius,
          center.dy + sin(angle) * radius,
        );
        if (j == 0) {
          path.moveTo(point.dx, point.dy);
        } else {
          path.lineTo(point.dx, point.dy);
        }
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Floating Comic Spiders/Dots
class FloatingSpideyGraphics extends StatelessWidget {
  const FloatingSpideyGraphics({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: ComicDotsPainter());
  }
}

class ComicDotsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(123);
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 30; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      
      paint.color = i % 3 == 0 ? elegantRed.withOpacity(0.4) : (i % 3 == 1 ? elegantBlue.withOpacity(0.4) : elegantGold.withOpacity(0.4));
      canvas.drawCircle(Offset(x, y), random.nextDouble() * 4 + 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Clipper for Heart Shape
class HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();
    
    // Smooth, aesthetic heart shape
    path.moveTo(width / 2, height / 4);
    path.cubicTo(width * 5 / 14, 0, 0, height / 5, width / 2, height * 0.85);
    path.cubicTo(width, height / 5, width * 9 / 14, 0, width / 2, height / 4);
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
