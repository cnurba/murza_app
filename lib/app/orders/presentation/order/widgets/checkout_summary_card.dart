import 'package:flutter/material.dart';
import 'package:murza_app/core/presentation/widgets/dashed_divider.dart';

class CheckoutSummaryCard extends StatelessWidget {
  const CheckoutSummaryCard({super.key, required this.totalAmount});
  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFFDF6FE),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildSummaryRow(
            label: 'Сумма',
            value: '${totalAmount.toInt()}c',
            textColor: Colors.black87,
          ),
          // _buildSummaryRow(
          //   label: 'Доставка',
          //   value: '190 c',
          //   textColor: Colors.black87,
          // ),
          // _buildSummaryRow(
          //   label: 'Бонусов к списанию',
          //   value: '0 BKG',
          //   isLast: true,
          //   textColor: Colors.black87,
          // ),
        ],
      ),
    );
  }


  Widget _buildSummaryRow({
    required String label,
    required String value,
    bool isLast = false,
    required Color textColor,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontSize: 16, color: textColor)),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const DashedDivider(),
      ],
    );
  }
}
