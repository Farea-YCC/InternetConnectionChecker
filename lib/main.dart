import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: InternetConnectionChecker(),
    );
  }
}
class InternetConnectionChecker extends StatefulWidget {
  const InternetConnectionChecker({super.key});

  @override
  State<InternetConnectionChecker> createState() => _InternetConnectionCheckerState();
}

class _InternetConnectionCheckerState extends State<InternetConnectionChecker> {
  late final InternetConnectionCheckerPlus _connectionChecker;
  late Stream<InternetConnectionStatus> _statusStream;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectionChecker = InternetConnectionCheckerPlus();
    _statusStream = _connectionChecker.onStatusChange;
    _listenToConnectionStatus();
  }

  void _listenToConnectionStatus() {
    _statusStream.listen((status) {
      setState(() {
        _isConnected = (status == InternetConnectionStatus.connected);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Internet Connection Checker Plus Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isConnected ? Icons.wifi : Icons.wifi_off,
              size: 80,
              color: _isConnected ? Colors.green : Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              _isConnected
                  ? 'You are connected to the Internet!'
                  : 'No Internet Connection',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
