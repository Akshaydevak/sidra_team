
import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String assetName;

  const ImagePreview({required this.assetName, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _ImagePreviewDialog.showPreviewDialog(context, assetName),
      child: Image.network(assetName),
    );
  }
}

class _ImagePreviewDialog extends StatelessWidget {
  final String assetName;
  const _ImagePreviewDialog(this.assetName);

  static void showPreviewDialog(BuildContext context, String assetName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _ImagePreviewDialog(assetName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: InteractiveViewer(
          clipBehavior: Clip.none,
          maxScale: 5.0,
          child: Image.network(assetName),
        ),
      ),
    );
  }
}
