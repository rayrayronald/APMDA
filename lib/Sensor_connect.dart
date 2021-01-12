import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/page_link.dart';
import './Sensor_callib.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Sensor_connect extends StatelessWidget {
  Sensor_connect({
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
            offset: Offset(482.0, 30.0),
            child: Text(
              'Connect & Calibrate',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 33,
                color: const Color(0xfff4f4f4),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 30.0),
            child: SizedBox(
              width: 52.0,
              height: 43.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 52.0, 7.0),
                    size: Size(52.0, 43.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    fixedHeight: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 36.0, 52.0, 7.0),
                    size: Size(52.0, 43.0),
                    pinLeft: true,
                    pinRight: true,
                    pinBottom: true,
                    fixedHeight: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 18.0, 52.0, 7.0),
                    size: Size(52.0, 43.0),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 130.0),
            child: SizedBox(
              width: 1173.0,
              height: 79.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 1173.0, 79.0),
                    size: Size(1173.0, 79.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color(0xfff8f8f8),
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
                    bounds: Rect.fromLTWH(164.0, 14.0, 262.0, 50.0),
                    size: Size(1173.0, 79.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Mary Holiday',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 42,
                        color: const Color(0xff777777),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(908.0, 22.0, 203.0, 34.0),
                    size: Size(1173.0, 79.0),
                    pinRight: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Patient 104815',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 29,
                        color: const Color(0xff777777),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(838.0, 22.0, 17.0, 34.0),
                    size: Size(1173.0, 79.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'F',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 29,
                        color: const Color(0xff777777),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(653.0, 22.0, 151.0, 34.0),
                    size: Size(1173.0, 79.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      '15/05/1952',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 29,
                        color: const Color(0xff777777),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(8.0, 11.0, 87.0, 58.0),
                    size: Size(1173.0, 79.0),
                    pinLeft: true,
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child: PageLink(
                      links: [
                        PageLinkInfo(),
                      ],
                      child: Stack(
                        children: <Widget>[
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(0.0, 0.0, 87.0, 58.0),
                            size: Size(87.0, 58.0),
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
                            bounds: Rect.fromLTWH(13.0, 15.0, 61.0, 29.0),
                            size: Size(87.0, 58.0),
                            pinLeft: true,
                            pinRight: true,
                            fixedHeight: true,
                            child: Text(
                              'Back',
                              style: TextStyle(
                                fontFamily: 'Helvetica Neue',
                                fontSize: 25,
                                color: const Color(0xfff4f4f4),
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(508.0, 22.0, 95.0, 34.0),
                    size: Size(1173.0, 79.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Bed 24',
                      style: TextStyle(
                        fontFamily: 'Helvetica Neue',
                        fontSize: 29,
                        color: const Color(0xff777777),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
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
            offset: Offset(527.0, 278.0),
            child: Text(
              'Enter ECG sensor serial',
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
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => Sensor_callib(),
                ),
              ],
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
              'Serial',
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
              'PIN',
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
          Transform.translate(
            offset: Offset(1078.0, 39.0),
            child: Text(
              'Dr. Helen Wood',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 25,
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
