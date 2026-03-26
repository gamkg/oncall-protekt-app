# MVP Theme Preview App Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a Flutter web app with 8 screens in two switchable themes (Dark Mode + Sentinel Dark) so the client can pick a design direction.

**Architecture:** Provider-based theme switching with a landing page that leads into a bottom-nav shell. Each screen is a stateless widget consuming theme tokens. All data is hardcoded in a single mock data file.

**Tech Stack:** Flutter 3.41.5, Provider, Google Fonts (Fira Code for Sentinel headers), Cloudflare Pages deployment.

**Spec:** `docs/superpowers/specs/2026-03-26-mvp-theme-preview-design.md`

**Design References:** `design-reference/*.png` (Stitch screens), `../oncall-protekt/public/images/current-app-ui/` (current app)

---

## File Structure

```
lib/
  main.dart                          # Entry point, Provider setup, MaterialApp
  theme/
    app_themes.dart                  # Both ThemeData objects + custom extensions
    theme_provider.dart              # ChangeNotifier for theme switching
  data/
    mock_data.dart                   # All hardcoded jobs, profile, notifications, etc.
  screens/
    theme_picker_screen.dart         # Landing page with two theme cards
    app_shell.dart                   # Bottom nav + floating theme toggle wrapper
    sign_in_screen.dart              # Login screen
    my_jobs_screen.dart              # Jobs list with tab filters
    profile_screen.dart              # Profile overview with menu
    edit_profile_screen.dart         # Edit profile form
    notifications_screen.dart        # System alerts list
    help_support_screen.dart         # Help center with chat, docs, tickets
    settings_screen.dart             # Settings menu
    preferred_officer_screen.dart    # Preferred officer list/empty state
  widgets/
    job_card.dart                    # Reusable job card widget
    notification_card.dart           # Reusable notification/alert card widget
    profile_menu_item.dart           # Reusable menu row (icon + label + chevron)
    stat_badge.dart                  # Stat display (e.g., Trust Score, Active Protekts)
    theme_toggle_pill.dart           # Floating theme toggle button
    sentinel_header.dart             # Sentinel-branded header with glow effects
assets/
  fonts/
    FiraCode-Regular.ttf             # Monospace font for Sentinel theme headers
    FiraCode-Bold.ttf
pubspec.yaml                         # Updated with provider, google_fonts, assets
```

---

## Task 1: Dependencies and Theme System

**Files:**
- Modify: `pubspec.yaml`
- Create: `lib/theme/app_themes.dart`
- Create: `lib/theme/theme_provider.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Add dependencies to pubspec.yaml**

Add `provider: ^6.1.2` and `google_fonts: ^6.2.1` under dependencies. Add font assets section:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.1.2
  google_fonts: ^6.2.1
```

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter pub get`
Expected: "Got dependencies!"

- [ ] **Step 2: Download Fira Code font files**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
mkdir -p assets/fonts
curl -L -o /tmp/FiraCode.zip "https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip"
unzip -j /tmp/FiraCode.zip "ttf/FiraCode-Regular.ttf" "ttf/FiraCode-Bold.ttf" -d assets/fonts/
```

Add to pubspec.yaml under `flutter:`:

```yaml
  fonts:
    - family: FiraCode
      fonts:
        - asset: assets/fonts/FiraCode-Regular.ttf
        - asset: assets/fonts/FiraCode-Bold.ttf
          weight: 700
```

- [ ] **Step 3: Create app_themes.dart**

Create `lib/theme/app_themes.dart` with:

- `AppColors` class: static const colors for both themes (background, surface, border, accent, textPrimary, textSecondary)
- `darkModeTheme` - ThemeData using Dark Mode colors, Inter/system font, 12px card radius
- `sentinelDarkTheme` - ThemeData using Sentinel colors, FiraCode for headlines, 8px card radius
- Custom `ThemeExtension<AppThemeExtras>` for non-standard tokens: glowColor, cardBorderColor, headerFontFamily, scanLineOverlay bool

Key colors:
- Dark Mode: bg `#0A0A0A`, surface `#1A1A1A`, border `#2A2A2A`, accent `#00E5CC`, textPri `#FFFFFF`, textSec `#9CA3AF`
- Sentinel: bg `#0D1117`, surface `#161B22`, border `#00E5CC33`, accent `#00E5CC`, textPri `#FFFFFF`, textSec `#8B949E`

- [ ] **Step 4: Create theme_provider.dart**

Create `lib/theme/theme_provider.dart`:

```dart
import 'package:flutter/material.dart';
import 'app_themes.dart';

enum AppThemeMode { darkMode, sentinelDark }

class ThemeProvider extends ChangeNotifier {
  AppThemeMode _mode = AppThemeMode.darkMode;

  AppThemeMode get mode => _mode;
  ThemeData get theme => _mode == AppThemeMode.darkMode ? darkModeTheme : sentinelDarkTheme;
  String get label => _mode == AppThemeMode.darkMode ? 'Dark Mode' : 'Sentinel Dark';
  String get otherLabel => _mode == AppThemeMode.darkMode ? 'Try Sentinel' : 'Try Dark Mode';

  void setTheme(AppThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void toggle() {
    _mode = _mode == AppThemeMode.darkMode ? AppThemeMode.sentinelDark : AppThemeMode.darkMode;
    notifyListeners();
  }
}
```

- [ ] **Step 5: Rewire main.dart**

Replace all of `lib/main.dart` with Provider setup:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/theme_provider.dart';
import 'screens/theme_picker_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const OnCallProtektApp(),
    ),
  );
}

class OnCallProtektApp extends StatelessWidget {
  const OnCallProtektApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'On Call Protekt',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.theme,
      home: const ThemePickerScreen(),
    );
  }
}
```

- [ ] **Step 6: Build to verify no errors**

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter build web 2>&1 | tail -5`

Note: ThemePickerScreen won't exist yet, so create a placeholder first. Create `lib/screens/theme_picker_screen.dart` with a minimal Scaffold returning `Text('Theme Picker')`.

Expected: Build succeeds

- [ ] **Step 7: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add -A
git commit -m "feat: add theme system with Provider, dual themes, font assets"
```

---

## Task 2: Mock Data

**Files:**
- Create: `lib/data/mock_data.dart`

- [ ] **Step 1: Create mock_data.dart**

Create `lib/data/mock_data.dart` with all hardcoded data as static constants:

```dart
class MockData {
  // Profile
  static const profileName = 'Alexander Sterling';
  static const profileRole = 'Verified Senior Operator';
  static const profileId = 'PS-9921-X84';
  static const activeProtekts = 12;
  static const trustScore = 99.8;
  static const rating = 4.9;
  static const totalJobs = 142;
  static const completionRate = 98;
  static const profileEmail = 'operator@protekt.elite';
  static const profilePhone = '(897) 098-7098';

  // Jobs list
  static const jobs = [
    {
      'id': 'PE-84201',
      'title': 'Upper East Side Perimeter Detail',
      'type': 'Residential Security',
      'location': 'Manhattan, NY',
      'date': 'Oct 24, 2023',
      'time': '18:00',
      'rate': 85.00,
      'status': 'completed',
      'risk': 'Medium',
    },
    {
      'id': 'PE-81199',
      'title': 'Gaia Event Close Protection',
      'type': 'Executive Protection',
      'location': 'Greenwich, CT',
      'date': 'Oct 21, 2023',
      'time': '20:00',
      'rate': 120.00,
      'status': 'completed',
      'risk': 'High',
    },
    {
      'id': 'PE-77250',
      'title': 'High-Value Asset Transit',
      'type': 'Transport Security',
      'location': 'Midtown, NY',
      'date': 'Oct 19, 2023',
      'time': '04:00',
      'rate': 95.00,
      'status': 'unserved',
      'risk': 'Critical',
    },
    {
      'id': 'PE-73100',
      'title': 'Corporate Campus Overnight',
      'type': 'Facility Watch',
      'location': 'Stamford, CT',
      'date': 'Oct 15, 2023',
      'time': '22:00',
      'rate': 70.00,
      'status': 'cancelled',
      'risk': 'Low',
    },
  ];

  // Notifications
  static const notifications = [
    {
      'title': 'Job Unserved',
      'body': 'Agent ID-402 failed to check-in at Sector 7 perimeter. Immediate reassignment required for Site Bravo.',
      'time': '14:23',
      'type': 'urgent',
      'hasActions': true,
    },
    {
      'title': 'Asset Movement Detected',
      'body': 'Encrypted Hardware Vault A-04 moved outside designated geofence. Tracking active via Sentinel-Link.',
      'time': '09:15',
      'type': 'warning',
      'hasActions': false,
    },
    {
      'title': 'System Maintenance',
      'body': 'Global firmware update v.8.2.0 scheduled for 00:00 UTC. Backup protocols will engage automatically during the window.',
      'time': '04:00',
      'type': 'info',
      'hasActions': false,
    },
    {
      'title': 'Access Granted: Executive Floor',
      'body': 'Biometric scan verified for Director Sterling, Floor 44 access unlocked.',
      'time': 'Yesterday',
      'type': 'success',
      'hasActions': false,
    },
    {
      'title': 'Weekly Threat Assessment',
      'body': 'Comprehensive report for Week 12 is ready for review in the dashboard analytics panel.',
      'time': 'Yesterday',
      'type': 'info',
      'hasActions': false,
    },
  ];

  // Help & Support
  static const activeInquiries = [
    {'title': 'Encryption Key Re...', 'agent': 'Agent Sarah', 'status': 'active', 'time': '14:02'},
    {'title': 'Node Synchroniza...', 'agent': 'Issue resolved autom...', 'status': 'closed', 'time': 'Yesterday'},
  ];

  // Settings
  static const settingsItems = ['Change Password', 'App Notification', 'Delete Account'];
}
```

- [ ] **Step 2: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add lib/data/mock_data.dart
git commit -m "feat: add mock data for all screens"
```

---

## Task 3: Shared Widgets

**Files:**
- Create: `lib/widgets/job_card.dart`
- Create: `lib/widgets/notification_card.dart`
- Create: `lib/widgets/profile_menu_item.dart`
- Create: `lib/widgets/stat_badge.dart`
- Create: `lib/widgets/theme_toggle_pill.dart`
- Create: `lib/widgets/sentinel_header.dart`

- [ ] **Step 1: Create profile_menu_item.dart**

Simple row widget: leading icon, label text, trailing chevron. Uses theme colors.

```dart
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final int? badge;

  const ProfileMenuItem({super.key, required this.icon, required this.label, this.onTap, this.badge});

  @override
  Widget build(BuildContext context) { ... }
}
```

- [ ] **Step 2: Create stat_badge.dart**

Displays a label + value pair (e.g., "TRUST SCORE" / "99.8%"). Sentinel variant adds glow effect.

- [ ] **Step 3: Create job_card.dart**

Card showing job title, type badge, location, date, rate. Reads theme for card styling. Sentinel variant gets cyan left-border accent.

- [ ] **Step 4: Create notification_card.dart**

Alert card with colored left-border based on type (urgent=red, warning=amber, info=blue, success=green). Optional Dispatch/Dismiss action buttons for urgent type.

- [ ] **Step 5: Create theme_toggle_pill.dart**

Floating pill button. Reads `ThemeProvider.otherLabel`, calls `toggle()` on tap. Positioned top-right. Semi-transparent background with accent border.

```dart
class ThemeTogglePill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    return Positioned(
      top: 12, right: 12,
      child: GestureDetector(
        onTap: () => tp.toggle(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xFF00E5CC), width: 1),
          ),
          child: Text(tp.otherLabel, style: TextStyle(color: Color(0xFF00E5CC), fontSize: 12)),
        ),
      ),
    );
  }
}
```

- [ ] **Step 6: Create sentinel_header.dart**

Header widget with "SENTINEL" branding text in FiraCode, subtle cyan glow. Only rendered when theme is Sentinel Dark (check `ThemeProvider.mode`). Dark Mode uses a simpler header.

- [ ] **Step 7: Build to verify**

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter build web 2>&1 | tail -5`
Expected: Build succeeds

- [ ] **Step 8: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add lib/widgets/
git commit -m "feat: add shared widgets (cards, menu items, badges, theme toggle)"
```

---

## Task 4: Theme Picker Landing Page

**Files:**
- Modify: `lib/screens/theme_picker_screen.dart`

- [ ] **Step 1: Build the theme picker screen**

Full-screen dark background (`#0A0A0A`). Centered layout:
1. On Call Protekt logo placeholder (shield icon with "OCP" text)
2. "Choose Your Experience" tagline
3. Two large cards stacked vertically:
   - Dark Mode card: dark gradient bg, "Clean. Premium. Modern." subtitle, tap to set theme and navigate to AppShell
   - Sentinel Dark card: darker bg with cyan glow border, "Tactical. Secure. Elite." subtitle, tap to set theme and navigate to AppShell
4. Each card shows a mini preview (just the card's accent color + typography sample)

On tap: `themeProvider.setTheme(mode)` then `Navigator.pushReplacement` to `AppShell`.

- [ ] **Step 2: Build to verify**

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter build web 2>&1 | tail -5`
Expected: Build succeeds

- [ ] **Step 3: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add lib/screens/theme_picker_screen.dart
git commit -m "feat: add theme picker landing page"
```

---

## Task 5: App Shell (Bottom Nav + Theme Toggle)

**Files:**
- Create: `lib/screens/app_shell.dart`

- [ ] **Step 1: Build the app shell**

Stateful widget managing:
- `_currentIndex` for bottom nav (0-4)
- IndexedStack of 5 pages: MyJobsScreen, placeholder Wallet, placeholder Add, NotificationsScreen, ProfileScreen
- BottomNavigationBar with 5 items: Home, Wallet, Add (+), History, Profile
- Center FAB for "Add" (index 2) - larger, accent colored
- Stack overlay with `ThemeTogglePill` positioned top-right

The shell wraps content in a `Stack` so the floating theme toggle appears over every screen.

- [ ] **Step 2: Build to verify**

Create placeholder screens for MyJobsScreen, NotificationsScreen, ProfileScreen (minimal Scaffold with centered Text).

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter build web 2>&1 | tail -5`
Expected: Build succeeds

- [ ] **Step 3: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add lib/screens/app_shell.dart
git commit -m "feat: add app shell with bottom nav and theme toggle overlay"
```

---

## Task 6: Sign In Screen

**Files:**
- Create: `lib/screens/sign_in_screen.dart`

- [ ] **Step 1: Build sign in screen**

Layout (both themes):
- Logo area at top (shield icon placeholder)
- Title: Dark Mode = "Welcome Back" / Sentinel = "SENTINEL LOGIN"
- Subtitle: Dark Mode = "Sign in to continue" / Sentinel = "SECURE ACCESS GATEWAY - LEVEL 4 CLEARANCE"
- Email field with label "Email" (Sentinel: "DEPLOYMENT EMAIL")
- Password field with label "Password" (Sentinel: "ACCESS KEY") + show/hide toggle + "Recover Key" link
- CTA button: Dark Mode = "Sign In" / Sentinel = "ESTABLISH CONNECTION"
- Alternative auth option (Sentinel: "IDENTITY SYNC" with fingerprint icon)
- Bottom: "New operator? Request access"
- Sentinel gets bottom status bar: "SYSTEM ONLINE | ENCRYPTION v4.2 | PROXY PROTECTED"

On CTA tap: navigate to AppShell (no real auth).

- [ ] **Step 2: Wire up sign_in as initial route after theme selection**

Update `theme_picker_screen.dart`: on theme card tap, navigate to `SignInScreen` instead of `AppShell`. SignInScreen CTA then navigates to `AppShell`.

- [ ] **Step 3: Build and verify**

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter build web 2>&1 | tail -5`
Expected: Build succeeds

- [ ] **Step 4: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add lib/screens/sign_in_screen.dart lib/screens/theme_picker_screen.dart
git commit -m "feat: add sign in screen with themed variants"
```

---

## Task 7: My Jobs Screen

**Files:**
- Modify: `lib/screens/my_jobs_screen.dart`

- [ ] **Step 1: Build my jobs screen**

Layout:
- Header: Dark Mode = "My Jobs" / Sentinel = "SENTINEL" header + "My Jobs" + earnings summary card ($12,840 + rating 4.9)
- TabBar: Completed | Unserved | Cancelled (filter `MockData.jobs` by status)
- ListView of `JobCard` widgets for filtered jobs
- Each tab shows relevant jobs; "Completed" also shows completion stats at bottom (98% completion, 142 total jobs, A+ reliability)

- [ ] **Step 2: Build and verify**

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter build web 2>&1 | tail -5`
Expected: Build succeeds

- [ ] **Step 3: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add lib/screens/my_jobs_screen.dart
git commit -m "feat: add my jobs screen with tab filters and job cards"
```

---

## Task 8: Profile Screen

**Files:**
- Modify: `lib/screens/profile_screen.dart`

- [ ] **Step 1: Build profile screen**

Layout:
- Avatar placeholder (circle with generic icon)
- Name + role badge (Dark Mode: "PREMIUM MEMBER" / Sentinel: "ELITE" badge)
- Profile ID (Sentinel only: "ID: PS-9921-X84")
- Stats row: Active Protekts + Trust Score (using `StatBadge` widgets)
- Section label: Dark Mode = "TACTICAL OPERATIONS" / Sentinel = "COMMAND CENTER"
- Menu items using `ProfileMenuItem`: Edit Profile, Job Posted, Preferred Officer, Settings, Help & Support, T&C/Privacy Policy
- Logout button at bottom (Sentinel: "LOGOUT SYSTEM")
- Version number footer

Menu item taps navigate to respective sub-screens.

- [ ] **Step 2: Build and verify**

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter build web 2>&1 | tail -5`
Expected: Build succeeds

- [ ] **Step 3: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add lib/screens/profile_screen.dart
git commit -m "feat: add profile screen with stats and menu"
```

---

## Task 9: Notifications Screen

**Files:**
- Modify: `lib/screens/notifications_screen.dart`

- [ ] **Step 1: Build notifications screen**

Layout:
- Header: Dark Mode = "System Alerts" / Sentinel = "COMMAND CENTER" with subtitle "REAL-TIME ENVIRONMENTAL & OPERATIONAL AWARENESS"
- Sentinel gets category filter chips: All, Security, System, Jobs, Alerts
- "TODAY" section label with "MARK ALL READ" action
- ListView of `NotificationCard` widgets from `MockData.notifications`
- First 3 under "TODAY", last 2 under "YESTERDAY"
- Urgent notification has Dispatch Unit / Dismiss buttons
- Sentinel variant: bottom area shows Trust Score gauge (99.8%) and threat level indicator ("LOW")

- [ ] **Step 2: Build and verify**

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter build web 2>&1 | tail -5`
Expected: Build succeeds

- [ ] **Step 3: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add lib/screens/notifications_screen.dart
git commit -m "feat: add notifications screen with alert cards and actions"
```

---

## Task 10: Help & Support Screen

**Files:**
- Modify: `lib/screens/help_support_screen.dart`

- [ ] **Step 1: Build help & support screen**

Layout:
- Header: Dark Mode = "Protekt Elite Support" / Sentinel = "SYSTEM SUPPORT CENTER" + "How can we secure your operations?"
- Blue/cyan gradient banner with "Start Conversation" chat CTA
- Search bar: "Search documentation or s..."
- Active Inquiries section with 2 mock inquiry rows (from `MockData.activeInquiries`)
- Documentation section: User Manual, Legal Policy, Privacy Shield/Policy
- Sentinel variant: "Recent Tickets" section with ticket items
- Bottom: "Still need assistance?" with Emergency Response Hotline and Submit Ticket / System Status buttons

- [ ] **Step 2: Build and verify**

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter build web 2>&1 | tail -5`
Expected: Build succeeds

- [ ] **Step 3: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add lib/screens/help_support_screen.dart
git commit -m "feat: add help and support screen"
```

---

## Task 11: Edit Profile, Settings, Preferred Officer Screens

**Files:**
- Create: `lib/screens/edit_profile_screen.dart`
- Create: `lib/screens/settings_screen.dart`
- Create: `lib/screens/preferred_officer_screen.dart`

- [ ] **Step 1: Build edit_profile_screen.dart**

Layout: Back arrow + "Edit Profile" header, centered avatar with camera icon overlay, form fields (Name, Mobile Number, Email) pre-filled from MockData, "Update" button at bottom. Themed to match.

- [ ] **Step 2: Build settings_screen.dart**

Layout: Back arrow + "Settings" header, card with 3 menu items: Change Password (lock icon), App Notification (bell icon), Delete Account (trash icon). Themed card styling.

- [ ] **Step 3: Build preferred_officer_screen.dart**

Layout: Back arrow + "Preferred Officer" header, empty state with illustration placeholder and "No Data Available" text. Themed.

- [ ] **Step 4: Wire navigation from ProfileScreen**

Update `profile_screen.dart` menu item onTap handlers to `Navigator.push` to each sub-screen.

- [ ] **Step 5: Build and verify**

Run: `cd /Users/tony/projects/clients/oncall-protekt-app && flutter build web 2>&1 | tail -5`
Expected: Build succeeds

- [ ] **Step 6: Commit**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add lib/screens/edit_profile_screen.dart lib/screens/settings_screen.dart lib/screens/preferred_officer_screen.dart lib/screens/profile_screen.dart
git commit -m "feat: add edit profile, settings, preferred officer screens"
```

---

## Task 12: Polish, Build, and Deploy

**Files:**
- Various touch-ups across all screens

- [ ] **Step 1: Add Sentinel-specific polish**

For Sentinel theme only:
- Subtle cyan glow on card borders (BoxShadow with `Color(0x3300E5CC)`)
- "SENTINEL" header branding on My Jobs and Notifications
- Monospace (FiraCode) for section labels and status text
- Scan-line overlay effect (optional: semi-transparent repeating gradient)

- [ ] **Step 2: Add page transition animations**

Use `PageRouteBuilder` with a fade transition for theme picker -> sign in -> app shell flow. Keep it subtle (200ms fade).

- [ ] **Step 3: Full build test**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
flutter build web
```

Expected: Build succeeds, output in `build/web/`

- [ ] **Step 4: Local preview test**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
python3 -m http.server 8888 --directory build/web
```

Open `http://localhost:8888` in Chrome. Verify:
- Theme picker loads
- Both themes render correctly
- All 8 screens accessible
- Theme toggle works on every screen
- Navigation between screens works

- [ ] **Step 5: Deploy to Cloudflare Pages**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
CLOUDFLARE_ACCOUNT_ID=1bbc70fd48269973c874711600c8d5bc npx wrangler pages project create oncall-protekt-app --production-branch main 2>&1 || true
CLOUDFLARE_ACCOUNT_ID=1bbc70fd48269973c874711600c8d5bc npx wrangler pages deploy build/web --project-name oncall-protekt-app
```

- [ ] **Step 6: Commit and push**

```bash
cd /Users/tony/projects/clients/oncall-protekt-app
git add -A
git commit -m "feat: polish, animations, deploy config"
git push origin main
```

---

## Summary

| Task | What | Files |
|------|------|-------|
| 1 | Theme system + Provider | theme/, main.dart, pubspec.yaml |
| 2 | Mock data | data/mock_data.dart |
| 3 | Shared widgets | widgets/* (6 files) |
| 4 | Theme picker landing | screens/theme_picker_screen.dart |
| 5 | App shell + bottom nav | screens/app_shell.dart |
| 6 | Sign in | screens/sign_in_screen.dart |
| 7 | My jobs | screens/my_jobs_screen.dart |
| 8 | Profile | screens/profile_screen.dart |
| 9 | Notifications | screens/notifications_screen.dart |
| 10 | Help & support | screens/help_support_screen.dart |
| 11 | Sub-screens (edit, settings, officer) | 3 screen files |
| 12 | Polish + deploy | touch-ups + Cloudflare Pages |
