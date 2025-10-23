import 'package:campussync/screens/event/events_screen.dart';
import 'package:campussync/screens/schedule/schedule_screen.dart';
import 'package:flutter/material.dart';

class TimeSlotTile extends StatelessWidget {
  final String time;
  final ScheduleEvent? event;
  final VoidCallback? onEventTap;

  const TimeSlotTile({
    super.key,
    required this.time,
    this.event,
    this.onEventTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      height: event != null ? 100 : 50, // Taller if there is an event
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. The Time
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              time,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // 2. The Timeline and Event Card
          Expanded(
            child: event != null ? _buildEventCard(event!) : _buildEmptySlot(),
          ),
        ],
      ),
    );
  }

  /// Builds the card for an actual event
  Widget _buildEventCard(ScheduleEvent event) {
    return GestureDetector(
      onTap: onEventTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: kCardGradient,
          boxShadow: [
            BoxShadow(
              color: event.accentColor.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              event.title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              event.subtitle,
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 13,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              event.location,
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 13,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a simple line for an empty time slot
  Widget _buildEmptySlot() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(height: 1, color: Colors.grey[300]),
    );
  }
}
