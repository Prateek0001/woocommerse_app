import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  final int lowerLimit;
  final int upperLimit;
  final int stepValue;
  final double iconSize;
  int value;
  final ValueChanged<dynamic> onChanged;

   CustomStepper(
      {super.key,
      required this.lowerLimit,
      required this.upperLimit,
      required this.stepValue,
      required this.iconSize,
      this.value = 0,
      required this.onChanged});

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.white,
              blurRadius: 15,
              spreadRadius: 10
            )

          ]
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () {
            setState(() {
              widget.value = widget.value == widget.lowerLimit ? widget.lowerLimit : widget.value -= widget.stepValue ;
              widget.onChanged(widget.value);
            });
          }, icon: Icon(Icons.remove)),
          Container(
            width: widget.iconSize,
            child: Text(
              '${widget.value}',
              style: TextStyle(fontSize: widget.iconSize * 0.8),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(onPressed: () {
            setState(() {
              widget.value = widget.value == widget.upperLimit ? widget.upperLimit : widget.value += widget.stepValue ;
              widget.onChanged(widget.value);
            });
          }, icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
