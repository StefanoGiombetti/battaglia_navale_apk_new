import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// Placeholder per la comunicazione Bluetooth LE
// Implementazione completa richiede configurazione Android/iOS nativa

class BluetoothService {
  static final BluetoothService _instance = BluetoothService._internal();
  
  factory BluetoothService() {
    return _instance;
  }
  
  BluetoothService._internal();

  final _deviceFoundController = StreamController<BluetoothDevice>.broadcast();
  final _connectionStatusController = StreamController<bool>.broadcast();
  final _messageController = StreamController<String>.broadcast();

  Stream<BluetoothDevice> get deviceFound => _deviceFoundController.stream;
  Stream<bool> get connectionStatus => _connectionStatusController.stream;
  Stream<String> get messages => _messageController.stream;

  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  BluetoothAdapterState get adapterState => _adapterState;

  List<BluetoothDevice> connectedDevices = [];
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _writeCharacteristic;

  Future<void> initialize() async {
    try {
      // Inizializza FlutterBluePlus
      FlutterBluePlus.events.adapterStateStream.listen((state) {
        _adapterState = state;
      });

      // Ascolta il flusso di dispositivi scoperti
      FlutterBluePlus.events.onScanResults.listen((results) {
        for (ScanResult result in results) {
          _deviceFoundController.add(result.device);
        }
      });

      // Ascolta connessioni di stato
      FlutterBluePlus.events.onConnectionStateChanged.listen((event) {
        if (event.connectionState == BluetoothConnectionState.disconnected) {
          _connectedDevice = null;
          _connectionStatusController.add(false);
        }
      });
    } catch (e) {
      print('Bluetooth initialization error: $e');
    }
  }

  Future<void> startScanning() async {
    try {
      bool isScanning = FlutterBluePlus.isScanningNow;
      if (isScanning) {
        await FlutterBluePlus.stopScan();
      }
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {
      print('Scan error: $e');
    }
  }

  Future<void> stopScanning() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      print('Stop scan error: $e');
    }
  }

  Future<bool> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect(timeout: const Duration(seconds: 10));
      _connectedDevice = device;
      connectedDevices.add(device);
      _connectionStatusController.add(true);

      // Scopri caratteristiche (placeholder)
      final services = await device.discoverServices();
      for (var service in services) {
        for (var characteristic in service.characteristics) {
          if (characteristic.properties.write) {
            _writeCharacteristic = characteristic;
          }
          if (characteristic.properties.notify) {
            characteristic.onValueReceived.listen((value) {
              String message = String.fromCharCodes(value);
              _messageController.add(message);
            });
            await characteristic.setNotifyValue(true);
          }
        }
      }

      return true;
    } catch (e) {
      print('Connection error: $e');
      return false;
    }
  }

  Future<void> disconnectDevice(BluetoothDevice device) async {
    try {
      await device.disconnect();
      connectedDevices.remove(device);
      if (_connectedDevice == device) {
        _connectedDevice = null;
        _connectionStatusController.add(false);
      }
    } catch (e) {
      print('Disconnect error: $e');
    }
  }

  Future<bool> sendMessage(String message) async {
    try {
      if (_writeCharacteristic == null) {
        print('Write characteristic not found');
        return false;
      }

      List<int> bytes = message.codeUnits;
      await _writeCharacteristic!.write(bytes, withoutResponse: false);
      return true;
    } catch (e) {
      print('Send message error: $e');
      return false;
    }
  }

  void dispose() {
    _deviceFoundController.close();
    _connectionStatusController.close();
    _messageController.close();
  }
}
