import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flexiJobs/core/helpers/view_toolbox.dart';
import 'pdf_cubit.dart'; // Import your cubit

// USAGE EXAMPLE:
/*
ElevatedButton(
  onPressed: () {
    showPDFBottomSheet(
      context,
      'assets/sample.pdf',
      bottomSheetHeight: 0.85,
    );
  },
  child: const Text("Show Local PDF"),
)
*/
void showPDFBottomSheet(BuildContext context, String pdfPath,
    {bool isScrollable = true, double bottomSheetHeight = 300}) {
  ViewsToolbox.showBottomSheet(
      context: context,
      customWidget: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: 600.h,
        child: BlocProvider(
          create: (BuildContext context) => PDFCubit()..loadPDF(pdfPath),
          child: BlocConsumer<PDFCubit, PDFState>(
            listener: (BuildContext context, PDFState state) {
              if (state is PDFLoading) {
                ViewsToolbox.showLoading();
              } else {
                ViewsToolbox.dismissLoading();
              }
            },
            builder: (BuildContext context, PDFState state) {
              if (state is PDFLoading) {
                return const SizedBox.shrink();
              } else if (state is PDFLoaded) {
                return PdfViewer.file(
                  state.filePath,
                  params: PdfViewerParams(
                    enableTextSelection: true,
                    maxScale: 5.0,
                  ),
                );
              } else if (state is PDFError) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              } else {
                return const Center(child: Text('No PDF loaded'));
              }
            },
          ),
        ),
      ));
}
