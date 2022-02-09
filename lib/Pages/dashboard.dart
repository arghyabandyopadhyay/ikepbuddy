import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikepbuddy/Pages/patients.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        drawer: Drawer(
          child: Container(
            child: const Text('This is a drawer'),
          ),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          padding:
              const EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xffcfdbfb),
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0f000000),
                          blurRadius: 16,
                          offset: Offset(3, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 40, horizontal: 4),
                    child: const SizedBox(
                      child: Text(
                        "Exchanges",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xffcfdbfb),
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0f000000),
                          blurRadius: 16,
                          offset: Offset(3, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 40, horizontal: 4),
                    child: const SizedBox(
                      child: Text(
                        "Approvals",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: const Color(0xffcfdbfb),
                        width: 2,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0f000000),
                          blurRadius: 16,
                          offset: Offset(3, 3),
                        ),
                      ],
                      color: Colors.white,
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 40, horizontal: 4),
                    child: const SizedBox(
                      child: Text(
                        "Updates",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Container(
                      width: screenWidth * 0.3,
                      height: 57,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0c000000),
                            blurRadius: 15,
                            offset: Offset(3, 3),
                          ),
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white,
                            Color(0xffd8e6ff),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "   450",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.local_hospital,
                                color: Color(0xff185adb),
                                size: 15,
                              ),
                              Text(
                                "Patients",
                                style: TextStyle(
                                  color: Color(0xff4a4a4a),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    onTap: () => Navigator.push(context,
                        CupertinoPageRoute(builder: (_) => const Patients())),
                  ),
                  Container(
                      width: screenWidth * 0.3,
                      height: 57,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0c000000),
                              blurRadius: 15,
                              offset: Offset(3, 3),
                            ),
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.white, Color(0xffcdffdd)],
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "   125",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.repeat,
                                color: Color(0xff36cd84),
                                size: 15,
                              ),
                              Text(
                                "Exchanges",
                                style: TextStyle(
                                  color: Color(0xff4a4a4a),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  Container(
                      width: screenWidth * 0.3,
                      height: 57,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0c000000),
                            blurRadius: 15,
                            offset: Offset(3, 3),
                          ),
                        ],
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white,
                            Color(0xffffdede),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "   12/02/22",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: const [
                              Icon(
                                Icons.date_range,
                                color: Color(0xffdb1818),
                                size: 15,
                              ),
                              Text(
                                "Next Run",
                                style: TextStyle(
                                  color: Color(0xff4a4a4a),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        ],
                      ))
                ],
              ),
              const SizedBox(height: 56),
              Expanded(child: Container()),
              // const SizedBox(
              //   width: 138,
              //   height: 27,
              //   child: Text(
              //     "Tasks",
              //     style: TextStyle(
              //       color: Color(0xff26304c),
              //       fontSize: 24,
              //       fontFamily: "Roboto",
              //       fontWeight: FontWeight.w700,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 30),
              // Container(
              //   width: 367,
              //   height: 184,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     border: Border.all(
              //       color: Color(0xffcfdbfb),
              //       width: 2,
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Color(0x0f000000),
              //         blurRadius: 16,
              //         offset: Offset(3, 3),
              //       ),
              //     ],
              //     color: Colors.white,
              //   ),
              //   child: Stack(
              //     children: [
              //       Positioned(
              //         left: 53,
              //         top: 45,
              //         child: Container(
              //           width: 128,
              //           height: 16,
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Container(
              //                 width: 16,
              //                 height: 16,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(27),
              //                   color: Color(0xffffc6c6),
              //                 ),
              //                 padding: const EdgeInsets.symmetric(
              //                   horizontal: 5,
              //                   vertical: 3,
              //                 ),
              //                 child: Row(
              //                   mainAxisSize: MainAxisSize.min,
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     SizedBox(
              //                       width: 6,
              //                       height: 10,
              //                       child: Text(
              //                         "5",
              //                         style: TextStyle(
              //                           color: Color(0xffff6f6f),
              //                           fontSize: 10,
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 8),
              //               SizedBox(
              //                 width: 104,
              //                 height: 12,
              //                 child: Text(
              //                   "Approval Pending",
              //                   style: TextStyle(
              //                     color: Color(0xff26304c),
              //                     fontSize: 11,
              //                     fontFamily: "Roboto",
              //                     fontWeight: FontWeight.w700,
              //                     letterSpacing: 0.67,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         left: 53,
              //         top: 70,
              //         child: Container(
              //           width: 98,
              //           height: 16,
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Container(
              //                 width: 16,
              //                 height: 16,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(27),
              //                   color: Color(0xfffff3d5),
              //                 ),
              //                 padding: const EdgeInsets.symmetric(
              //                   horizontal: 5,
              //                   vertical: 3,
              //                 ),
              //                 child: Row(
              //                   mainAxisSize: MainAxisSize.min,
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     SizedBox(
              //                       width: 6,
              //                       height: 10,
              //                       child: Text(
              //                         "5",
              //                         style: TextStyle(
              //                           color: Color(0xffde9e00),
              //                           fontSize: 10,
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 8),
              //               SizedBox(
              //                 width: 74,
              //                 height: 11,
              //                 child: Text(
              //                   "Dispatch Order",
              //                   style: TextStyle(
              //                     color: Color(0xff26304c),
              //                     fontSize: 11,
              //                     fontFamily: "Roboto",
              //                     fontWeight: FontWeight.w700,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         left: 53,
              //         top: 95,
              //         child: Container(
              //           width: 98,
              //           height: 16,
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Container(
              //                 width: 16,
              //                 height: 16,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(27),
              //                   color: Color(0xffcff7dd),
              //                 ),
              //                 padding: const EdgeInsets.symmetric(
              //                   horizontal: 5,
              //                   vertical: 3,
              //                 ),
              //                 child: Row(
              //                   mainAxisSize: MainAxisSize.min,
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     SizedBox(
              //                       width: 6,
              //                       height: 10,
              //                       child: Text(
              //                         "2",
              //                         style: TextStyle(
              //                           color: Color(0xff00e751),
              //                           fontSize: 10,
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 8),
              //               SizedBox(
              //                 width: 74,
              //                 height: 11,
              //                 child: Text(
              //                   "Freight Booking",
              //                   style: TextStyle(
              //                     color: Color(0xff26304c),
              //                     fontSize: 11,
              //                     fontFamily: "Roboto",
              //                     fontWeight: FontWeight.w700,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         left: 53,
              //         top: 120,
              //         child: Container(
              //           width: 125,
              //           height: 16,
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               Container(
              //                 width: 16,
              //                 height: 16,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(27),
              //                   color: Color(0xffd5e3fd),
              //                 ),
              //                 padding: const EdgeInsets.symmetric(
              //                   horizontal: 5,
              //                   vertical: 3,
              //                 ),
              //                 child: Row(
              //                   mainAxisSize: MainAxisSize.min,
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   crossAxisAlignment: CrossAxisAlignment.center,
              //                   children: [
              //                     SizedBox(
              //                       width: 6,
              //                       height: 10,
              //                       child: Text(
              //                         "3",
              //                         style: TextStyle(
              //                           color: Color(0xff5691ff),
              //                           fontSize: 10,
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 8),
              //               SizedBox(
              //                 width: 101,
              //                 height: 13,
              //                 child: Text(
              //                   "Material Requisition",
              //                   style: TextStyle(
              //                     color: Color(0xff26304c),
              //                     fontSize: 11,
              //                     fontFamily: "Roboto",
              //                     fontWeight: FontWeight.w700,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       Positioned.fill(
              //         child: Align(
              //           alignment: Alignment.centerRight,
              //           child: Container(
              //             width: 143.09,
              //             height: 143.09,
              //             child: Stack(
              //               children: [
              //                 Positioned.fill(
              //                   child: Align(
              //                     alignment: Alignment.bottomLeft,
              //                     child: Container(
              //                       width: 108.81,
              //                       height: 108.81,
              //                       decoration: BoxDecoration(
              //                         shape: BoxShape.circle,
              //                         border: Border.all(
              //                           color: Color(0xff9eeab9),
              //                           width: 7,
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned.fill(
              //                   child: Align(
              //                     alignment: Alignment.bottomLeft,
              //                     child: Container(
              //                       width: 108.81,
              //                       height: 108.81,
              //                       decoration: BoxDecoration(
              //                         shape: BoxShape.circle,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned.fill(
              //                   child: Align(
              //                     alignment: Alignment.bottomLeft,
              //                     child: Transform.rotate(
              //                       angle: -1.16,
              //                       child: Container(
              //                         width: 108.81,
              //                         height: 108.81,
              //                         decoration: BoxDecoration(
              //                           shape: BoxShape.circle,
              //                           border: Border.all(
              //                             color: Color(0xffffb5b5),
              //                             width: 7,
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Positioned.fill(
              //                   child: Align(
              //                     alignment: Alignment.bottomLeft,
              //                     child: Transform.rotate(
              //                       angle: 2.98,
              //                       child: Container(
              //                         width: 108.81,
              //                         height: 108.81,
              //                         decoration: BoxDecoration(
              //                           shape: BoxShape.circle,
              //                           border: Border.all(
              //                             color: Color(0xffffe7ab),
              //                             width: 7,
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         left: 275,
              //         top: 78,
              //         child: SizedBox(
              //           width: 29,
              //           height: 25,
              //           child: Text(
              //             "15",
              //             style: TextStyle(
              //               color: Color(0xff6c84c5),
              //               fontSize: 24,
              //               fontFamily: "Roboto",
              //               fontWeight: FontWeight.w700,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ));
  }
}
