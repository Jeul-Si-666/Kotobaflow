import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/practice/data/practice_repository.dart';
import '../../features/practice/presentation/flashcard_screen.dart';
import '../../features/practice/presentation/practice_screen.dart';
import '../../features/practice/presentation/quiz_screen.dart';
import '../../features/practice/presentation/survival_screen.dart';
import '../../features/statistics/presentation/statistics_screen.dart';
import '../../features/vocabulary/presentation/vocabulary_screen.dart';
import '../../features/vocabulary/presentation/word_detail_screen.dart';

/// Application router.
///
/// Uses [StatefulShellRoute.indexedStack] so each tab maintains its own
/// navigation stack. The shell widget adapts between a bottom [NavigationBar]
/// (mobile) and a [NavigationRail] (desktop ≥ 1024 px).
final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: false,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          _AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/vocabulary',
              builder: (context, state) => const VocabularyScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/practice',
              builder: (context, state) => const PracticeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/statistics',
              builder: (context, state) => const StatisticsScreen(),
            ),
          ],
        ),
      ],
    ),
    // ── Focused full-screen pages (without bottom bar) ────────────────────
    GoRoute(
      path: '/vocabulary/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? '';
        return WordDetailScreen(vocabularyId: id);
      },
    ),
    GoRoute(
      path: '/practice/flashcard',
      builder: (context, state) {
        final dirParam = state.uri.queryParameters['direction'];
        final direction = dirParam == 'id_to_ja'
            ? LearningDirection.idToJa
            : LearningDirection.jaToId;
        return FlashcardScreen(direction: direction);
      },
    ),
    GoRoute(
      path: '/practice/quiz',
      builder: (context, state) {
        final countParam = state.uri.queryParameters['count'];
        final count = int.tryParse(countParam ?? '5') ?? 5;
        return QuizScreen(questionCount: count);
      },
    ),
    GoRoute(
      path: '/practice/survival',
      builder: (context, state) => const SurvivalScreen(),
    ),
  ],
);

// ── Shell ─────────────────────────────────────────────────────────────────────

class _AppShell extends StatelessWidget {
  const _AppShell({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onDestinationSelected(int index) {
    navigationShell.goBranch(
      index,
      // Tapping the active tab scrolls back to the branch's initial location.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return _DesktopShell(
            navigationShell: navigationShell,
            onDestinationSelected: _onDestinationSelected,
          );
        }
        return _MobileShell(
          navigationShell: navigationShell,
          onDestinationSelected: _onDestinationSelected,
        );
      },
    );
  }
}

// ── Mobile shell — bottom NavigationBar ───────────────────────────────────────

class _MobileShell extends StatelessWidget {
  const _MobileShell({
    required this.navigationShell,
    required this.onDestinationSelected,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: _navDestinations,
      ),
    );
  }
}

// ── Desktop shell — NavigationRail + content ──────────────────────────────────

class _DesktopShell extends StatelessWidget {
  const _DesktopShell({
    required this.navigationShell,
    required this.onDestinationSelected,
  });

  final StatefulNavigationShell navigationShell;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: _railDestinations,
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: navigationShell),
        ],
      ),
    );
  }
}

// ── Shared destination data ───────────────────────────────────────────────────

const _navDestinations = <NavigationDestination>[
  NavigationDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home),
    label: 'Home',
  ),
  NavigationDestination(
    icon: Icon(Icons.library_books_outlined),
    selectedIcon: Icon(Icons.library_books),
    label: 'Vocabulary',
  ),
  NavigationDestination(
    icon: Icon(Icons.school_outlined),
    selectedIcon: Icon(Icons.school),
    label: 'Practice',
  ),
  NavigationDestination(
    icon: Icon(Icons.insights_outlined),
    selectedIcon: Icon(Icons.insights),
    label: 'Statistics',
  ),
];

const _railDestinations = <NavigationRailDestination>[
  NavigationRailDestination(
    icon: Icon(Icons.home_outlined),
    selectedIcon: Icon(Icons.home),
    label: Text('Home'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.library_books_outlined),
    selectedIcon: Icon(Icons.library_books),
    label: Text('Vocabulary'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.school_outlined),
    selectedIcon: Icon(Icons.school),
    label: Text('Practice'),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.insights_outlined),
    selectedIcon: Icon(Icons.insights),
    label: Text('Statistics'),
  ),
];
