import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import './app_drawer.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      if (Platform.isAndroid) {
        WebView.platform = SurfaceAndroidWebView();
      }
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('WebView')),
      drawer: const AppDrawer(),
      body: const SafeArea(
        child: WebView(
          initialUrl: 'https://flutter.dev/',
        ),
      ),
    );
  }
}
