import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/new_reservation_bloc.dart';

class ReservationGuestCounter extends StatelessWidget {
  const ReservationGuestCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewReservationBloc, NewReservationState>(
      buildWhen: (previous, current) => previous.guestCount != current.guestCount,
      builder: (context, state) {
        final int count = state.guestCount;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Número de Invitados',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  const Icon(Icons.group_outlined, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  const Text(
                    'Invitados',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),

                  // Decrement
                  _CounterButton(
                    icon: Icons.remove,
                    onTap: () {
                      if (count > 1) {
                        context.read<NewReservationBloc>().add(GuestCountChanged(count - 1));
                      }
                    },
                  ),

                  // Count
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '$count',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Increment
                  _CounterButton(
                    icon: Icons.add,
                    onTap: () {
                      context.read<NewReservationBloc>().add(GuestCountChanged(count + 1));
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// Small private widget for +/- buttons to keep markup clean
class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CounterButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 16, color: Colors.deepPurple),
      ),
    );
  }
}