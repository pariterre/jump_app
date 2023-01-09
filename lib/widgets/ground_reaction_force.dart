import 'package:flutter/material.dart';

import '../providers/biomechanics.dart';
import 'arrow.dart';
import 'text_with_index.dart';
import 'value_picker.dart';

class GroundReactionForce extends StatelessWidget {
  const GroundReactionForce({
    super.key,
    required this.arrowHead,
    required this.arrowHeadSize,
    required this.sliderPosition,
    required this.sliderHeight,
    this.floor = 0,
  });

  final Offset arrowHead;
  final double arrowHeadSize;
  final Offset sliderPosition;
  final double sliderHeight;
  final double floor;

  void _updateGrf(BuildContext context, double value) {
    final biomechanics = Biomechanics.of(context);
    biomechanics.groundReactionForce = value;
  }

  @override
  Widget build(BuildContext context) {
    final biomechanics = Biomechanics.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Arrows(
            start: Offset(arrowHead.dx, -floor),
            end: arrowHead,
            headSize: arrowHeadSize,
            color: Colors.red,
          ),
          Positioned(
            left: arrowHead.dx + arrowHeadSize / 2,
            bottom: -arrowHead.dy - 2 * arrowHeadSize,
            child: TextWithIndex(
              'F',
              'max',
              textStyle: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: arrowHeadSize,
              ),
            ),
          ),
          ValuePicker.vertical(
            min: 1000,
            max: 5000,
            initial: biomechanics.groundReactionForce,
            position: sliderPosition,
            height: sliderHeight,
            color: Colors.red,
            textSize: arrowHeadSize,
            unit: 'N',
            precision: 0,
            onValueChanged: (value) => _updateGrf(context, value),
          ),
        ],
      ),
    );
  }
}