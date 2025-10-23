import 'package:flutter/material.dart';
import 'event_tag.dart';

class EventCard extends StatelessWidget {
  final String date;
  final String month;
  final String title;
  final String time;
  final String location;
  final List<EventTag> tags;
  final Color dateBoxColor;
  final Color rsvpButtonColor;
  final Gradient gradient;
  final VoidCallback onRsvpTap;

  const EventCard({
    super.key,
    required this.date,
    required this.month,
    required this.title,
    required this.time,
    required this.location,
    required this.tags,
    required this.dateBoxColor,
    required this.rsvpButtonColor,
    required this.gradient,
    required this.onRsvpTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: gradient,
        // The "glow" effect, using the event's specific color
        boxShadow: [
          BoxShadow(
            color: dateBoxColor.withOpacity(0.25),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildDateBox(),
          const SizedBox(width: 12),
          _buildDetails(),
          const SizedBox(width: 8),
          _buildRsvpButton(),
        ],
      ),
    );
  }

  /// Left side: The date box
  Widget _buildDateBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: dateBoxColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
          Text(
            month,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// Middle: Event title, time, location, and tags
  Widget _buildDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            location,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: tags),
          ),
        ],
      ),
    );
  }

  /// Right side: The translucent RSVP button
  Widget _buildRsvpButton() {
    return GestureDetector(
      onTap: onRsvpTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          // "Frosted glass" effect
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: rsvpButtonColor.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Text(
          'RSVP',
          style: TextStyle(
            color: rsvpButtonColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
