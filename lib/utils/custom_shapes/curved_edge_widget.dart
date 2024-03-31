import 'package:flutter/material.dart';

import 'curved_edges.dart';

class CurvedEdgeContainerWidget extends StatelessWidget {
  const CurvedEdgeContainerWidget({
    super.key,
    this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: CustomCurvedEdge(), child: child);
  }
}
