import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CarouselFlowDelegate extends FlowDelegate {
  CarouselFlowDelegate({
    required this.viewportOffset,
    required this.filtersPerScreen,
  }) : super(repaint: viewportOffset);

  final ViewportOffset viewportOffset;
  final int filtersPerScreen;

  @override
  void paintChildren(FlowPaintingContext context) {
    final count = context.childCount;
    // Total lebar area gambar
    final size = context.size.width;
    // Jarak yang ditempuh satu item dari sudut pandang scroll paging.
    // Juga digunakan sebagai ukuran item.
    final itemExtent = size / filtersPerScreen;

    // Posisi scroll saat ini sebagai pecahan item, mis. 0.0, 1.0, atau 1.3.
    // Nilai 1.3 menunjukkan item pada indeks 1 aktif, dan pengguna telah
    // menggeser 30% menuju item pada indeks 2.
    final active = viewportOffset.pixels / itemExtent;

    // Indeks item pertama yang perlu di-render saat ini.
    final min = math.max(0, active.floor() - 3);
    // Indeks item terakhir yang perlu di-render saat ini.
    final max = math.min(count - 1, active.ceil() + 3);

    // Loop melalui item yang terlihat, menghasilkan transformasi dan opacity
    for (var index = min; index <= max; index++) {
      final itemXFromCenter = itemExtent * index - viewportOffset.pixels;
      final percentFromCenter = 1.0 - (itemXFromCenter / (size / 2)).abs();

      final itemScale = 0.5 + (percentFromCenter * 0.5);
      final opacity = 0.25 + (percentFromCenter * 0.75);

      // Matriks transformasi untuk item carousel
      final itemTransform = Matrix4.identity()
        ..translate((size - itemExtent) / 2)
        ..translate(itemXFromCenter)
        ..translate(itemExtent / 2, itemExtent / 2)
        ..multiply(Matrix4.diagonal3Values(itemScale, itemScale, 1.0))
        ..translate(-itemExtent / 2, -itemExtent / 2);

      // Paint child dengan transformasi dan opacity yang dihitung
      context.paintChild(
        index,
        transform: itemTransform,
        opacity: opacity,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CarouselFlowDelegate oldDelegate) {
    return oldDelegate.viewportOffset != viewportOffset;
  }
}
