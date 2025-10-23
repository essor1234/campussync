import 'package:campussync/screens/event/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'schedule_day_filter.dart';
import 'schedule_event_tile.dart';

import 'package:intl/intl.dart'; // Add 'intl' package to your pubspec.yaml
import 'calendar_day_chip.dart';
import 'time_slot_tile.dart';

// --- Data Model for an Event ---
class ScheduleEvent {
  final String title;
  final String subtitle;
  final String location;
  final DateTime startTime;
  final int durationInMinutes;
  final Color accentColor;

  ScheduleEvent({
    required this.title,
    required this.subtitle,
    required this.location,
    required this.startTime,
    this.durationInMinutes = 60,
    required this.accentColor,
  });
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  // --- STATE VARIABLES ---

  // View toggling state
  bool _isCalendarView = false;

  // State for List View
  String _selectedDayFilter = 'Today';

  // State for Calendar View
  DateTime _selectedCalendarDay = DateTime.now();
  final DateTime _today = DateTime.now();

  // --- SAMPLE DATA ---
  // In a real app, this would come from a database or API
  final Map<DateTime, List<ScheduleEvent>> _events = {};

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    _events.addAll({
      today: [
        ScheduleEvent(
          title: 'Daily Standup',
          subtitle: 'Team A Sync',
          location: 'Meet Room 3',
          startTime: today.add(const Duration(hours: 9)),
          durationInMinutes: 30,
          accentColor: kColorTeal,
        ),
        ScheduleEvent(
          title: 'Design Review',
          subtitle: 'UI/UX Feedback Session',
          location: 'Online Meeting',
          startTime: today.add(const Duration(hours: 11)),
          durationInMinutes: 60,
          accentColor: kColorTeal,
        ),
      ],
      tomorrow: [
        ScheduleEvent(
          title: 'Code Refactoring',
          subtitle: 'Improve component reusability',
          location: 'Remote',
          startTime: tomorrow.add(const Duration(hours: 10)),
          durationInMinutes: 120,
          accentColor: kColorTeal,
        ),
      ],
    });
  }

  // --- METHODS ---

  void _onDayFilterTap(String day) {
    setState(() {
      _selectedDayFilter = day;
    });
    print('Selected list view filter: $day');
  }

  void _onCalendarDayTap(DateTime day) {
    setState(() {
      _selectedCalendarDay = day;
    });
    print('Selected calendar day: $day');
  }

  void _toggleView() {
    setState(() {
      _isCalendarView = !_isCalendarView;
    });
    print('Toggled view to: ${_isCalendarView ? "Calendar" : "List"}');
  }

  // --- WIDGET BUILDERS ---

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      appBar: _buildAppBar(),
      body: _isCalendarView ? _buildCalendarView() : _buildListViewBody(),
    );
  }

  /// Builds the AppBar for the Schedule screen
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          print('Back button pressed on Schedule screen');
          // Example action: Navigator.pop(context);
        },
      ),
      title: const Text(
        'Schedule',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      actions: [
        // The new toggle button
        IconButton(
          icon: Icon(
            _isCalendarView
                ? Icons.view_list_outlined
                : Icons.calendar_month_outlined,
            color: Colors.black,
            size: 28,
          ),
          onPressed: _toggleView,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // --- LIST VIEW (Original) ---

  /// Body for the original "List View"
  Widget _buildListViewBody() {
    return Column(children: [_buildDayFilters(), _buildEventList()]);
  }

  /// Horizontal day filter chips (Today, Tomorrow, Upcoming)
  Widget _buildDayFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          ScheduleDayFilter(
            label: 'Today',
            isSelected: _selectedDayFilter == 'Today',
            onTap: () => _onDayFilterTap('Today'),
          ),
          ScheduleDayFilter(
            label: 'Tomorrow',
            isSelected: _selectedDayFilter == 'Tomorrow',
            onTap: () => _onDayFilterTap('Tomorrow'),
          ),
          ScheduleDayFilter(
            label: 'Upcoming',
            isSelected: _selectedDayFilter == 'Upcoming',
            onTap: () => _onDayFilterTap('Upcoming'),
          ),
          ScheduleDayFilter(
            label: 'Past',
            isSelected: _selectedDayFilter == 'Past',
            onTap: () => _onDayFilterTap('Past'),
          ),
        ],
      ),
    );
  }

  /// List of scheduled events
  Widget _buildEventList() {
    // This logic would be expanded based on the filter
    List<ScheduleEvent> eventsToShow = [];
    if (_selectedDayFilter == 'Today') {
      eventsToShow =
          _events[DateTime(_today.year, _today.month, _today.day)] ?? [];
    } else if (_selectedDayFilter == 'Tomorrow') {
      final tomorrow = DateTime(
        _today.year,
        _today.month,
        _today.day,
      ).add(const Duration(days: 1));
      eventsToShow = _events[tomorrow] ?? [];
    }

    if (eventsToShow.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text(
            'No events for this selection.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: eventsToShow.length,
        itemBuilder: (context, index) {
          final event = eventsToShow[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ScheduleEventTile(
              time: DateFormat('hh:mm a').format(event.startTime),
              title: event.title,
              subtitle: event.subtitle,
              location: event.location,
              gradient: kCardGradient, // Reusing gradient
              accentColor: event.accentColor,
              onTap: () => print('Tapped ${event.title}'),
            ),
          );
        },
      ),
    );
  }

  // --- CALENDAR VIEW (New) ---

  /// Body for the new "Calendar View"
  Widget _buildCalendarView() {
    return Column(
      children: [
        _buildWeekSelector(),
        const Divider(height: 1, color: Colors.black12),
        _buildDayTimeline(),
      ],
    );
  }

  /// The horizontal week selector strip
  Widget _buildWeekSelector() {
    // Building 7 days starting from today
    final List<DateTime> weekDays = List.generate(
      7,
      (index) => DateTime(
        _today.year,
        _today.month,
        _today.day,
      ).add(Duration(days: index)),
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: weekDays.map((day) {
          final isSelected =
              day.day == _selectedCalendarDay.day &&
              day.month == _selectedCalendarDay.month &&
              day.year == _selectedCalendarDay.year;
          return CalendarDayChip(
            day: day,
            isSelected: isSelected,
            onTap: () => _onCalendarDayTap(day),
          );
        }).toList(),
      ),
    );
  }

  /// The timeline for the selected day
  Widget _buildDayTimeline() {
    // Generate time slots from 8 AM to 5 PM
    final List<DateTime> timeSlots = List.generate(10, (index) {
      return DateTime(
        _selectedCalendarDay.year,
        _selectedCalendarDay.month,
        _selectedCalendarDay.day,
        8 + index, // 8 AM, 9 AM, 10 AM...
      );
    });

    // Get events for the selected day
    final selectedDayKey = DateTime(
      _selectedCalendarDay.year,
      _selectedCalendarDay.month,
      _selectedCalendarDay.day,
    );
    final dayEvents = _events[selectedDayKey] ?? [];

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          final slotTime = timeSlots[index];

          // Find an event that starts in this time slot
          ScheduleEvent? eventForSlot;
          try {
            eventForSlot = dayEvents.firstWhere(
              (event) => event.startTime.hour == slotTime.hour,
            );
          } catch (e) {
            eventForSlot = null; // No event found
          }

          return TimeSlotTile(
            time: DateFormat('hh:mm a').format(slotTime),
            event: eventForSlot,
            onEventTap: eventForSlot != null
                ? () => print('Tapped ${eventForSlot!.title}')
                : null,
          );
        },
      ),
    );
  }
}
