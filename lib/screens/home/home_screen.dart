// lib/screens/home/home_screen.dart
import 'package:campussync/screens/home/home_section_header.dart';
import 'package:campussync/screens/home/home_suggestion_card.dart';
import 'package:campussync/screens/home/home_bottom_chat_bar.dart';
import 'home_section_header.dart';
import 'package:campussync/screens/home/home_top_card.dart';
import 'package:campussync/screens/home/home_upcoming_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// --- Color & Gradient Constants ---
const kHomeTopCardGradient = LinearGradient(
  colors: [Color(0xFF448AFF), Color(0xFF2979FF)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kHomeGreenGradient = LinearGradient(
  colors: [Color(0xFFA7FFEB), Color(0xFF64FFDA)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kHomeLightBlueGradient = LinearGradient(
  colors: [Color(0xFFB3E5FC), Color(0xFF81D4FA)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kHomeLighterBlueGradient = LinearGradient(
  colors: [Color(0xFFE1F5FE), Color(0xFFB3E5FC)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kHomeBlueGradient = LinearGradient(
  colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const Color kHomeDarkGreen = Color(0xFF00695C);
const Color kHomeDarkBlue = Color(0xFF0D47A1);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const HomeTopCard(),
            _buildSuggestSection(context),
            _buildUpcomingSection(context),
            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomChatBar(
        onTap: () => Navigator.pushNamed(context, '/study'),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leadingWidth: 70,
      leading: const Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
          radius: 22,
          backgroundColor: Color(0xFFFDEFEA),
          child: Text(
            'M',
            style: TextStyle(
              color: Color(0xFFF57C00),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: const Text(
        'Hello Mia',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black54, size: 28),
          onPressed: () => print('Search pressed'),
        ),
        _buildNotificationIcon(),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildNotificationIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: const Icon(
            Icons.notifications_outlined,
            color: Colors.black54,
            size: 28,
          ),
          onPressed: () => print('Notifications pressed'),
        ),
        Positioned(
          top: 14,
          right: 14,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        children: [
          HomeSectionHeader(
            title: 'Suggest for you',
            onSeeAllTap: () => Navigator.pushNamed(context, '/events'),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Events Card
              Expanded(
                flex: 2,
                child: HomeSuggestionCard(
                  title: 'Events for you',
                  buttonText: '3 matches today',
                  icon: const CircleAvatar(
                    backgroundColor: kHomeDarkGreen,
                    radius: 20,
                  ),
                  gradient: kHomeGreenGradient,
                  onCardTap: () => Navigator.pushNamed(context, '/events'),
                ),
              ),
              const SizedBox(width: 16),
              // Weekly Plan + Study AI
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    HomeSuggestionCard(
                      title: 'Weekly Plan',
                      isSmall: true,
                      icon: const CircleAvatar(
                        backgroundColor: kHomeDarkBlue,
                        radius: 14,
                      ),
                      gradient: kHomeLightBlueGradient,
                      onCardTap: () =>
                          Navigator.pushNamed(context, '/schedule'),
                    ),
                    const SizedBox(height: 16),
                    HomeSuggestionCard(
                      title: 'Study AI Agent',
                      isSmall: true,
                      icon: CircleAvatar(
                        backgroundColor: Colors.blue.shade300,
                        radius: 14,
                      ),
                      gradient: kHomeLighterBlueGradient,
                      onCardTap: () => Navigator.pushNamed(context, '/study'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: HomeSectionHeader(
            title: 'Upcoming',
            onSeeAllTap: () => Navigator.pushNamed(context, '/schedule'),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              HomeUpcomingCard(
                title: 'HCI Lecture',
                subtitle: 'Today 09:00\nF2 Studio',
                icon: const CircleAvatar(
                  backgroundColor: kHomeDarkGreen,
                  radius: 16,
                ),
                gradient: kHomeGreenGradient,
                onTap: () => Navigator.pushNamed(context, '/schedule'),
              ),
              const SizedBox(width: 16),
              HomeUpcomingCard(
                title: 'UI/UX Meetup',
                subtitle: 'Today 17:00\nRoom: F2 Graphic',
                icon: const CircleAvatar(
                  backgroundColor: kHomeDarkBlue,
                  radius: 16,
                ),
                gradient: kHomeBlueGradient,
                onTap: () => Navigator.pushNamed(context, '/events'),
              ),
              const SizedBox(width: 16),
              HomeUpcomingCard(
                title: 'Study Sprint',
                subtitle: 'Tomorrow 10:00\nLibrary',
                icon: CircleAvatar(
                  backgroundColor: Colors.orange.shade800,
                  radius: 16,
                ),
                gradient: LinearGradient(
                  colors: [Colors.orange.shade50, Colors.orange.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () => print('Study Sprint tapped'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
