import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import './Patents_monitor.dart';
import 'package:adobe_xd/page_link.dart';
import './Patents_history.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Patents_A1 extends StatelessWidget {
  Patents_A1({
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
          Transform.translate(
            offset: Offset(575.0, 29.0),
            child: Text(
              'Ward A1',
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
            offset: Offset(37.0, 132.0),
            child: SizedBox(
              width: 1173.0,
              height: 128.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 1173.0, 128.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(26.0, 13.0, 262.0, 50.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    pinTop: true,
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
                    bounds: Rect.fromLTWH(26.0, 70.0, 203.0, 34.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
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
                    bounds: Rect.fromLTWH(357.0, 70.0, 17.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(511.0, 70.0, 151.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(1009.0, 23.0, 139.0, 82.0),
                    size: Size(1173.0, 128.0),
                    pinRight: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: PageLink(
                      links: [
                        PageLinkInfo(
                          transition: LinkTransition.Fade,
                          ease: Curves.easeOut,
                          duration: 0.3,
                          pageBuilder: () => Patents_monitor(),
                        ),
                      ],
                      child: Stack(
                        children: <Widget>[
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(0.0, 0.0, 139.0, 82.0),
                            size: Size(139.0, 82.0),
                            pinLeft: true,
                            pinRight: true,
                            pinTop: true,
                            pinBottom: true,
                            child: SvgPicture.string(
                              _svg_pz6gep,
                              allowDrawingOutsideViewBox: true,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(19.0, 27.0, 101.0, 29.0),
                            size: Size(139.0, 82.0),
                            pinLeft: true,
                            pinRight: true,
                            fixedHeight: true,
                            child: Text(
                              'Connect',
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
                    bounds: Rect.fromLTWH(426.0, 21.0, 95.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(848.0, 23.0, 139.0, 82.0),
                    size: Size(1173.0, 128.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: PageLink(
                      links: [
                        PageLinkInfo(
                          transition: LinkTransition.Fade,
                          ease: Curves.easeOut,
                          duration: 0.3,
                          pageBuilder: () => Patents_history(),
                        ),
                      ],
                      child: Stack(
                        children: <Widget>[
                          Pinned.fromSize(
                            bounds: Rect.fromLTWH(0.0, 0.0, 139.0, 82.0),
                            size: Size(139.0, 82.0),
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
                            bounds: Rect.fromLTWH(27.0, 27.0, 85.0, 29.0),
                            size: Size(139.0, 82.0),
                            fixedWidth: true,
                            fixedHeight: true,
                            child: Text(
                              'History',
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
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 298.0),
            child: SizedBox(
              width: 1173.0,
              height: 128.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 1173.0, 128.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(26.0, 13.0, 262.0, 50.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    pinTop: true,
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
                    bounds: Rect.fromLTWH(26.0, 70.0, 203.0, 34.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
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
                    bounds: Rect.fromLTWH(357.0, 70.0, 17.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(511.0, 70.0, 151.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(1009.0, 23.0, 139.0, 82.0),
                    size: Size(1173.0, 128.0),
                    pinRight: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 139.0, 82.0),
                          size: Size(139.0, 82.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child: SvgPicture.string(
                            _svg_pighin,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(23.0, 27.0, 93.0, 29.0),
                          size: Size(139.0, 82.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Text(
                            'Monitor',
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(426.0, 21.0, 95.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(848.0, 23.0, 139.0, 82.0),
                    size: Size(1173.0, 128.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 139.0, 82.0),
                          size: Size(139.0, 82.0),
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
                          bounds: Rect.fromLTWH(27.0, 27.0, 85.0, 29.0),
                          size: Size(139.0, 82.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Text(
                            'History',
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
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 464.0),
            child: SizedBox(
              width: 1173.0,
              height: 128.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 1173.0, 128.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(26.0, 13.0, 262.0, 50.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    pinTop: true,
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
                    bounds: Rect.fromLTWH(26.0, 70.0, 203.0, 34.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
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
                    bounds: Rect.fromLTWH(357.0, 70.0, 17.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(511.0, 70.0, 151.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(426.0, 21.0, 95.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(848.0, 23.0, 139.0, 82.0),
                    size: Size(1173.0, 128.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 139.0, 82.0),
                          size: Size(139.0, 82.0),
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
                          bounds: Rect.fromLTWH(27.0, 27.0, 85.0, 29.0),
                          size: Size(139.0, 82.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Text(
                            'History',
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
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 630.0),
            child: SizedBox(
              width: 1173.0,
              height: 128.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 1173.0, 128.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(26.0, 13.0, 262.0, 50.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    pinTop: true,
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
                    bounds: Rect.fromLTWH(26.0, 70.0, 203.0, 34.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
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
                    bounds: Rect.fromLTWH(357.0, 70.0, 17.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(511.0, 70.0, 151.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(1009.0, 23.0, 139.0, 82.0),
                    size: Size(1173.0, 128.0),
                    pinRight: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 139.0, 82.0),
                          size: Size(139.0, 82.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child: SvgPicture.string(
                            _svg_pighin,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(23.0, 27.0, 93.0, 29.0),
                          size: Size(139.0, 82.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Text(
                            'Monitor',
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(426.0, 21.0, 95.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(848.0, 23.0, 139.0, 82.0),
                    size: Size(1173.0, 128.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 139.0, 82.0),
                          size: Size(139.0, 82.0),
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
                          bounds: Rect.fromLTWH(27.0, 27.0, 85.0, 29.0),
                          size: Size(139.0, 82.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Text(
                            'History',
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
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 796.0),
            child: SizedBox(
              width: 1173.0,
              height: 128.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 1173.0, 128.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(26.0, 13.0, 262.0, 50.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    pinTop: true,
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
                    bounds: Rect.fromLTWH(26.0, 70.0, 203.0, 34.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
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
                    bounds: Rect.fromLTWH(357.0, 70.0, 17.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(511.0, 70.0, 151.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                    bounds: Rect.fromLTWH(1009.0, 23.0, 139.0, 82.0),
                    size: Size(1173.0, 128.0),
                    pinRight: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 139.0, 82.0),
                          size: Size(139.0, 82.0),
                          pinLeft: true,
                          pinRight: true,
                          pinTop: true,
                          pinBottom: true,
                          child: SvgPicture.string(
                            _svg_pighin,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(23.0, 27.0, 93.0, 29.0),
                          size: Size(139.0, 82.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Text(
                            'Monitor',
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(426.0, 21.0, 95.0, 34.0),
                    size: Size(1173.0, 128.0),
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
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(848.0, 23.0, 139.0, 82.0),
                    size: Size(1173.0, 128.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromSize(
                          bounds: Rect.fromLTWH(0.0, 0.0, 139.0, 82.0),
                          size: Size(139.0, 82.0),
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
                          bounds: Rect.fromLTWH(27.0, 27.0, 85.0, 29.0),
                          size: Size(139.0, 82.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Text(
                            'History',
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
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(1045.0, 487.0),
            child: SizedBox(
              width: 139.0,
              height: 82.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 139.0, 82.0),
                    size: Size(139.0, 82.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: SvgPicture.string(
                      _svg_6lotlx,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(19.0, 27.0, 101.0, 29.0),
                    size: Size(139.0, 82.0),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child: Text(
                      'Connect',
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
        ],
      ),
    );
  }
}

const String _svg_pz6gep =
    '<svg viewBox="928.5 153.0 139.0 82.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(928.45, 153.0)" d="M 20 0 L 119 0 C 130.0457000732422 0 139 8.954304695129395 139 20 L 139 62 C 139 73.04569244384766 130.0457000732422 82 119 82 L 20 82 C 8.954304695129395 82 0 73.04569244384766 0 62 L 0 20 C 0 8.954304695129395 8.954304695129395 0 20 0 Z" fill="#939393" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_pighin =
    '<svg viewBox="928.5 153.0 139.0 82.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(928.45, 153.0)" d="M 20 0 L 119 0 C 130.0457000732422 0 139 8.954304695129395 139 20 L 139 62 C 139 73.04569244384766 130.0457000732422 82 119 82 L 20 82 C 8.954304695129395 82 0 73.04569244384766 0 62 L 0 20 C 0 8.954304695129395 8.954304695129395 0 20 0 Z" fill="#4aabff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_6lotlx =
    '<svg viewBox="923.5 153.0 139.0 82.0" ><defs><filter id="shadow"><feDropShadow dx="0" dy="3" stdDeviation="6"/></filter></defs><path transform="translate(923.45, 153.0)" d="M 20 0 L 119 0 C 130.0457000732422 0 139 8.954304695129395 139 20 L 139 62 C 139 73.04569244384766 130.0457000732422 82 119 82 L 20 82 C 8.954304695129395 82 0 73.04569244384766 0 62 L 0 20 C 0 8.954304695129395 8.954304695129395 0 20 0 Z" fill="#939393" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
