import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';
import 'package:web_portfolio/widgets/fade_in_on_scroll.dart';

class WebsiteAd extends StatelessWidget {
  const WebsiteAd({Key? key}) : super(key: key);

  // We can use same idea as ios_app_ad.dart and swap children order, let's copy code
  @override
  Widget build(BuildContext context) {
    return FadeInOnScroll(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: ScreenHelper(
          desktop: _buildUi(kDesktopMaxWidth),
          tablet: _buildUi(kTabletMaxWidth),
          mobile: _buildUi(getMobileMaxWidth(context)),
        ),
      ),
    );
  }

  Widget _buildFeature(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                description,
                style: const TextStyle(
                  color: kCaptionColor,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUi(double width) {
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isHorizontal = constraints.maxWidth > 720;
          return RepaintBoundary(
            child: Flex(
              direction: isHorizontal ? Axis.horizontal : Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text container
                if (isHorizontal)
                  Flexible(
                    flex: 1,
                    child: _buildTextContent(),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: _buildTextContent(),
                  ),
                if (isHorizontal) const SizedBox(width: 40.0),
                // Image container - fixed size to prevent transform issues
                if (isHorizontal)
                  Flexible(
                    flex: 1,
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 400.0,
                        maxHeight: 500.0,
                      ),
                      child: Image.asset(
                        'assets/web_guess1.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                else
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 300.0,
                      maxHeight: 400.0,
                    ),
                    child: Image.asset(
                      'assets/web_guess1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'WEBSITE',
          style: GoogleFonts.oswald(
            color: kPrimaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 15.0),
        Text(
          'ONLINE AUCTION WEBSITE',
          style: GoogleFonts.oswald(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            height: 1.3,
            fontSize: 35.0,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'A campus-focused online auction platform that enables students to buy and sell items through a secure bidding system. Key features include:',
          style: TextStyle(
            color: kCaptionColor,
            height: 1.5,
            fontSize: 15.0,
          ),
        ),
        const SizedBox(height: 15.0),
        _buildFeature('🎓 Campus-Exclusive', 'Only accessible to verified students within the campus network'),
        const SizedBox(height: 10.0),
        _buildFeature('🔒 Secure Bidding', 'Real-time bidding system with automatic winner selection'),
        const SizedBox(height: 10.0),
        _buildFeature('📍 Location Privacy', 'Bid winner and seller can view each other\'s location only after auction ends'),
        const SizedBox(height: 10.0),
        _buildFeature('⏰ Time-Based Auctions', 'Set a deadline for each listing with automatic closure'),
      ],
    );
  }
}