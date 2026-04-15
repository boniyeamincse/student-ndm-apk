# Project Task List: NDM Member App

This document tracks the detailed implementation progress. Each module is broken down into sub-tasks for precise development management.

## Status Key
- `[x]` **Done**: Feature complete and tested.
- `[/]` **In Progress**: Under active development.
- `[ ]` **Pending**: To be implemented.
- `[!]` **Must Complete**: High priority for MVP.

---

## Phase 1: Foundation & Core (MVP)
### 1.1 Project Setup
- [x] Flutter project initialization `[!]`
- [x] Configure `pubspec.yaml` with required dependencies (Riverpod, Dio, GoRouter, etc.) `[!]`
- [x] Setup environment variables Handling `.env` (API Base URL) `[!]`

### 1.2 Architecture Implementation
- [x] Design and create Feature-first directory structure `[!]`
- [x] Implement Global Theme (Color Schemes, Google Fonts, Button Styles) `[!]`
- [x] Setup Repository/Controller pattern using Riverpod `[!]`

### 1.3 Core Infrastructure
- [x] **Network**: Configure Dio interceptors for auth tokens and error logging `[!]`
- [x] **Storage**: Setup Secure Storage for credentials and SharedPreferences for flags `[!]`
- [x] **Navigation**: Initialize GoRouter with protected/public route logic `[!]`

---

## Phase 2: Functional Modules (MVP)
### 2.1 Authentication (Module 02)
- [x] **UI**: Login screen design with validation `[!]`
- [x] **UI**: Forgot password dialog/screen `[!]`
- [x] **Logic**: AuthController with Login/Logout state management `[!]`
- [x] **API**: Integration with `/api/login` and `/api/me` `[!]`

### 2.2 Dashboard (Module 03)
- [x] **UI**: Multi-section home screen layout `[!]`
- [x] **Widget**: Quick Action Grid (6 major shortcuts) `[!]`
- [x] **Widget**: Interactive Announcement/Notice Carousel `[!]`
- [x] **State**: Combine stats from multiple providers (News, Profile, Notices) `[!]`

### 2.3 Member Profile (Module 04)
- [/] **UI**: Detailed Profile view with categorized tabs `[!]`
- [x] **UI**: Edit Profile screen with form validation `[!]`
- [x] **Feature**: Image Picker and Crop for profile photo upload `[!]`
- [x] **API**: Sync with `GET` and `PUT` `/api/member/profile` `[!]`

### 2.4 Digital Member Card (Module 05)
- [/] **UI**: Professional NDM Member Card design (CSS-like styling in Flutter) `[!]`
- [ ] **Logic**: Dynamic QR Code generation based on Member ID `[!]`
- [ ] **Feature**: Toggle between Card view and QR view `[!]`

---

## Phase 3: Organizational Updates (MVP)
### 3.1 Notices / News (Module 07)
- [/] **UI**: Paginated Notice list with search functionality `[!]`
- [ ] **UI**: Notice Detail view with image gallery support `[!]`
- [ ] **State**: Read/Unread state persistence (local or API) `[!]`

### 3.2 Events / Programs (Module 08)
- [/] **UI**: Calendar/List view for upcoming events `[!]`
- [ ] **UI**: Event details with "Add to Calendar" / Map location `[!]`
- [ ] **API**: Fetch from `/api/member/events` `[!]`

### 3.3 Committee Info (Module 06)
- [/] **UI**: Current committee membership card `[!]`
- [ ] **UI**: Hierarchy summary view (Current vs Parent) `[!]`
- [ ] **Logic**: Map complex committee JSON to domain entities `[!]`

---

## Phase 4: API Integration & Polishing
- [ ] **API**: finalize all Repository methods with proper error handling `[!]`
- [ ] **Logic**: Implement token refresh strategy (Silent Login) `[!]`
- [ ] **UI**: Add Shimmer loading states for all list views `[!]`
- [ ] **UX**: Implement Pull-to-refresh on all primary screens `[!]`
- [ ] **Dev**: Setup `build_runner` for automated serialization (Freezed/JSON) `[!]`

---

## Phase 5: Future Expansion (Post-MVP)
- [ ] **Push Notifications**: OneSignal or Firebase Cloud Messaging integration.
- [ ] **Offline Mode**: Hive or Sqflite database for caching notices/profile.
- [ ] **Directory**: Advanced filtering for member lookup.
- [ ] **Languages**: Localization (i18n) for Bengali and English.

---
*Last Updated: 2026-04-15*
