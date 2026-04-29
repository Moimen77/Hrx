import 'package:flutter/material.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class PdfViewerScreen extends StatelessWidget {
  final String url;

  const PdfViewerScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'عرض المستند'),
      body: PdfPreview(
        build: (format) async {
          final response = await http.get(Uri.parse(url));
          return response.bodyBytes;
        },
      ),
    );
  }
}
