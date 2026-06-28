import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/cart/data/models/cart_item_model.dart';

class PdfService {
  static Future<File> generateInvoice({
    required String invoiceNumber,
    required List<CartItem> items,
    required double total,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // HEADER
              pw.Text(
                "SCANBILL INVOICE",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 10),

              pw.Text("Invoice No: $invoiceNumber"),
              pw.Text("Date: ${DateTime.now()}"),

              pw.SizedBox(height: 20),

              // TABLE HEADER
              pw.Container(
                padding: const pw.EdgeInsets.all(8),
                color: PdfColors.grey300,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text("Item"),
                    pw.Text("Qty"),
                    pw.Text("Price"),
                    pw.Text("Total"),
                    pw.Text("Total"),
                  ],
                ),
              ),

              // ITEMS
              pw.Column(
                children: items.map((item) {
                  return pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(item.product.name),
                      pw.Text("${item.quantity}"),
                      pw.Text("${item.product.sellingPrice}"),
                      pw.Text("${item.total}"),
                    ],
                  );
                }).toList(),
              ),

              pw.Divider(),

              // TOTAL
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  "TOTAL: ₹$total",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    final output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/$invoiceNumber.pdf");

    await file.writeAsBytes(await pdf.save());

    return file;
  }

  // PRINT / SHARE DIRECTLY
  static Future<void> printInvoice(File file) async {
    await Printing.sharePdf(
      bytes: await file.readAsBytes(),
      filename: "invoice.pdf",
    );
  }
}