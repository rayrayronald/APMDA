import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/page_link.dart';
import 'Sensor_connect.dart';
import 'reading.dart';

class Patents_monitor extends StatelessWidget {
  Patents_monitor({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            offset: Offset(510.0, 30.0),
            child: Text(
              'Patients Monitor',
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
            offset: Offset(37.0, 244.0),
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
                    bounds: Rect.fromLTWH(26.0, 13.0, 90.0, 50.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'ECG',
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
                    bounds: Rect.fromLTWH(24.0, 72.0, 103.0, 34.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Paused',
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
                          pageBuilder: () => Sensor_connect(),
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
                                color: const Color(0xffe6d023),
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
                            bounds: Rect.fromLTWH(42.0, 27.0, 58.0, 29.0),
                            size: Size(139.0, 82.0),
                            fixedWidth: true,
                            fixedHeight: true,
                            child: Text(
                              'Start',
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
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 410.0),
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
                    bounds: Rect.fromLTWH(26.0, 13.0, 111.0, 50.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'SPO2',
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
                    bounds: Rect.fromLTWH(24.0, 72.0, 398.0, 34.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      '15/01/2021  14:25:51   -   now',
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
                          pageBuilder: () => reading(),
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
                                color: const Color(0xff3fe365),
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
                            bounds: Rect.fromLTWH(42.0, 27.0, 56.0, 29.0),
                            size: Size(139.0, 82.0),
                            fixedWidth: true,
                            fixedHeight: true,
                            child: Text(
                              'View',
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
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 576.0),
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
                    bounds: Rect.fromLTWH(26.0, 13.0, 72.0, 50.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'ICP',
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
                    bounds: Rect.fromLTWH(24.0, 72.0, 398.0, 34.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      '15/01/2021  11:25:94   -   now',
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
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xff3fe365),
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
                          bounds: Rect.fromLTWH(42.0, 27.0, 56.0, 29.0),
                          size: Size(139.0, 82.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Text(
                            'View',
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
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(37.0, 742.0),
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
                    bounds: Rect.fromLTWH(26.0, 13.0, 73.0, 50.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'IOP',
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
                    bounds: Rect.fromLTWH(24.0, 72.0, 619.0, 34.0),
                    size: Size(1173.0, 128.0),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      '15/01/2021  14:25:51   -   15/01/2021  23:15:41',
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
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: const Color(0xff3fe365),
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
                          bounds: Rect.fromLTWH(42.0, 27.0, 56.0, 29.0),
                          size: Size(139.0, 82.0),
                          fixedWidth: true,
                          fixedHeight: true,
                          child: Text(
                            'View',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
