import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_portfolio/models/footer_item.dart';
import 'package:web_portfolio/utils/constants.dart';
import 'package:web_portfolio/utils/screen_helper.dart';
import 'package:url_launcher/url_launcher.dart';

final List<FooterItem> footerItems = [
  FooterItem(
    iconPath: "assets/mappin.png",
    title: "ADDRESS",
    text1: "Mahindra University,",
    text2: "Hyderabad",
  ),
  FooterItem(
    iconPath: "assets/phone.png",
    title: "PHONE",
    text1: "+91 7702282663",
    text2: "",
  ),
  FooterItem(
    iconPath: "assets/email.png",
    title: "EMAIL",
    text1: "suryatejch7@gmail.com",
    text2: "",
  ),
  FooterItem(
    iconPath: "assets/whatsapp.png",
    title: "WHATSAPP",
    text1: "+91 7702282663",
    text2: "",
  )
];

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth, context),
        tablet: _buildUi(kTabletMaxWidth, context),
        mobile: _buildUi(getMobileMaxWidth(context), context),
      ),
    );
  }
}

Widget _buildUi(double width, BuildContext context) {
  return Center(
    child: Container(
      constraints: BoxConstraints(
        maxWidth: width,
        minWidth: width,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: footerItems
                      .map(
                        (footerItem) => GestureDetector(
                          onTap: () => _handleContactTap(footerItem, context),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              height: 120.0,
                              width: ScreenHelper.isMobile(context)
                                  ? constraints.maxWidth / 2.0 - 20.0
                                  : constraints.maxWidth / 4.0 - 20.0,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          footerItem.iconPath,
                                          width: 25.0,
                                        ),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text(
                                          footerItem.title,
                                          style: GoogleFonts.oswald(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "${footerItem.text1}\n",
                                            style: TextStyle(
                                              color: kCaptionColor,
                                              height: 1.8,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "${footerItem.text2}\n",
                                            style: TextStyle(
                                              color: kCaptionColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

// Function to handle contact taps
void _handleContactTap(FooterItem footerItem, BuildContext context) async {
  String? url;
  
  switch (footerItem.title) {
    case "ADDRESS":
      // Open Google Maps with the address
      url = "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent("Mahindra University, Hyderabad")}";
      break;
    case "PHONE":
      // Open phone dialer
      url = "tel:+917702282663";
      break;
    case "EMAIL":
      // Open email client
      url = "mailto:suryatejch7@gmail.com";
      break;
    case "WHATSAPP":
      // Open WhatsApp
      url = "https://wa.me/917702282663";
      break;
  }
  
  if (url != null) {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        // Fallback: show a snackbar with the contact info
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open ${footerItem.title.toLowerCase()}. Contact: ${footerItem.text1}'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error opening ${footerItem.title.toLowerCase()}: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
