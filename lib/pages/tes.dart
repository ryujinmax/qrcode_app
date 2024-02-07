import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:line_icons/line_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class TesPage extends StatefulWidget {
  const TesPage({Key? key}) : super(key: key);

  @override
  State<TesPage> createState() => _TesPageState();
}

class _TesPageState extends State<TesPage> {
  // ignore: unused_field
  int _selectedIndex = 0;

  // ignore: unused_element
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Scan Qr Code",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 41, 71, 170),
        ),
        body: Container(
          color: const Color.fromARGB(255, 41, 71, 170),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 0.0),
              ),
              const Center(
                child: Text(
                  "Scan the Qr Code to start the process of the application",
                  style: TextStyle(
                      color: Color.fromARGB(255, 148, 167, 230), fontSize: 12),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: MobileScanner(
                      controller: MobileScannerController(
                        detectionSpeed: DetectionSpeed.noDuplicates,
                        returnImage: true,
                      ),
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        final Uint8List? image = capture.image;
                        for (final barcode in barcodes) {
                          print('Barcode Found! ${barcode.rawValue}');
                        }
                        if (image != null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(barcodes.first.rawValue ?? ""),
                                content: Image(
                                  image: MemoryImage(image),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: 0,
          height: 50.0,
          items: const <Widget>[
            Icon(LineIcons.home, size: 30),
            Icon(LineIcons.qrcode, size: 30),
            Icon(LineIcons.user, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 41, 71, 170),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ));
  }
}
