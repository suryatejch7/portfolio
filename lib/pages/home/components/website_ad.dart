import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

class WebsiteAd extends StatelessWidget {
  // We can use same idea as ios_app_ad.dart and swap children order, let's copy code
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
    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            child: Flex(
              direction: constraints.maxWidth > 720
                  ? Axis.horizontal
                  : Axis.vertical,
              children: [
                // Disable expanded on smaller screen to avoid Render errors by setting flex to 0
                Expanded(
                  flex: constraints.maxWidth > 720.0 ? 1 : 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WEBSITE",
                        style: GoogleFonts.oswald(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "ONLINE AUCTION WEBSITE",
                        style: GoogleFonts.oswald(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          height: 1.3,
                          fontSize: 35.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "This is a random text about the project, I should have used the regular lorem ipsum text, but I am too lazy to search for that. This should be long enough",
                        style: TextStyle(
                          color: kCaptionColor,
                          height: 1.5,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 25.0,
                ),
                Expanded(
                  flex: constraints.maxWidth > 720.0 ? 1 : 0,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth > 720.0 ? 400.0 : 300.0,
                      maxHeight: constraints.maxWidth > 720.0 ? 500.0 : 400.0,
                    ),
                    child: Image.asset(
                      "assets/web_guess1.png",
                      fit: BoxFit.contain,
                      width: constraints.maxWidth > 720.0 ? 400.0 : 300.0,
                      height: constraints.maxWidth > 720.0 ? 500.0 : 400.0,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}