import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_portfolio/models/stat.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';

// Removed stats - replaced with GitHub button

class PortfolioStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth, context),
        tablet: _buildUi(kTabletMaxWidth, context),
        mobile: _buildUi(getMobileMaxWidth(context), context),
      ),
    );
  }

  Widget _buildUi(double width, BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: width,
          minWidth: width,
        ),
        child: Center(
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                // Open GitHub repositories page
                // Note: In a real app, you'd use url_launcher package
                print("Opening GitHub: https://github.com/suryatejch7?tab=repositories");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "VIEW ALL",
                      style: GoogleFonts.oswald(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      "(GitHub)",
                      style: GoogleFonts.oswald(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
