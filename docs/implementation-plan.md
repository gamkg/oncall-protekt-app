# On Call Protekt - Mobile App Implementation Plan

**Client-approved theme**: Dark Mode (V1 Dark Navy + Yellow)
**Preview URL**: https://oncall-protekt-app.pages.dev
**Repo**: github.com/gamkg/oncall-protekt-app
**Date**: 2026-03-26

---

## 1. Approved Design System

### Color Tokens

| Token | Hex | Usage |
|-------|-----|-------|
| `background` | `#0B1121` | Scaffold, screen backgrounds |
| `surface` | `#1A2332` | Cards, input fields, elevated surfaces |
| `surfaceAlt` | `#1F2937` | Alternate card backgrounds, nested containers |
| `navBg` | `#111827` | Bottom nav bar, secondary surfaces |
| `accent` | `#FACC15` | Primary CTA, active states, icons, links |
| `onAccent` | `#0B1121` | Text/icons on accent-colored backgrounds |
| `accentGlow` | `rgba(250,204,21,0.3)` | Button shadows, logo glow |
| `textPrimary` | `#FFFFFF` | Headings, titles, body text |
| `textSecondary` | `#9CA3AF` | Subtitles, labels, helper text |
| `textMuted` | `#6B7280` | Inactive nav, placeholders, timestamps |
| `border` | `rgba(255,255,255,0.1)` | Card borders, dividers, input borders |
| `borderHover` | `rgba(255,255,255,0.2)` | Hover/focus borders |
| `statusSuccess` | `#10B981` | Completed jobs, online indicators |
| `statusWarning` | `#F59E0B` | Unserved alerts, caution states |
| `statusDanger` | `#EF4444` | Cancelled, delete, urgent alerts |
| `statusInfo` | `#3B82F6` | Info notifications, on-duty badges |

### Typography

| Style | Size | Weight | Color |
|-------|------|--------|-------|
| Headline (h1) | 26px | 700 | textPrimary |
| Headline (h2) | 22px | 700 | textPrimary |
| Headline (h3) | 18px | 600 | textPrimary |
| Title | 16px | 600 | textPrimary |
| Body | 15px | 400 | textPrimary |
| Body Secondary | 14px | 400 | textSecondary |
| Caption | 12px | 400 | textMuted |
| Label/CTA | 16px | 700 | onAccent (on buttons) |
| Small Label | 11px | 600 | textMuted |

Font: System default (San Francisco on iOS, Roboto on Android). No custom fonts needed for production.

### Component Specs

| Component | Border Radius | Border | Shadow |
|-----------|--------------|--------|--------|
| Cards | 14px | 1px `border` | None |
| Buttons (primary) | 12px | None | `0 4px 14px accentGlow` |
| Buttons (secondary) | 12px | 1px `accent@30%` | None |
| Input fields | 12px | 1px `border` | None |
| Bottom nav | 0 | Top 1px `border` | None |
| FAB | 26px (circle) | None | `0 4px 14px accentGlow` |
| Notification cards | 14px | Left 3px status color | None |
| Avatars | Circle | 2px `accent` | None |
| Badges/chips | 20px (pill) | None | None |

---

## 2. Screen Inventory (10 Screens)

### 2.1 Login / Sign In
- OCP logo (transparent PNG, centered, 100x100)
- "Welcome Back" heading
- "Sign in to continue" subtitle
- Email input (pre-filled placeholder: vendor@oncallprotekt.com)
- Password input with visibility toggle
- "Sign In" primary CTA button
- "Forgot Password?" link
- **API**: POST `/auth/login` with email + password
- **Auth**: Store JWT token, refresh token

### 2.2 Notifications
- Header: "Notifications" with "Clear all" action
- Notification cards with:
  - Icon + color by type (urgent=red, warning=amber, success=green, info=blue)
  - Title, body text, timestamp
  - Unread indicator (yellow dot)
  - Action buttons for urgent items (Dispatch Unit / Dismiss)
- Grouped by time: Today / Yesterday / Older
- Bottom nav visible
- **API**: GET `/notifications` (paginated), PUT `/notifications/:id/read`

### 2.3 My Jobs (Empty State)
- Header: "My Jobs"
- Tab bar: Completed / Unserved / Cancelled
- Empty state: Search icon, "No Data Available", "Completed jobs will appear here"
- Bottom nav visible
- **API**: GET `/jobs?status={tab}&page={n}`

### 2.4 My Jobs (With Data)
- Same tab bar structure
- Job cards showing:
  - Job ID (e.g. PE-84201)
  - Title, job type, risk badge (Critical/High/Medium/Low)
  - Location + date/time
  - Pay rate ($XX/hr)
  - Status color bar at top (green=completed, orange=unserved, red=cancelled)
- Stats footer: Completion %, Total Jobs, Reliability grade, Rating
- Bottom nav visible
- **API**: GET `/jobs?status={tab}&page={n}`

### 2.5 Profile
- Header: "Profile"
- Avatar with accent border
- Name + "PREMIUM" badge
- Verified role subtitle
- Stats row: Active Protekts count, Security Level %
- Menu sections:
  - TACTICAL OPERATIONS: Edit Profile, Job Posted (with badge count), Preferred Officer
  - SYSTEM PROTOCOLS: Settings, Help & Support, T&C/Privacy Policy
- Logout button (red, outlined)
- Version number footer
- Bottom nav visible
- **API**: GET `/profile`

### 2.6 Edit Profile
- Back nav header: "Edit Profile"
- Avatar with camera edit button
- Form fields: Name, Mobile Number, Email
- "Update" primary CTA button
- **API**: PUT `/profile` with form data

### 2.7 Preferred Officer
- Back nav header: "Preferred Officer"
- Empty state: Star icon, "No Preferred Officers" heading, description text, "Browse Officers" outlined button
- With data: Officer cards with avatar initials, name, rank, rating, job count, availability status
- "Add Preferred Officer" button
- **API**: GET `/preferred-officers`, POST `/preferred-officers/:id`

### 2.8 Settings
- Back nav header: "Settings"
- Card with menu items:
  - Change Password (lock icon)
  - App Notification (bell icon)
  - Delete Account (trash icon, red)
- Dividers between items
- **API**: GET `/settings`, PUT `/settings`

### 2.9 Help & Support
- Back nav header: "Help & Support"
- Chat CTA card: Accent icon, "Protekt Security" heading, "We typically reply in a few minutes", "Start Conversation" button
- Recent conversations list with unread badge
- **API**: GET `/support/conversations`, Intercom/Zendesk SDK integration

### 2.10 Help Messages
- Back nav header with "Messages" label
- "Start a new chat" section with send icon
- Recent conversation threads with timestamps and unread counts
- **API**: GET `/support/conversations/:id/messages`

---

## 3. Navigation Architecture

```
ThemePickerScreen (removed in production)
    |
    v
SignInScreen
    |
    v (on successful auth)
AppShell (BottomNavigationBar + FAB)
    |
    +-- Tab 0: MyJobsScreen (Home)
    +-- Tab 1: WalletScreen (placeholder)
    +-- Tab 2: FAB -> CreateJobScreen (future)
    +-- Tab 3: NotificationsScreen (History)
    +-- Tab 4: ProfileScreen
                |
                +-- EditProfileScreen
                +-- PreferredOfficerScreen
                +-- SettingsScreen
                +-- HelpSupportScreen
                        |
                        +-- HelpMessagesScreen
```

### Bottom Navigation Bar
| Position | Icon | Label | Screen |
|----------|------|-------|--------|
| 0 | home_outlined | Home | MyJobsScreen |
| 1 | account_balance_wallet_outlined | Wallet | WalletScreen |
| 2 | add (FAB) | - | CreateJobScreen |
| 3 | history | History | NotificationsScreen |
| 4 | person_outline | Profile | ProfileScreen |

---

## 4. Data Models

### User
```dart
class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;           // "Verified Senior Operator"
  final String? avatarUrl;
  final int activeProtekts;
  final double trustScore;     // 0-100
  final double rating;         // 0-5
  final int totalJobs;
  final int completionRate;    // 0-100
  final String profileId;      // "PS-9921-X84"
}
```

### Job
```dart
class Job {
  final String id;             // "PE-84201"
  final String title;
  final String type;           // "Residential Security", "Executive Protection", etc.
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final double rate;           // per hour
  final JobStatus status;      // completed, unserved, cancelled
  final RiskLevel risk;        // critical, high, medium, low
  final int officerCount;
  final int officerRequired;
}

enum JobStatus { completed, unserved, cancelled }
enum RiskLevel { critical, high, medium, low }
```

### Notification
```dart
class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final NotificationType type; // urgent, warning, success, info
  final bool isRead;
  final bool hasActions;
}

enum NotificationType { urgent, warning, success, info }
```

### PreferredOfficer
```dart
class PreferredOfficer {
  final String id;
  final String name;
  final String rank;
  final double rating;
  final int jobCount;
  final OfficerStatus status;  // available, onDuty, offline
}

enum OfficerStatus { available, onDuty, offline }
```

### SupportConversation
```dart
class SupportConversation {
  final String id;
  final String title;
  final String lastMessage;
  final DateTime lastMessageAt;
  final String agentName;
  final int unreadCount;
  final ConversationStatus status; // active, closed
}

enum ConversationStatus { active, closed }
```

---

## 5. API Integration Points

The app connects to the OCP backend. All endpoints require Bearer token auth.

| Endpoint | Method | Screen | Purpose |
|----------|--------|--------|---------|
| `/auth/login` | POST | Sign In | Email/password login |
| `/auth/refresh` | POST | Global | Token refresh |
| `/auth/forgot-password` | POST | Sign In | Password reset email |
| `/profile` | GET | Profile | Current user data |
| `/profile` | PUT | Edit Profile | Update name/phone/email |
| `/profile/avatar` | PUT | Edit Profile | Upload avatar |
| `/jobs` | GET | My Jobs | Paginated, filterable by status |
| `/jobs/:id` | GET | Job Detail | Single job details (future) |
| `/notifications` | GET | Notifications | Paginated list |
| `/notifications/:id/read` | PUT | Notifications | Mark as read |
| `/notifications/read-all` | PUT | Notifications | Mark all read |
| `/preferred-officers` | GET | Preferred Officer | List preferred officers |
| `/preferred-officers/:id` | POST | Preferred Officer | Add preferred officer |
| `/preferred-officers/:id` | DELETE | Preferred Officer | Remove preferred officer |
| `/settings` | GET | Settings | Get app settings |
| `/settings` | PUT | Settings | Update settings |
| `/support/conversations` | GET | Help & Support | List conversations |
| `/support/conversations/:id/messages` | GET | Help Messages | Message thread |

---

## 6. Production Dependencies (to add)

```yaml
dependencies:
  # State management
  provider: ^6.1.2          # Already installed

  # Networking
  dio: ^5.4.0               # HTTP client with interceptors

  # Auth
  flutter_secure_storage: ^9.0.0  # JWT token storage

  # Navigation
  go_router: ^14.0.0        # Declarative routing

  # UI
  cached_network_image: ^3.3.0  # Avatar/image caching
  shimmer: ^3.0.0           # Loading skeletons
  pull_to_refresh: ^2.0.0   # Pull-to-refresh lists

  # Push notifications
  firebase_messaging: ^15.0.0
  firebase_core: ^3.0.0

  # Device
  image_picker: ^1.0.0      # Avatar upload
  url_launcher: ^6.2.0      # Phone/email links

  # Analytics
  firebase_analytics: ^11.0.0
```

---

## 7. Files to Generate for Developer

### Keep from preview (production-ready)
- `lib/theme/app_themes.dart` - Design tokens (remove Sentinel theme, clean up V1 duplicates)
- `assets/ocp-logo.png` - Transparent logo

### Rewrite for production
- `lib/main.dart` - Remove web preview shell, add GoRouter, auth state
- `lib/screens/*.dart` - Remove mock data imports, connect to API
- `lib/widgets/*.dart` - Remove theme toggle, web preview widgets

### New files needed
- `lib/models/` - User, Job, Notification, PreferredOfficer, SupportConversation
- `lib/services/api_service.dart` - Dio HTTP client with auth interceptors
- `lib/services/auth_service.dart` - Login, logout, token management
- `lib/services/notification_service.dart` - Push notification handling
- `lib/repositories/` - Job, Notification, Profile, Support repositories
- `lib/providers/` - AuthProvider, JobProvider, NotificationProvider, ProfileProvider
- `lib/router.dart` - GoRouter configuration with auth guards
- `lib/widgets/loading_skeleton.dart` - Shimmer loading states
- `lib/widgets/empty_state.dart` - Reusable empty state component
- `lib/widgets/error_state.dart` - Error/retry component

### Remove (preview-only)
- `lib/widgets/web_preview_shell.dart`
- `lib/widgets/iphone_frame.dart`
- `lib/widgets/theme_toggle_pill.dart`
- `lib/screens/theme_picker_screen.dart`
- `lib/data/mock_data.dart`
- `lib/theme/theme_provider.dart` (replaced by single theme)

---

## 8. Build Phases

### Phase 1: Foundation (Week 1)
- [ ] Clean theme file (single Dark Mode theme, no Sentinel)
- [ ] Data models
- [ ] API service with Dio + auth interceptors
- [ ] Auth flow (login, token storage, auto-refresh)
- [ ] GoRouter with auth guards
- [ ] App shell with bottom nav

### Phase 2: Core Screens (Week 2)
- [ ] Sign In screen (real auth)
- [ ] My Jobs screen (API-connected, pagination, pull-to-refresh)
- [ ] Notifications screen (API-connected, mark as read)
- [ ] Profile screen (API-connected)
- [ ] Loading skeletons for all screens

### Phase 3: Secondary Screens (Week 3)
- [ ] Edit Profile (form validation, avatar upload)
- [ ] Settings screen
- [ ] Preferred Officer screen
- [ ] Help & Support (chat SDK integration)
- [ ] Empty states and error states

### Phase 4: Polish & Deploy (Week 4)
- [ ] Push notifications (Firebase)
- [ ] Deep linking
- [ ] App icon and splash screen
- [ ] iOS build + TestFlight
- [ ] Android build + internal testing
- [ ] Analytics events

---

## 9. Assets Needed from Client

| Asset | Format | Status |
|-------|--------|--------|
| OCP Logo (transparent) | PNG, SVG | Have (PNG) |
| App Icon (1024x1024) | PNG | Needed |
| Splash screen graphic | PNG | Needed |
| API base URL | URL | Needed |
| API documentation/Swagger | URL | Needed |
| Firebase project credentials | JSON | Needed |
| Apple Developer account | Credentials | Needed |
| Google Play Console account | Credentials | Needed |
| Intercom/Zendesk API key (for chat) | Key | Needed |

---

## 10. Reference

- **Live preview**: https://oncall-protekt-app.pages.dev
- **Web mockup (V1)**: https://oncallprotekt.com/app-redesign/v1
- **GitHub repo**: https://github.com/gamkg/oncall-protekt-app
- **Design tokens source**: `lib/theme/app_themes.dart`
- **V1 theme definition**: `src/components/app-redesign/themes.ts` (in oncall-protekt repo)
