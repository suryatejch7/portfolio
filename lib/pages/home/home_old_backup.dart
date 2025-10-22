import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_portfolio/pages/home/components/carousel.dart';
import 'package:web_portfolio/pages/home/components/education_section.dart';
import 'package:web_portfolio/pages/home/components/footer.dart';
import 'package:web_portfolio/pages/home/components/header.dart';
import 'package:web_portfolio/pages/home/components/ios_app_ad.dart';
import 'package:web_portfolio/pages/home/components/portfolio_stats.dart';
import 'package:web_portfolio/pages/home/components/skill_section.dart';
import 'package:web_portfolio/pages/home/components/website_ad.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/globals.dart';
import 'package:web_portfolio/widgets/fade_in_on_scroll.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  // Section keys
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateTitleForOffset();
      _setupNavigation();
    });
  }

  void _setupNavigation() {
    setNavigationCallbacks(
      onHome: () => _scrollToSection(_homeKey),
      onProjects: () => _scrollToSection(_projectsKey),
      onEducation: () => _scrollToSection(_educationKey),
      onSkills: () => _scrollToSection(_skillsKey),
      onHireMe: () {
        // TODO: Open contact form or mailto
      },
    );
  }

  // Scroll to section smoothly
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;

    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return;

    final offset = box.localToGlobal(Offset.zero);
    final scrollPosition = _scrollController.offset + offset.dy - Globals.headerHeight - 20;

    _scrollController.animateTo(
      scrollPosition.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Schedule after frame to read RenderBox safely
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateTitleForOffset());
  }

  double _yFor(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return double.infinity;
    final box = ctx.findRenderObject() as RenderBox?;
    if (box == null || !box.attached) return double.infinity;
    final offset = box.localToGlobal(Offset.zero);
    return offset.dy; // global Y from top of screen
  }

  void _updateTitleForOffset() {
    // Choose based on section middle point (50% visibility)
    final ctx = _projectsKey.currentContext;
    if (ctx == null) return;

    final screenHeight = MediaQuery.of(context).size.height;
    final midScreen = screenHeight / 2;

    final yProjects = _yFor(_projectsKey);
    final yEducation = _yFor(_educationKey);
    final ySkills = _yFor(_skillsKey);

    // Section is active when its top reaches the middle of the screen (50% visible)
    String title;
    if (yProjects.isInfinite || yProjects > midScreen) {
      title = 'HOME';
    } else if (yEducation.isInfinite || yEducation > midScreen) {
      title = 'PROJECTS';
    } else if (ySkills.isInfinite || ySkills > midScreen) {
      title = 'EDUCATION';
    } else {
      title = 'SKILLS';
    }

    if (Globals.currentSectionTitle.value != title) {
      Globals.currentSectionTitle.value = title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scaffoldKey,
      body: ValueListenableBuilder<bool>(
        valueListenable: Globals.menuOpen,
        builder: (context, open, _) {
          final double sidebarWidth = 260.0;
          final Duration duration = const Duration(milliseconds: 350);
          final curve = Curves.easeInOutCubic;

          // 3D perspective and rotation for main content
          const double angle = 0.454; // ~26 degrees (reduced by 10°)
          final Matrix4 transform = Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            // Translate first, then rotate - both animate simultaneously
            ..translate(open ? sidebarWidth : 0.0)
            ..rotateY(open ? angle : 0.0);

          return Stack(
            children: [
              // Sidebar - positioned below header
              AnimatedPositioned(
                duration: duration,
                curve: curve,
                left: open ? 0 : -sidebarWidth,
                top: Globals.headerHeight + 8.0, // Start below header
                bottom: 0,
                width: sidebarWidth,
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 12.0, right: 12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E1A24).withOpacity(0.95),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.white.withOpacity(0.08)),
                  ),
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 20.0),
                    itemBuilder: (BuildContext context, int index) {
                      final item = headerItems[index];
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: item.isButton
                            ? Container(
                                margin: const EdgeInsets.symmetric(vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: kDangerColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    item.onTap();
                                    Globals.menuOpen.value = false;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                                    child: Text(
                                      item.title,
                                      style: GoogleFonts.oswald(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : ListTile(
                                title: Text(
                                  item.title,
                                  style: GoogleFonts.oswald(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                    letterSpacing: 1.1,
                                  ),
                                ),
                                onTap: () {
                                  item.onTap();
                                  Globals.menuOpen.value = false;
                                },
                              ),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(color: Colors.white24),
                    itemCount: headerItems.length,
                  ),
                ),
              ),

              // Main content with transform
              AnimatedContainer(
                duration: duration,
                curve: curve,
                transform: transform,
                transformAlignment: Alignment.centerRight,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (open) Globals.menuOpen.value = false;
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(open ? 20.0 : 0.0),
                    child: Container(
                      color: kBackgroundColor,
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top spacer to account for persistent header overlay
                            SizedBox(height: Globals.headerHeight),
                            // HOME section anchor
                            Container(key: _homeKey, child: const Carousel()),
                            const SizedBox(height: 20.0),
                            // PROJECTS section anchor (first project)
                            Container(
                              key: _projectsKey,
                              child: const FadeInOnScroll(child: IosAppAd()),
                            ),
                            const SizedBox(height: 70.0),
                            const WebsiteAd(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 28.0),
                              child: const FadeInOnScroll(child: PortfolioStats()),
                            ),
                            const SizedBox(height: 50.0),
                            // EDUCATION section anchor
                            Container(
                              key: _educationKey,
                              child: const FadeInOnScroll(child: EducationSection()),
                            ),
                            const SizedBox(height: 50.0),
                            // SKILLS section anchor
                            Container(
                              key: _skillsKey,
                              child: const FadeInOnScroll(child: SkillSection()),
                            ),
                            const SizedBox(height: 50.0),
                            const FadeInOnScroll(child: Footer()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              // Persistent top header overlay (stays visible on scroll and above scrim)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: const Header(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
