import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

class IosAppAd extends StatelessWidget {
  const IosAppAd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth),
        tablet: _buildUi(kTabletMaxWidth),
        mobile: _buildUi(getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(double width) {
    return RepaintBoundary(
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isHorizontal = constraints.maxWidth > 720;
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: width,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Flex(
                  direction: isHorizontal ? Axis.horizontal : Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                            'assets/expense_tracker.png',
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
                          'assets/expense_tracker.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    if (isHorizontal) const SizedBox(width: 40.0),
                    // Text container
                    if (isHorizontal)
                      Flexible(
                        flex: 1,
                        child: _buildTextContent(),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: _buildTextContent(),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
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
          'ANDROID/IOS APP',
          style: GoogleFonts.oswald(
            color: kPrimaryColor,
            fontWeight: FontWeight.w900,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 15.0),
        Text(
          'EXPENSE TRACKER APP',
          style: GoogleFonts.oswald(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            height: 1.3,
            fontSize: 35.0,
          ),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Add Expenses manually or just by sharing PhonePe screenshot where details are extracted and auto-filled with help of OCR and Image processing.',
          style: TextStyle(
            color: kCaptionColor,
            height: 1.5,
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}
