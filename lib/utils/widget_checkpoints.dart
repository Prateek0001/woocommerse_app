import 'package:flutter/material.dart';

class CheckPoints extends StatelessWidget {
  final int checkedTill;
  final List<String>? checkPoints;
  final Color? checkPointFilledColor;
  final double circleDia = 32;

  const CheckPoints({
    super.key,
    this.checkedTill = 1,
    this.checkPoints,
    this.checkPointFilledColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (c, s) {
      final double lineWidth = ((s.maxWidth - (circleDia * (checkPoints?.length ?? 1))) / 
          ((checkPoints?.length ?? 1) - 1));

      return Container(
        height: 100,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: checkPoints?.asMap().entries.map((entry) {
                  int index = entry.key;
                  String point = entry.value;
                  
                  return Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: circleDia,
                          height: circleDia,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index <= checkedTill
                                ? checkPointFilledColor
                                : Colors.grey.withOpacity(0.2),
                            border: Border.all(
                              color: index <= checkedTill
                                  ? checkPointFilledColor ?? Colors.green
                                  : Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            Icons.check,
                            color: index <= checkedTill ? Colors.white : Colors.grey,
                            size: 20,
                          ),
                        ),
                        if (index != (checkPoints?.length ?? 1) - 1)
                          Expanded(
                            child: Container(
                              height: 3,
                              color: index < checkedTill
                                  ? checkPointFilledColor
                                  : Colors.grey.withOpacity(0.2),
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList() ?? [],
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: checkPoints?.map((e) => Expanded(
                  child: Text(
                    e,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontSize: 12,
                    ),
                  ),
                )).toList() ?? [],
              ),
            ),
          ],
        ),
      );
    });
  }
}
