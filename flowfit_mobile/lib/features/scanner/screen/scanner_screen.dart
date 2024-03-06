import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MobileScannerScreen extends StatefulWidget {
  const MobileScannerScreen({Key? key}) : super(key: key);

  @override
  _MobileScannerScreenState createState() => _MobileScannerScreenState();
}

class _MobileScannerScreenState extends State<MobileScannerScreen> {
  late MobileScannerController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Registrar entrada'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        ),
        onDetect: (capture) async {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            debugPrint('Barcode found! ${barcode.rawValue}');
            final endpoint = barcode.rawValue;
            if (endpoint != null) {
              final success = await sendDataToAPI(endpoint);
              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: const Text('Datos enviados correctamente'),
                      duration: Duration(milliseconds: 2000)),
                );
                Navigator.pop(context);
              }
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => cameraController.toggleTorch(),
        child: ValueListenableBuilder(
          valueListenable: cameraController.torchState,
          builder: (context, state, child) {
            switch (state as TorchState) {
              case TorchState.off:
                return const Icon(Icons.flash_off, color: Colors.grey);
              case TorchState.on:
                return const Icon(Icons.flash_on, color: Colors.blue);
            }
          },
        ),
      ),
    );
  }

  Future<bool> sendDataToAPI(String endpoint) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final accessToken = prefs.getString('accessToken');

      if (accessToken != null) {
        debugPrint('Endpoint: $endpoint');
        debugPrint('AccessToken: $accessToken');

        final uri = Uri.parse(endpoint);
        final response = await http.post(
          uri,
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 201) {
          print(response.body);
          return true;
        } else {
          debugPrint('Error en la solicitud: ${response.statusCode}');
          return false;
        }
      } else {
        debugPrint('AccessToken o Id no encontrados en SharedPreferences');
        return false;
      }
    } catch (e) {
      debugPrint('Error al enviar los datos: $e');
      return false;
    }
  }
}
