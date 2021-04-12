import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:adobe_xd/page_link.dart';
import 'package:flutter_svg/flutter_svg.dart';

class reading extends StatelessWidget {
  reading({
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
            offset: Offset(65.5, 251.5),
            child: SvgPicture.string(
              _svg_a8mpmi,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(230.0, 738.0),
            child: Text(
              '10:54',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 20,
                color: const Color(0xffa5a5a5),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(1046.0, 738.0),
            child: Text(
              'Now',
              style: TextStyle(
                fontFamily: 'Helvetica Neue',
                fontSize: 20,
                color: const Color(0xffa5a5a5),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Transform.translate(
            offset: Offset(605.0, 32.0),
            child: Text(
              'ECG',
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
            offset: Offset(-66.5, 251.5),
            child: SvgPicture.string(
              _svg_yeym9y,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          Transform.translate(
            offset: Offset(1087.0, 252.0),
            child: Container(
              width: 118.0,
              height: 131.0,
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
          Transform.translate(
            offset: Offset(1114.0, 275.0),
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: 'Helvetica Neue',
                  fontSize: 40,
                  color: const Color(0xfff4f4f4),
                ),
                children: [
                  TextSpan(
                    text: '92\n',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: 'bpm',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
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

const String _svg_a8mpmi =
    '<svg viewBox="65.5 251.5 1149.0 469.0" ><path transform="translate(65.5, 720.5)" d="M 0 0 L 1149 0" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(65.5, 251.5)" d="M 0 0 L 0 469" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_yeym9y =
    '<svg viewBox="-66.5 251.5 1094.0 560.0" ><path transform="translate(1027.5, 251.5)" d="M 0 0 L 0 560" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-1802.0, -1438.0)" d="M 1735.5 1962.733642578125 C 1779.556762695312 1962.07666015625 1776.785278320312 1935.93115234375 1787.156494140625 1947.3095703125 C 1797.527709960938 1958.688110351562 1800.073974609375 1964.823486328125 1804.689208984375 1962.733642578125 C 1809.304443359375 1960.643920898438 1849.41357421875 1767.375732421875 1874.51904296875 1865.346313476562 C 1899.62451171875 1963.31689453125 1887.497802734375 2030.703857421875 1902.055786132812 1985.71240234375 C 1907.96630859375 1967.445922851562 1909.168701171875 1953.7578125 1910.964111328125 1945.084228515625 C 1913.47900390625 1932.93017578125 1917.211547851562 1931.75830078125 1938.575561523438 1943.833618164062 C 1974.5419921875 1964.16259765625 2010.403198242188 1962.733642578125 2010.403198242188 1962.733642578125" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-1526.76, -1438.0)" d="M 1735.5 1962.733642578125 C 1779.556762695312 1962.07666015625 1776.785278320312 1935.93115234375 1787.156494140625 1947.3095703125 C 1797.527709960938 1958.688110351562 1800.073974609375 1964.823486328125 1804.689208984375 1962.733642578125 C 1809.304443359375 1960.643920898438 1849.41357421875 1767.375732421875 1874.51904296875 1865.346313476562 C 1899.62451171875 1963.31689453125 1887.497802734375 2030.703857421875 1902.055786132812 1985.71240234375 C 1907.96630859375 1967.445922851562 1909.168701171875 1953.7578125 1910.964111328125 1945.084228515625 C 1913.47900390625 1932.93017578125 1917.211547851562 1931.75830078125 1938.575561523438 1943.833618164062 C 1974.5419921875 1964.16259765625 2010.403198242188 1962.733642578125 2010.403198242188 1962.733642578125" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-1251.53, -1438.0)" d="M 1735.5 1962.733642578125 C 1779.556762695312 1962.07666015625 1776.785278320312 1935.93115234375 1787.156494140625 1947.3095703125 C 1797.527709960938 1958.688110351562 1800.073974609375 1964.823486328125 1804.689208984375 1962.733642578125 C 1809.304443359375 1960.643920898438 1849.41357421875 1767.375732421875 1874.51904296875 1865.346313476562 C 1899.62451171875 1963.31689453125 1887.497802734375 2030.703857421875 1902.055786132812 1985.71240234375 C 1907.96630859375 1967.445922851562 1909.168701171875 1953.7578125 1910.964111328125 1945.084228515625 C 1913.47900390625 1932.93017578125 1917.211547851562 1931.75830078125 1938.575561523438 1943.833618164062 C 1974.5419921875 1964.16259765625 2010.403198242188 1962.733642578125 2010.403198242188 1962.733642578125" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-983.29, -1438.0)" d="M 1735.5 1962.733642578125 C 1779.556762695312 1962.07666015625 1776.785278320312 1935.93115234375 1787.156494140625 1947.3095703125 C 1797.527709960938 1958.688110351562 1800.073974609375 1964.823486328125 1804.689208984375 1962.733642578125 C 1809.304443359375 1960.643920898438 1849.41357421875 1767.375732421875 1874.51904296875 1865.346313476562 C 1899.62451171875 1963.31689453125 1887.497802734375 2030.703857421875 1902.055786132812 1985.71240234375 C 1907.96630859375 1967.445922851562 1909.168701171875 1953.7578125 1910.964111328125 1945.084228515625 C 1913.47900390625 1932.93017578125 1917.211547851562 1931.75830078125 1938.575561523438 1943.833618164062 C 1974.5419921875 1964.16259765625 2010.403198242188 1962.733642578125 2010.403198242188 1962.733642578125" fill="none" stroke="#707070" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
