import 'package:flutter/material.dart';

enum TimePeriod { day, week, month }

class TimePeriodFilter extends StatelessWidget {
  final TimePeriod selectedPeriod;
  final ValueChanged<TimePeriod> onChanged;

  const TimePeriodFilter({
    super.key,
    required this.selectedPeriod,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _FilterButton(
            label: 'Día',
            isSelected: selectedPeriod == TimePeriod.day,
            onTap: () => onChanged(TimePeriod.day),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _FilterButton(
            label: 'Semana',
            isSelected: selectedPeriod == TimePeriod.week,
            onTap: () => onChanged(TimePeriod.week),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _FilterButton(
            label: 'Mes',
            isSelected: selectedPeriod == TimePeriod.month,
            onTap: () => onChanged(TimePeriod.month),
          ),
        ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7B5FFF) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade600,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
