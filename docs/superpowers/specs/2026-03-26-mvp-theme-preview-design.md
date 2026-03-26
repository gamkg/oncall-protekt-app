# MVP Theme Preview App - Design Spec

## Purpose

Flutter web app that presents two theme variants (Dark Mode + Sentinel Dark) of the On Call Protekt mobile app, deployed to Cloudflare Pages. The client picks a design direction by browsing all screens in both themes.

## Architecture

- **Framework**: Flutter 3.41.5 (web target for MVP, iOS/Android later)
- **State management**: Provider (theme switching)
- **Deployment**: Cloudflare Pages at `oncall-protekt-app`
- **Data**: All mocked, no API calls
- **Repo**: github.com/gamkg/oncall-protekt-app

## Screens (8 per theme, 16 total)

| # | Screen | Stitch Source | Design Approach |
|---|--------|---------------|-----------------|
| 1 | Sign In | Sentinel only | Design Dark Mode variant to match |
| 2 | My Jobs | Both themes | Tabs: Completed/Unserved/Cancelled, job cards |
| 3 | Profile | Both themes | Avatar, stats, menu list |
| 4 | Edit Profile | None | Design both variants from current app reference |
| 5 | Notifications | Both themes | Alert cards with categories and actions |
| 6 | Help & Support | Both themes | Chat CTA, search, docs, tickets |
| 7 | Settings | None | Design both variants from current app reference |
| 8 | Preferred Officer | None | Design both variants from current app reference |

## Theme System

Two `ThemeData` objects, switchable at runtime via Provider.

### Dark Mode (clean premium)

- Background: `#0A0A0A`
- Surface/cards: `#1A1A1A` with `#2A2A2A` borders
- Accent: `#00E5CC` (cyan/teal)
- Text primary: `#FFFFFF`
- Text secondary: `#9CA3AF`
- Card radius: 12px, subtle 1px borders
- Typography: Clean sans-serif (Inter or system default)

### Sentinel Dark (tactical/ops)

- Background: `#0D1117`
- Surface/cards: `#161B22` with cyan-tinted borders `#00E5CC20`
- Accent: `#00E5CC` with glow effects (box shadows with cyan at low opacity)
- Text primary: `#FFFFFF`
- Text secondary: `#8B949E`
- Card radius: 8px, cyan accent left-border on active items
- Typography: Monospace for headers/labels (Fira Code or JetBrains Mono), sans-serif for body
- Extra: Subtle scan-line texture overlay, "SENTINEL" branding in header

## Navigation

### Theme Picker Landing Page

- Full-screen dark background
- On Call Protekt logo centered
- Tagline: "Choose Your Experience"
- Two large preview cards (stacked vertically):
  - "Dark Mode" - "Clean. Premium. Modern."
  - "Sentinel Dark" - "Tactical. Secure. Elite."
- Tapping enters that theme's full screen flow

### Bottom Navigation (5 tabs)

1. Home (My Jobs)
2. Wallet (placeholder)
3. Add (+) center FAB
4. History (Notifications)
5. Profile

### Floating Theme Toggle

- Small pill, top-right corner, every screen
- Shows other theme name (e.g., "Try Sentinel")
- Instant swap without changing current screen
- Quick fade animation

### Sub-screens (accessed from Profile menu)

- Edit Profile
- Settings
- Preferred Officer
- Help & Support

## Mocked Data

### Jobs (4 entries)

1. "Upper East Side Perimeter Detail" - Residential Security - $85/hr - Completed
2. "Gaia Event Close Protection" - Executive Protection - $120/hr - Completed
3. "High-Value Asset Transit" - Transport Security - $95/hr - Unserved
4. "Corporate Campus Overnight" - Facility Watch - $70/hr - Cancelled

### Profile

- Name: Alexander Sterling
- Role: Verified Senior Operator
- Active Protekts: 12
- Trust Score: 99.8%
- Rating: 4.9

### Notifications (5 alerts)

1. Job Unserved - urgent, with Dispatch/Dismiss buttons
2. Asset Movement Detected - warning
3. System Maintenance - info
4. Access Granted: Executive Floor - success
5. Weekly Threat Assessment - info

### Help & Support

- "Start Conversation" chat CTA
- 2 active inquiries (Encryption Key, Node Sync)
- Documentation: User Manual, Legal Policy, Privacy
- Emergency hotline: 6900-SENTINEL

## Reference Assets

Design reference images stored in `design-reference/`:
- `02-profile-dark.png` through `10-my-jobs-sentinel.png`
- Current app screenshots in oncall-protekt repo: `public/images/current-app-ui/`

## Success Criteria

- Client can open a URL on their phone
- Theme picker loads, client selects a theme
- All 8 screens browsable via bottom nav and profile menu
- Floating toggle switches themes instantly
- Both themes feel polished and distinct
- Client can make a confident design direction decision
