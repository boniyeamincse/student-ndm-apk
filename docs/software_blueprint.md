# APK Blueprint: NDM - Student Movement Member App

## 1. App Overview
- **App Name:** NDM - Student Movement
- **Type:** Member mobile app
- **Platform:** Flutter APK
- **Backend:** Laravel API
- **Users:** Student members, committee leaders, operators, admins
- **Goal:** Give members a simple mobile app to see profile, committee, notices, events, digital ID card, and organizational updates.

---

## 2. Main App Purpose
The app should help members:
- Log in securely
- View their profile
- See committee and designation
- View digital member card
- Receive notices
- Check events/programs
- Update basic profile info
- Stay connected with organization structure

---

## 3. User Types
### Member
- Log in
- View own profile
- View committee
- View notices
- View events
- View digital ID card

### Committee Leader
- All member actions
- Access to committee-level info and limited local tasks (future)

### App Admin / Operator
- Primarily handled via web admin portal.

---

## 4. APK Main Modules
### Module 00 — APK Blueprint & Architecture
- App planning, navigation flow, folder structure, and API strategy.

### Module 01 — App Setup & Core
- Flutter setup, theme, routes, API client, token storage, and splash screen.

### Module 02 — Authentication
- Login, forgot password, logout, and session checks.

### Module 03 — Dashboard
- Welcome section, quick actions, notices preview, events preview, and profile summary.

### Module 04 — Member Profile
- Personal, committee, contact, education, and address information; profile photo.

### Module 05 — Digital Member Card
- ID card preview, QR code, and membership status.

### Module 06 — Committee Info
- Current and parent committee, designation, and hierarchy summary.

### Module 07 — Notices / News
- Notice list and detailed view; read/unread states.

### Module 08 — Events / Programs
- Event list and detailed upcoming program info.

### Module 09 — Settings
- Language, notification preferences, password change, and app info.

### Module 10 — API Integration
- Connect modules to Laravel backend, error handling, and token refresh strategy.

---

## 5. Navigation Structure
**Primary Navigation:** Bottom Navigation Bar
- **Home**
- **Notices**
- **Events**
- **Profile**

**Secondary Navigation (accessible from Home/Profile):**
- Digital ID Card
- Committee Info
- Settings
- Edit Profile

---

## 6. Dashboard Blueprint
- Welcome message with member name, designation, and committee.
- **Quick Action Grid:** Profile, Digital Card, Committee Info, Notices, Events, Settings.
- Previews for Latest Notices and Upcoming Events.

---

## 7. Member Profile Blueprint
- **Header:** Photo, Name, ID, status badge, designation, and committee.
- **Sections:** Personal, organizational, contact, academic, and address info.
- **Actions:** Edit Profile, Show QR, Open Digital Card.

---

## 8. Digital Member Card Blueprint
- NDM Logo, member photo, name, ID, designation, committee, and status.
- Secure QR code for validation.

---

## 9. Committee Info Blueprint
- Current committee name, type, and level.
- Parent committee and current designation.
- *Future:* Leaders list and hierarchy tree.

---

## 10. Notices Module Blueprint
- List of latest notices with pinned items and unread indicators.
- **Details:** Title, date, content, and optional images/attachments.

---

## 11. Events Module Blueprint
- Categorized list of upcoming and past events.
- **Details:** Title, date, location, description, organizer, and venue.

---

## 12. Settings Blueprint
- Profile editing, password management, language settings, notification preferences, and Logout.

---

## 13. Flutter Tech Stack
- **Framework:** Flutter
- **State Management:** Riverpod
- **Networking:** Dio
- **Routing:** GoRouter
- **Storage:** flutter_secure_storage
- **Media:** cached_network_image, flutter_svg
- **Utilities:** qr_flutter, intl

---

## 14. Folder Structure
```text
lib/
  core/
    constants/, theme/, network/, storage/, utils/
  routes/
  shared/
    widgets/
  features/
    auth/, dashboard/, member_profile/, digital_card/, committee/, notices/, events/, settings/
      (each feature includes: screens, widgets, services, providers, models)
```

---

## 15. UI Style Blueprint
- **Aesthetic:** Clean, modern, lightweight, card-based with rounded corners.
- **Colors:** Primary Green, Accent Red/Dark Green, Background Gray/White.
- **Interactive:** Large touch areas, smooth spacing, and simple iconography.

---

## 16. API Endpoints Needed
- **Auth:** `/api/login`, `/api/logout`, `/api/me`
- **Profile:** `GET /api/member/profile`, `PUT /api/member/profile`
- **Modules:** endpoints for notices, events, card, committee, and password changes.

---

## 17. Data Models
- UserModel, MemberProfileModel, CommitteeModel, NoticeModel, EventModel, DigitalCardModel.

---

## 18. App Workflow
Standard flow from Splash -> Session Check -> Login or Dashboard -> Feature navigation.

---

## 19. MVP Version Priority
1. App Setup -> 2. Auth -> 3. Dashboard -> 4. Profile -> 5. Digital Card -> 6. Notices -> 7. Events -> 8. Settings.

---

## 20. Future Expansion
Push notifications, attendance, event registration, leader directory, offline caching, and in-app messaging.

---

## 21. Summary
The **NDM Member App** is a fast, modular, and member-focused APK integrated with a Laravel backend, designed for scale and professional organizational management.
