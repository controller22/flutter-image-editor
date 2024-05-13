import 'package:flutter/material.dart';

class EmoticonSticker extends StatefulWidget {
  final VoidCallback onTransform;
  final String imgPath;
  final bool isSelected;

  const EmoticonSticker({
      required this.onTransform,
      required this.imgPath,
      required this.isSelected,
      Key? key
  }) : super(key: key);

  @override
  State<EmoticonSticker> createState() => _EmoticonStickerState();
}

class _EmoticonStickerState extends State<EmoticonSticker> {
  double scale = 1;

  double hTransform = 0;

  double vTransform = 0;

  double actualScale = 1;

  @override
  Widget build(BuildContext context) {
    return Transform(
      // child 위젯을 변형할 수 있는 위젯
      transform: Matrix4.identity()
        ..translate(hTransform, vTransform) // 상/하 움직임의 정의
        ..scale(scale, scale), //  확대/축소 정의

      child: Container(
        decoration: widget.isSelected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  color: Colors.blue,
                  width: 1.0,
                ),
              )
            : BoxDecoration(
                border: Border.all(
                  color: Colors.transparent,
                  width: 1.0,
                ),
              ),
        child: GestureDetector(
          onTap: () {
            widget.onTransform();
          },
          onScaleUpdate: (ScaleUpdateDetails details) {
            widget.onTransform();
            setState(() {
              scale = details.scale * actualScale;
              vTransform += details.focalPointDelta.dy;
              hTransform += details.focalPointDelta.dx;
            });
          },
          onScaleEnd: (ScaleEndDetails details) {
            actualScale = scale;
          },
          child: Image.asset(widget.imgPath),
        ),
      ),
    );
  }
}
