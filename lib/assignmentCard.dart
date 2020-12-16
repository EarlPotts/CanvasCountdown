import 'package:canvas_countdown/APIUse.dart';
import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  Assignment assignment;


  AssignmentCard(this.assignment);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            assignment.name
          )
        ],
      ),
    );
  }
}
