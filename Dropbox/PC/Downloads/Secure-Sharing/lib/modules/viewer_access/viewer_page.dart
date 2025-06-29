import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'share_service.dart';

class ViewerPage extends StatefulWidget {
  final String token;
  const ViewerPage({required this.token, Key? key}) : super(key: key);

  @override
  _ViewerPageState createState() => _ViewerPageState();
}

class _ViewerPageState extends State<ViewerPage> {
  late Future<Map<String, dynamic>> _dataFuture;
  PdfController? _pdfController;

  @override
  void initState() {
    super.initState();
    _dataFuture = ShareService().fetchCertificate(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Certificate Viewer")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final metadata = snapshot.data!['metadata'];
            final fileUrl = snapshot.data!['fileUrl'];

            _pdfController ??= PdfController(
              document: PdfDocument.openAsset(fileUrl),
            );

            return Column(
              children: [
                ListTile(
                  title: Text(metadata['name']),
                  subtitle: Text('Issued by ${metadata['issuer']}'),
                ),
                Expanded(child: PdfView(controller: _pdfController!)),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
