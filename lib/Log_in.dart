import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './Patents_connected.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Log_in extends StatelessWidget {
  Log_in({
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
            offset: Offset(491.0, 372.0),
            child: SizedBox(
              width: 297.0,
              height: 128.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(2.5, 28.5, 294.0, 1.0),
                    size: Size(296.5, 127.5),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child: SvgPicture.string(
                      _svg_1m31k6,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(2.5, 127.5, 294.0, 1.0),
                    size: Size(296.5, 127.5),
                    pinLeft: true,
                    pinRight: true,
                    pinBottom: true,
                    fixedHeight: true,
                    child: SvgPicture.string(
                      _svg_jl8wd6,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(3.0, 0.0, 119.0, 23.0),
                    size: Size(296.5, 127.5),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 99.0, 89.0, 23.0),
                    size: Size(296.5, 127.5),
                    pinLeft: true,
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
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
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(518.0, 550.0),
            child: SizedBox(
              width: 246.0,
              height: 35.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 246.0, 35.0),
                    size: Size(246.0, 35.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(84.0, 6.0, 77.0, 24.0),
                    size: Size(246.0, 35.0),
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: PageLink(
                      links: [
                        PageLinkInfo(
                          transition: LinkTransition.Fade,
                          ease: Curves.easeOut,
                          duration: 0.3,
                          pageBuilder: () => Patents_connected(),
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
                ],
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

const String _svg_1m31k6 =
    '<svg viewBox="493.5 400.5 294.0 1.0" ><path transform="translate(493.5, 400.5)" d="M 0 0 L 294 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jl8wd6 =
    '<svg viewBox="493.5 499.5 294.0 1.0" ><path transform="translate(493.5, 499.5)" d="M 0 0 L 294 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
