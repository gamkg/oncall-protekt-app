# On Call Protekt - Mobile App

Dr. Zach Smith, welcome to the OCP mobile app repository. This contains the approved design preview and the full implementation plan for your developer.

## What's Here

### Live Preview

**https://oncall-protekt-app.pages.dev**

This is an interactive preview of your app built in Flutter. You can:
- Browse all 10 screens using the tabs on the left (desktop) or the horizontal pills at the top (mobile)
- Switch between **Dark Mode** (clean) and **Sentinel Dark** (tactical/monospace) using the buttons in the header
- Both variants use your approved **V1 Dark Navy + Yellow** color scheme

### Approved Design Direction

**Dark Mode** with the V1 color palette:
- Dark navy backgrounds (`#0B1121`)
- Yellow accent for buttons, active states, and CTAs (`#FACC15`)
- Clean typography, 14px card radius, no glow effects

### Screens (10 total)

| # | Screen | Description |
|---|--------|-------------|
| 1 | Login | Email/password sign in with OCP logo |
| 2 | Notifications | Alert feed grouped by day, action buttons on urgent items |
| 3 | My Jobs | Tabbed job list (Completed/Unserved/Cancelled) with stats |
| 4 | Profile | Avatar, stats, menu navigation to sub-screens |
| 5 | Edit Profile | Name, phone, email form with avatar upload |
| 6 | Preferred Officer | Officer cards with ratings and availability |
| 7 | Settings | Change password, notifications, delete account |
| 8 | Help & Support | Chat CTA, active inquiries, documentation links |

## For Your Developer

Everything needed to build the production app is in the `docs/` folder:

| File | What It Contains |
|------|------------------|
| [docs/implementation-plan.md](docs/implementation-plan.md) | Full spec: design tokens, screen details, API endpoints, data models, navigation map, 4-week build phases |
| [docs/production/lib/theme/app_theme.dart](docs/production/lib/theme/app_theme.dart) | Production-ready Flutter theme file with all color tokens and component styles |
| [docs/production/lib/models/](docs/production/lib/models/) | Dart data models (User, Job, Notification, PreferredOfficer, SupportConversation) with JSON serialization |

### What the Developer Needs from You

Before development can start, the developer will need:

1. **API base URL** and documentation (Swagger/OpenAPI spec)
2. **Firebase project** credentials (for push notifications)
3. **Apple Developer account** (for iOS/TestFlight builds)
4. **Google Play Console** account (for Android builds)
5. **App icon** artwork (1024x1024 PNG)
6. **Chat SDK preference** (Intercom, Zendesk, or custom)

## Tech Stack

- **Framework**: Flutter (Dart)
- **Platforms**: iOS + Android (currently previewing as web)
- **State Management**: Provider
- **Deployment**: Cloudflare Pages (preview), App Store + Google Play (production)

## Quick Links

- Live preview: https://oncall-protekt-app.pages.dev
- Web mockup reference: https://oncallprotekt.com/app-redesign/v1
- GitHub repo: https://github.com/gamkg/oncall-protekt-app
