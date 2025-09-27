import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TRatingProgressIndicator.dart';

class TOverallRating extends StatelessWidget {
  const TOverallRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: Text('4.8',style: Theme.of(context).textTheme.displayLarge,)),
        Expanded(
          flex: 8,
          child: Column(
            children: [
              TRatingProgressIndicator(value: 0.1,text: "5",),
              TRatingProgressIndicator(value: 0.6,text: "4",),
              TRatingProgressIndicator(value: 0.3,text: "3",),
              TRatingProgressIndicator(value: 0.08,text: "2",),
              TRatingProgressIndicator(value: 0.05,text: "1",),

            ],
          ),
        )

      ],
    );
  }
}