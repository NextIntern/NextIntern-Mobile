// lib/widgets/criteria_card.dart
import 'package:flutter/material.dart';
import 'package:nextintern_mobile/models/criteria_model.dart';

class CriteriaCard extends StatelessWidget {
  final CriteriaModel criteria;

  const CriteriaCard({Key? key, required this.criteria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              criteria.criteria ?? 'No Criteria',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
                'Evaluate from Mentor: ${criteria.evaluateFromMentor ?? 'N/A'}'),
            const SizedBox(height: 4),
            Text('Started: ${criteria.start == true ? 'Yes' : 'No'}'),
            const SizedBox(height: 4),
            Text('Checked: ${criteria.isChecked == true ? 'Yes' : 'No'}'),
          ],
        ),
      ),
    );
  }
}
