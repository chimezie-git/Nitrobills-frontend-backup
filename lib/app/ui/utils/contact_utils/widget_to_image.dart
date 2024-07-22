import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:screenshot/screenshot.dart';

class WidgetToImage {
  // Future<Uint8List?> captureWidgetAsImage(Widget widget) async {
  //   // Create a RenderRepaintBoundary
  //   final RenderRepaintBoundary boundary = RenderRepaintBoundary();
  //   // Create a Size object for the off-screen rendering
  //   final Size size = Size(300, 200); // Set the desired size of the widget
  //   // Create a PipelineOwner for the render object
  //   final PipelineOwner pipelineOwner = PipelineOwner();
  //   // Create a BuildOwner for the render object
  //   final BuildOwner buildOwner = BuildOwner();
  //   // Create a RenderView for the render object
  //   RenderView
  //   final RenderView renderView = RenderView(
  //     child: RenderPositionedBox(
  //       alignment: Alignment.center,
  //       child: boundary,
  //     ),
  //     configuration: ViewConfiguration(
  //       size: size,
  //       devicePixelRatio: ui.window.devicePixelRatio,
  //     ),
  //     window: ui.window,
  //   );
  //   // Set the pipelineOwner for the renderView
  //   renderView.attach(pipelineOwner);
  //   // Create an Element for the widget
  //   final RenderObjectToWidgetElement<RenderBox> rootElement =
  //       RenderObjectToWidgetAdapter<RenderBox>(
  //     container: boundary,
  //     child: MediaQuery(
  //       data: MediaQueryData(size: size),
  //       child: Directionality(
  //         textDirection: TextDirection.ltr,
  //         child: widget,
  //       ),
  //     ),
  //   ).attachToRenderTree(buildOwner);
  //   // Perform the layout and paint
  //   buildOwner.buildScope(rootElement);
  //   pipelineOwner.flushLayout();
  //   pipelineOwner.flushCompositingBits();
  //   pipelineOwner.flushPaint();
  //   // Convert the boundary to an image
  //   final ui.Image image =
  //       await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
  //   final ByteData? byteData =
  //       await image.toByteData(format: ui.ImageByteFormat.png);
  //   final Uint8List pngBytes = byteData!.buffer.asUint8List();
  //   return pngBytes;
  // }

  static Future<Uint8List> _captureWidgetAsImage(Widget widget) async {
    ScreenshotController screenshotController =
        ScreenshotController(); //Capture!!
    return await screenshotController.captureFromWidget(widget);
  }

  static Widget _codeToImg(String text1, String code, String text2) {
    return Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: NbColors.white,
      child: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(text: text1),
              TextSpan(
                text: code,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(text: text2),
            ],
            style: const TextStyle(
              color: NbColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'Satoshi',
            ),
          ),
        ),
        // child: Text(
        //   text,
        //   style:
        // ),
      ),
    );
  }

  static Future<Uint8List> getShareableImage(
      String text1, String code, String text2) async {
    Widget widget = _codeToImg(text1, code, text2);
    Uint8List bytes = await _captureWidgetAsImage(widget);
    return bytes;
  }
}
