import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlScreen extends StatefulWidget {
  const UrlScreen({Key? key}) : super(key: key);

  @override
  State<UrlScreen> createState() => _UrlScreenState();
}

class _UrlScreenState extends State<UrlScreen> {
  final Uri _url = Uri.parse('https://flutter.dev');
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              onPressed: _launchUrl,
              child: Text('open url'),
            ),
            MaterialButton(
              onPressed: _launchUrl,
              child: Text('open url'),
            ),
          ],
        ),
      ),
    );
  }
}
