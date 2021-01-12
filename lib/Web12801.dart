import 'package:flutter/material.dart';
//import './Web12802.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Web12801 extends StatelessWidget {
  Web12801({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Container(
            width: 1280.0,
            height: 102.0,
            decoration: BoxDecoration(
              color: const Color(0xff4aabff),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x29000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(411.0, 250.0),
            child: Container(
              width: 459.0,
              height: 387.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(411.0, 250.0),
            child: Container(
              width: 459.0,
              height: 79.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xff4aabff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(506.0, 278.0),
            child: Text(
              'Enter your log in credentials',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 20,
                color: const Color(0xfff4f4f4),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(518.0, 550.0),
            child: Container(
              width: 246.0,
              height: 35.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xff4aabff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(493.5, 400.5),
            child: SvgPicture.string(
              _svg_xg7f2p,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(494.0, 372.0),
            child: Text(
              'Access Code',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 20,
                color: const Color(0xffd8d8d8),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(491.0, 471.0),
            child: Text(
              'Password',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 20,
                color: const Color(0xffd8d8d8),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(602.0, 556.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => Web12802(),
                ),
              ],
              child: Text(
                'Confirm',
                style: TextStyle(
                  fontFamily: 'Helvetica Neue',
                  fontSize: 20,
                  color: const Color(0xfff4f4f4),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(548.0, 32.0),
            child: Text(
              'Log in page',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 33,
                color: const Color(0xfff4f4f4),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_xg7f2p =
    '<svg viewBox="493.5 400.5 294.0 99.0" ><path transform="translate(493.5, 400.5)" d="M 0 0 L 294 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(493.5, 499.5)" d="M 0 0 L 294 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
