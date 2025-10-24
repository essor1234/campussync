import 'package:flutter/material.dart';
import 'event_card.dart';
import 'custom_filter_chip.dart';
import 'event_tag.dart';

// --- App-wide Color Constants ---

const Color kColorTeal = Color(0xFF14B8A6);
const Color kColorGreen = Color(0xFF22C55E);
const Color kColorTagNeutral = Color(0xFF9E9E9E);

// --- Gradient for Cards ---

final kCardGradient = LinearGradient(
  colors: [
    const Color(0xFFE0FCF8).withOpacity(0.7),
    const Color(0xFFCFFBF0).withOpacity(0.7),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // This state is for handling tap actions, even if the UI doesn't change
  String _selectedFilter = 'All';

  void _onFilterTap(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
    // Matching action: Print to console on tap
    print('Selected filter: $filter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(children: [_buildFilterBar(), _buildEventList()]),
    );
  }

  /// Builds the top AppBar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pushReplacementNamed(context, '/'),
      ),
      title: const Text(
        'Event',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black, size: 28),
          onPressed: () {
            // Matching action: Print to console on tap
            print('Search button pressed');
          },
        ),
        const SizedBox(width: 8), // Padding for the action icon
      ],
    );
  }

  /// Builds the horizontal filter chip list
  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          CustomFilterChip(
            label: 'All',
            color: kColorTeal,
            onTap: () => _onFilterTap('All'),
          ),
          CustomFilterChip(
            label: 'Tech',
            color: kColorTeal,
            onTap: () => _onFilterTap('Tech'),
          ),
          CustomFilterChip(
            label: 'Design',
            color: kColorTeal,
            onTap: () => _onFilterTap('Design'),
          ),
          CustomFilterChip(
            label: 'Sports',
            color: kColorTeal,
            onTap: () => _onFilterTap('Sports'),
          ),
          CustomFilterChip(
            label: 'Volunteering',
            color: kColorGreen,
            onTap: () => _onFilterTap('Volunteering'),
          ),
        ],
      ),
    );
  }

  /// Builds the main vertical list of event cards
  Widget _buildEventList() {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          EventCard(
            date: '17',
            month: 'OCT',
            title: 'UI/UX Meetup',
            time: 'Today 17:00',
            location: 'Room: F2 Graphic',
            tags: const [
              EventTag(label: 'Design', color: kColorTeal),
              EventTag(label: 'Portfolio', color: kColorTagNeutral),
              EventTag(label: 'Free', color: kColorTagNeutral),
            ],
            dateBoxColor: kColorTeal,
            rsvpButtonColor: kColorTeal,
            gradient: kCardGradient,
            onRsvpTap: () => print('RSVP for UI/UX Meetup'),
          ),
          const SizedBox(height: 16),
          EventCard(
            date: '22',
            month: 'OCT',
            title: 'Mobile Dev Study Group',
            time: 'Wed 14:00',
            location: 'Room: Library',
            tags: const [
              EventTag(label: 'Tech', color: kColorTeal),
              EventTag(label: 'Peer', color: kColorTagNeutral),
            ],
            dateBoxColor: kColorTeal,
            rsvpButtonColor: kColorTeal,
            gradient: kCardGradient,
            onRsvpTap: () => print('RSVP for Mobile Dev Study Group'),
          ),
          const SizedBox(height: 16),
          EventCard(
            date: '24',
            month: 'OCT',
            title: 'Volunteer Day',
            time: 'Fri 09:00',
            location: 'Campus Yard',
            tags: const [EventTag(label: 'Volunteering', color: kColorGreen)],
            // Note how the colors change based on the event type
            dateBoxColor: kColorGreen,
            rsvpButtonColor: kColorGreen,
            gradient: kCardGradient,
            onRsvpTap: () => print('RSVP for Volunteer Day'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
