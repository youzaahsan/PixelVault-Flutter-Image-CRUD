# 📸 PixelVault (Flutter-Image-Crud)

### A Firebase-Backed Image Gallery CRUD App

Built with **Flutter** · Package name: `pixel_vault`

---

## 👨‍💻 Project Information

| | |
|---|---|
| **Project Name** | PixelVault (repository name: `Flutter-Image-Crud`; internal package name: `pixel_vault`) |
| **Project Type** | Cross-Platform Mobile/Desktop/Web Application (Flutter) |
| **Project Category** | Image Gallery CRUD Application |
| **Developer** | Not specified in the project files |
| **GitHub Repository** | (https://github.com/youzaahsan/PixelVault-Flutter-Image-CRUD) |
| **Frontend** | Flutter (Dart), Material 3 UI |
| **Backend** | Firebase (Cloud Firestore) — no custom server/API code |
| **Database** | Cloud Firestore (NoSQL, single `images` collection) |
| **API** | No custom REST/GraphQL API — the app talks directly to Firebase SDKs |
| **Authentication** | Not implemented — no login/user system found |
| **Architecture** | Flutter client → Firebase SDK (`cloud_firestore`) → Cloud Firestore, with images stored as Base64 strings inside Firestore documents |
| **Admin Panel** | Not present |
| **User/Customer Platform** | Single-user gallery app — no user accounts, roles, or multi-tenancy |

---

## 1. Project Overview

PixelVault is a Flutter application that lets a user pick an image from their device, add a title and description, and save it to a Cloud Firestore database. Saved images are displayed in a scrollable two-column gallery grid, and tapping an image opens a detail screen where the title, description, and the image itself can be edited or the entry can be deleted. The app is configured to run on Web (with explicit Firebase web configuration in code) and ships with the standard Flutter platform folders for Android, iOS, macOS, Windows, and Linux, though only the Web Firebase initialization path is explicitly configured in source.

**Problem it solves / purpose:** A simple, self-contained "photo notebook" — capturing an image alongside a title and description, with the ability to browse, edit, and remove entries later.

**Main users:** A single, unauthenticated user — there is no login, registration, or per-user data separation; every image saved goes into one shared Firestore collection visible to anyone who opens the app.

**Main sections:** Gallery grid (Home), Add Image form, Image Detail/Edit view.

**Main functionality:** Create, Read, Update, and Delete image entries, with images stored as Base64-encoded strings directly inside Firestore documents (not Firebase Storage, despite that package being listed as a dependency — see [Section 3](#3-technologies-used)).

**Overall architecture:** A single Flutter codebase (`lib/`) using the `cloud_firestore` package to read and write documents in one Firestore collection called `images`. There is no separate backend server, no REST API layer, and no authentication layer — the Flutter app is the entire application.

---

## 2. Project Category

**Image Gallery CRUD Application** — a small, single-collection Create/Read/Update/Delete mobile-first app built on Flutter and Firebase.

---

## 3. Technologies Used

### Frontend
- **Flutter** (Dart SDK `^3.10.7`), Material 3 (`useMaterial3: true`), dark color scheme seeded from `Colors.deepPurple`
- Standard Flutter widgets only (`StatelessWidget`/`StatefulWidget`, `StreamBuilder`, `GridView.builder`, `Form`/`TextFormField`) — no third-party UI/component library

### Backend
- **No custom backend server or API code exists in this project.** The app communicates directly with Firebase managed services via the Firebase Flutter SDKs.
- `firebase_core` — Firebase app initialization
- `cloud_firestore` — the only backend data store actually used in code

### Database
- **Cloud Firestore** (NoSQL document database), via the `cloud_firestore` package.
- **`firebase_storage` is listed in `pubspec.yaml` but is not imported or used anywhere in the Dart source code** — confirmed by inspection. Images are Base64-encoded and stored as a string field directly inside Firestore documents instead of being uploaded to Firebase Storage.

### APIs
- No custom REST API was found or implemented. All data access goes through the Firebase Firestore client SDK directly from the Flutter app (`FirebaseFirestore.instance.collection('images')`).

### Libraries & Frameworks (from `pubspec.yaml`)
| Package | Used in code? | Purpose |
|---|---|---|
| `firebase_core` | ✅ Yes | Initializes the Firebase app |
| `cloud_firestore` | ✅ Yes | Firestore reads/writes and real-time streaming |
| `firebase_storage` | ❌ Not used | Declared but no `firebase_storage` import found anywhere |
| `image_picker` | ✅ Yes | Picking an image from the gallery, with resizing/quality options |
| `image_picker_web` | ⚠️ Not directly imported | Listed as a dependency to enable `image_picker` on Flutter Web; not referenced directly in app code |
| `flutter_image_compress` | ❌ Not used | Declared in `pubspec.yaml` but not imported anywhere — the code comments describe compression via `image_picker`'s own `maxWidth`/`maxHeight`/`imageQuality` parameters instead |
| `cross_file` | ⚠️ Not directly imported | Transitive dependency of `image_picker`; not referenced directly in app code |
| `cupertino_icons` | Not observed in code | Available but no Cupertino icons were found used in the inspected screens |
| `flutter_lints` (dev) | N/A | Static analysis rules (`analysis_options.yaml`) |
| `flutter_test` (dev) | ✅ Yes | Used by `test/widget_test.dart` |

### UI / Design
- Material 3 design system (Flutter's built-in `ThemeData`)
- No custom design system, no Figma-exported theme files, no third-party UI kit

---

## 4. Project Structure

```
Flutter-Image-Crud/
├── lib/
│   ├── main.dart                       # App entry point, Firebase init, MaterialApp/theme
│   ├── models/
│   │   └── image_model.dart            # ImageModel: id, title, description, imageUrl, category, timestamp
│   ├── services/
│   │   └── firebase_service.dart       # Firestore CRUD logic (getImages/addImage/updateImage/deleteImage)
│   ├── screens/
│   │   ├── gallery_list_screen.dart    # Home screen: real-time grid of saved images
│   │   ├── add_image_screen.dart       # Form to pick an image and create a new entry
│   │   └── image_detail_screen.dart    # View / edit / delete a single image entry
│   └── widgets/                        # Present but empty — no custom shared widgets defined
│
├── test/
│   └── widget_test.dart                # Single smoke test checking the gallery title renders
│
├── android/                            # Standard Flutter Android platform project (incl. google-services.json)
├── ios/                                # Standard Flutter iOS platform project (incl. GoogleService-Info.plist)
├── web/                                # Flutter Web platform files (index.html, manifest.json, icons)
├── macos/ ├── windows/ ├── linux/      # Standard generated Flutter desktop platform projects
│
├── pubspec.yaml                        # Dependency manifest
├── pubspec.lock
├── analysis_options.yaml               # Default flutter_lints configuration
├── pixel_vault.iml
└── README.md
```

### Approximate File Counts (project-authored code only)
| Type | Count |
|---|---|
| Dart source files (`lib/`) | 6 |
| Dart test files (`test/`) | 1 |
| Firebase config files | 2 (`android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`) |

The `android/`, `ios/`, `web/`, `macos/`, `windows/`, and `linux/` directories are the **standard, unmodified boilerplate generated by the Flutter CLI** (`flutter create`) for each target platform — no custom native code, custom Gradle logic, or custom platform channels were found in any of them. The `lib/widgets/` folder exists but contains no files.

---

## 5. Database Implementation

- **Database technology:** Cloud Firestore (Google Firebase's NoSQL document database).
- **Connection:** The app connects via the `cloud_firestore` Flutter SDK, initialized through `Firebase.initializeApp()` in `lib/main.dart`. On Flutter Web, explicit `FirebaseOptions` (API key, project ID, app ID, etc.) are hard-coded in `main.dart`; on other platforms, `Firebase.initializeApp()` is called without explicit options, relying on the native config files (`google-services.json` for Android, `GoogleService-Info.plist` for iOS) instead.
- ⚠️ **Inconsistency found:** The Firebase **project ID embedded in the Web configuration in `main.dart`** differs from the **project ID found in `android/app/google-services.json`** — i.e., the Web build and the Android build are configured to point at two different Firebase projects. This should be verified/reconciled before relying on data consistency across platforms.
- **Collection ("table") confirmed in code:** a single Firestore collection named **`images`**.
- **Document fields (from `ImageModel` and `firebase_service.dart`):** `title` (string), `description` (string), `imageUrl` (string — holds a Base64-encoded image, not a URL, despite the field name), `category` (nullable string — stored and read, but never set by any UI in this project), `timestamp` (Firestore server timestamp).
- **No SQL database or SQL export is present or applicable** — this project does not use a relational database.
- **CRUD confirmed in code:**
  - **Create:** `FirebaseService.addImage()` — adds a new document with a Base64 image string.
  - **Read:** `FirebaseService.getImages()` and an equivalent inline query in `GalleryListScreen` — a real-time `snapshots()` stream ordered by `timestamp` descending.
  - **Update:** `FirebaseService.updateImage()` — updates any combination of title, description, category, and/or image bytes.
  - **Delete:** `FirebaseService.deleteImage()` — deletes the Firestore document by ID.
- **Security rules:** No Firestore security rules file (`firestore.rules`) was found in the uploaded project, so the effective read/write permissions on the `images` collection cannot be verified from this codebase alone.

---

## 6. Requirements

- **Flutter SDK** compatible with Dart `^3.10.7` (per `pubspec.yaml`)
- **Dart SDK** (bundled with Flutter)
- A **Firebase project** with Cloud Firestore enabled
- Platform-specific build tooling for whichever target you build:
  - Android: Android Studio / Android SDK
  - iOS/macOS: Xcode (macOS host required)
  - Web: any modern browser
  - Windows/Linux: the respective desktop build toolchains
- `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are **already included** in this project (see [Section 9](#9-configuration))

---

## 7. Installation & Setup

1. **Extract/clone** the project to a local directory.
2. **Install Flutter** if not already installed, and confirm your setup with:
   ```bash
   flutter doctor
   ```
3. **Install project dependencies:**
   ```bash
   flutter pub get
   ```
4. **Firebase configuration:** The project already contains Firebase config files (`android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`) and hard-coded Web `FirebaseOptions` in `lib/main.dart`. To use your own Firebase project, replace these files/values with your own project's configuration (see [Section 9](#9-configuration)).
5. **Enable Cloud Firestore** in your Firebase project console (Firestore is the only Firebase product actually used by this app's code).
6. **No environment variable file (`.env`) is used by this project** — configuration is embedded directly in the platform config files and in `main.dart`, not loaded from environment variables.
7. **Run the app** on a connected device, emulator, or browser:
   ```bash
   flutter run
   ```
   To target a specific platform, e.g.:
   ```bash
   flutter run -d chrome     # Web
   flutter run -d macos      # macOS
   flutter run -d windows    # Windows
   ```

---

## 8. Database Setup

There is no SQL file, no Firestore emulator seed data, and no `firestore.rules`/`firestore.indexes.json` file in the uploaded project. To set up the database:

1. Create (or use) a Firebase project.
2. Enable **Cloud Firestore** in Native mode.
3. No manual collection/document creation is required — the `images` collection is created automatically the first time an image is added through the app (Firestore creates collections implicitly on first write).
4. Configure Firestore security rules yourself, since none are included in this project — without proper rules, a freshly created Firestore database defaults to locked (deny-all) or fully open, depending on the mode chosen when the project was created.

---

## 9. Configuration

**Configuration files found:**
- `lib/main.dart` — contains hard-coded `FirebaseOptions` (API key, auth domain, project ID, storage bucket, messaging sender ID, app ID) used **only for the Flutter Web build path** (`kIsWeb` branch).
- `android/app/google-services.json` — standard Firebase Android configuration file, auto-generated by the Firebase console.
- `ios/Runner/GoogleService-Info.plist` — standard Firebase iOS configuration file, auto-generated by the Firebase console.

**What needs to be configured:**
- Replace the Web `FirebaseOptions` block in `main.dart` with your own Firebase Web app credentials if you are not using the project's existing Firebase backend.
- Replace `google-services.json` / `GoogleService-Info.plist` with your own if targeting your own Firebase project on Android/iOS.

⚠️ **Security note:** This project embeds a real **Firebase Web API key and project identifiers directly in `lib/main.dart`**, and includes real Android/iOS Firebase config files in the repository. Firebase Web API keys are not treated as secret by Firebase's own security model (Firestore access is governed by Firestore Security Rules, not by hiding this key), but as general good practice — especially since **no Firestore security rules file is present in this project to confirm what access those rules actually grant** — you should avoid committing production Firebase credentials to a public repository, verify your Firestore rules independently, and consider moving Web configuration to a build-time injected value (e.g., via `--dart-define`) rather than a literal in source. This README does not repeat the literal key/ID values found in the source as setup instructions beyond what is described above.

---

## 10. User / Customer Features

There is no distinction between "admin" and "user" — this is a single-role app. Feature status based on actual code:

| Feature | Status |
|---|---|
| View image gallery (grid) | ✅ IMPLEMENTED — real-time Firestore stream via `StreamBuilder` |
| Add a new image (pick + title + description) | ✅ IMPLEMENTED |
| Image resizing/quality reduction on pick | ✅ IMPLEMENTED — via `image_picker`'s `maxWidth`/`maxHeight`/`imageQuality` parameters (not via the separately-listed `flutter_image_compress` package, which is unused) |
| View image detail | ✅ IMPLEMENTED |
| Edit image (title, description, replace image) | ✅ IMPLEMENTED |
| Delete image (with confirmation dialog) | ✅ IMPLEMENTED |
| Category tagging | ⚠️ PARTIALLY IMPLEMENTED — the data model, service layer, and Firestore document schema all support a `category` field, but **no screen in the app exposes a UI control to set or edit it** — it will always be saved as `null` through the current UI |
| Search / filter / sort | ❌ NOT IMPLEMENTED — no search box, filter control, or sort option was found anywhere in the UI; the only ordering is the fixed `orderBy('timestamp', descending: true)` in the gallery query |
| Authentication / login / user accounts | ❌ NOT IMPLEMENTED |
| Image upload to Firebase Storage / CDN URLs | ❌ NOT IMPLEMENTED — despite `firebase_storage` being listed as a dependency, images are stored as Base64 strings inside Firestore documents, not uploaded to Storage |
| Offline support / caching | ❓ NOT VERIFIED — Firestore's SDK provides some offline caching by default, but no explicit offline configuration or handling code was found |

---

## 11. Admin Panel

**Not present.** There is no separate admin interface, no role differentiation, and no permissions system in this codebase — every user of the app has identical, unrestricted access to every image in the shared `images` collection.

---

## 12. Module-by-Module Implementation

### Image Data Model
- **Purpose:** Define the shape of an image entry and convert to/from Firestore documents.
- **File:** `lib/models/image_model.dart`.
- **Fields:** `id`, `title`, `description`, `imageUrl`, `category` (nullable), `timestamp`.
- **Status:** ✅ Implemented.

### Firebase Service (Data Access Layer)
- **Purpose:** Centralize all Firestore reads/writes for the `images` collection.
- **File:** `lib/services/firebase_service.dart`.
- **Frontend integration:** Called directly from `AddImageScreen` and `ImageDetailScreen`.
- **Backend/database:** Wraps `cloud_firestore`'s `CollectionReference` API; converts picked image bytes to Base64 before saving.
- **Status:** ✅ Implemented for Create, Read (stream), Update, and Delete.

### Gallery / Listing
- **Purpose:** Show all saved images in a responsive grid, updating live as data changes.
- **File:** `lib/screens/gallery_list_screen.dart`.
- **Frontend:** `StreamBuilder` + `GridView.builder` (2-column grid), loading spinner, empty-state message ("No images yet. Add one!"), and error display on stream errors.
- **Backend:** Live Firestore query ordered by `timestamp` descending.
- **Status:** ✅ Implemented.

### Add Image
- **Purpose:** Let the user create a new gallery entry.
- **File:** `lib/screens/add_image_screen.dart`.
- **Frontend:** Image picker preview, `Form` with required-field validation for title and description, loading state during upload, and a `SnackBar` for both the "no image selected" case and any save error.
- **Backend:** Calls `FirebaseService.addImage()`.
- **Status:** ✅ Implemented.

### Image Detail / Edit / Delete
- **Purpose:** View a single image's full details, edit it in place, or delete it.
- **File:** `lib/screens/image_detail_screen.dart`.
- **Frontend:** Toggleable edit mode, image replacement via the same picker flow, a confirmation `AlertDialog` before deletion, and `SnackBar` feedback for update success/failure.
- **Backend:** Calls `FirebaseService.updateImage()` and `FirebaseService.deleteImage()`.
- **Status:** ✅ Implemented.

### Authentication
- **Status:** ❌ Not implemented — no `firebase_auth` dependency, no login screen, and no user-scoping logic exist anywhere in the project.

### Categories
- **Status:** ⚠️ Partially implemented — modeled and persisted at the data layer, but with no UI to actually set a value (see [Section 10](#10-usercustomer-features)).

---

## 13. API Implementation

**No custom REST or GraphQL API was found or implemented in this project.** All data operations go directly from the Flutter client to Cloud Firestore through the official `cloud_firestore` SDK — there are no HTTP route handlers, no server framework, and no API endpoint definitions anywhere in the codebase.

The closest equivalent to "API operations" are the Firestore SDK calls made in `lib/services/firebase_service.dart`:

| Operation | SDK Call | Purpose |
|---|---|---|
| List (real-time) | `images.orderBy('timestamp', descending: true).snapshots()` | Stream all images, newest first |
| Create | `images.add({...})` | Add a new image document |
| Update | `images.doc(id).update({...})` | Update fields on an existing document |
| Delete | `images.doc(id).delete()` | Remove a document |

---

## 14. Authentication & Authorization

- **Registration:** ❌ Not implemented.
- **Login:** ❌ Not implemented.
- **Logout:** ❌ Not implemented (nothing to log out of).
- **Sessions / JWT:** ❌ Not implemented.
- **Password hashing:** Not applicable — no password-based auth exists.
- **Password reset / email verification:** ❌ Not implemented.
- **Role-based access:** ❌ Not implemented.
- **Protected routes:** ❌ Not implemented — every screen and every Firestore operation is reachable without any credential.

There is no authentication UI of any kind in this project, so there is nothing to distinguish from a "real" backend here — the app is entirely unauthenticated by design as currently built.

---

## 15. CRUD Operations

| Module | Create | Read | Update | Delete | Status |
|---|---|---|---|---|---|
| Images (`images` collection) | ✅ | ✅ | ✅ | ✅ | Full CRUD implemented |
| Categories | ✅ (field only, always null via UI) | ✅ (field only) | ✅ (field only) | N/A | Data-layer only, no UI |
| Users | ❌ | ❌ | ❌ | ❌ | Not implemented — no user concept exists |

---

## 16. Frontend Implementation

- **Pages/Screens:** `GalleryListScreen` (home), `AddImageScreen`, `ImageDetailScreen` — 3 screens total, navigated via `Navigator.push`/`MaterialPageRoute` (no named routes, no routing package).
- **Components:** No reusable custom widgets were found — `lib/widgets/` exists but is empty; each screen builds its own UI inline.
- **Layout/Navigation:** Standard `Scaffold` + `AppBar` per screen; a `FloatingActionButton` on the gallery screen navigates to the Add screen.
- **Forms:** `Form`/`TextFormField` with basic required-field validators on the Add screen; the Edit form on the detail screen uses plain `TextFormField`s without explicit validators.
- **Responsive design:** The gallery uses a fixed 2-column `GridView` (`SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)`) — this does not adapt its column count to screen size, so it is not responsive in the sense of adjusting layout across phone/tablet/desktop/web widths.
- **CSS framework:** Not applicable (Flutter uses Dart widgets, not CSS) — styling is via Flutter's `ThemeData`/Material 3.
- **JavaScript/UI libraries:** None — this is a native Flutter app, not a web-stack project.
- **Charts/animations:** None found.
- **Assets:** No custom image/font assets are declared in `pubspec.yaml`'s `assets:` section (it is commented out/unused); the only bundled images are the default Flutter Web favicon/app icons in `web/icons/`.

---

## 17. Backend Implementation

**There is no custom backend in this project.** "Backend" logic consists entirely of the Firebase Firestore SDK calls made directly from the Flutter client in `lib/services/firebase_service.dart`. There are no routes, controllers, middleware, or server-side business logic files of any kind. Firestore itself acts as the backend/data layer, and any authorization/business-rule enforcement would have to live in Firestore Security Rules — which are not included in this project and therefore cannot be verified.

---

## 18. Responsive Design

- **Desktop/Web/Mobile:** The app is built to run on all Flutter-supported platforms (the platform folders are present for Android, iOS, Web, macOS, Windows, and Linux), and Material widgets adapt their basic rendering per platform automatically.
- **Responsive navigation/forms:** Standard, non-adaptive `Scaffold`/`AppBar`/`Form` layouts — no platform- or width-specific layout branching was found.
- **Responsive grid:** ⚠️ The gallery grid is hard-coded to 2 columns (`crossAxisCount: 2`) regardless of screen width, so it does **not** reflow into more columns on larger screens (e.g., desktop or tablet) or fewer on very small screens.
- **Responsive tables/cards:** Not applicable — the app uses `Card` widgets in a grid, not data tables.

---

## 19. Security Inspection

| Practice | Status |
|---|---|
| Password hashing | Not applicable — no authentication exists |
| Authentication / Authorization | ❌ Not implemented |
| SQL injection protection / prepared statements | Not applicable — no SQL database is used |
| Firestore Security Rules | ❓ Not verified — no `firestore.rules` file is included in this project |
| Input validation | ⚠️ Minimal — required-field validation on the Add screen only; the Edit form has no validators |
| File upload validation | ⚠️ Minimal — the image picker restricts to the device's gallery picker UI and resizes images, but no explicit file-type or file-size validation is performed in code before upload |
| XSS protection | Not applicable — this is a native app, not a web page rendering untrusted HTML |
| CSRF protection | Not applicable — there is no custom HTTP API to protect |
| Environment variables for secrets | ❌ Not used — Firebase configuration (including a Web API key) is hard-coded directly in `lib/main.dart` and committed config files rather than loaded from environment variables or `--dart-define` |
| Firebase project consistency | ⚠️ The Web Firebase project ID (in `main.dart`) and the Android Firebase project ID (in `google-services.json`) do not match — see [Section 5](#5-database-implementation) |

---

## 20. Error Handling & Validation

- **Client-side validation:** `Add Image` screen validates that title and description are non-empty before submitting, and separately checks that an image has been selected (shown via `SnackBar`).
- **Server/database errors:** All Firestore operations in `firebase_service.dart` are wrapped in `try/catch`, log via `debugPrint`, and re-throw a descriptive string error (e.g., `'Database save failed: $e'`, `'Update failed: $e'`, `'Delete failed: $e'`), which calling screens catch and display via `SnackBar`.
- **Stream errors:** `GalleryListScreen`'s `StreamBuilder` explicitly checks `snapshot.hasError` and displays the error message in the UI.
- **Empty states:** An explicit "No images yet. Add one!" message is shown when the gallery is empty.
- **Broken image handling:** Both the gallery grid and the detail screen wrap image decoding in `try/catch` and fall back to a broken-image icon (`Icons.broken_image`) if Base64 decoding fails.

---

## 21. Search, Filtering & Sorting

- **Search:** ❌ Not implemented — no search input exists anywhere in the app.
- **Filtering (by category or otherwise):** ❌ Not implemented — despite the `category` field existing in the data model, no UI or query filters by it.
- **Sorting:** ⚠️ Implemented, but fixed — the gallery is always ordered by `timestamp` descending; there is no user-facing control to change the sort order.
- **Pagination:** ❌ Not implemented — the Firestore query fetches the entire `images` collection via a single unpaginated stream.

---

## 22. Reports & Analytics

**Not applicable.** This project contains no dashboard, reporting screen, chart, or analytics feature of any kind.

---

## 23. Testing Checklist

```
[ ] flutter pub get completes successfully
[ ] flutter doctor reports no blocking issues for your target platform
[ ] Firebase project is configured and Firestore is enabled
[ ] App launches and shows the "PixelVault Gallery" screen
[ ] Adding an image with title + description saves and appears in the gallery
[ ] Tapping a gallery item opens the Image Detail screen
[ ] Editing a title/description/image and saving updates the entry
[ ] Deleting an image (with confirmation) removes it from the gallery
[ ] Gallery correctly shows "No images yet. Add one!" when empty
[ ] flutter test runs the existing widget smoke test
```

**Existing automated tests:** `test/widget_test.dart` contains one widget smoke test that pumps `PixelVaultApp` and checks that the text "PixelVault Gallery" renders. Note that this test does **not** call `Firebase.initializeApp()` before pumping the widget (unlike `main()`), so it may fail or require additional Firebase test setup/mocking to pass reliably in a CI environment — this could not be fully verified without executing the test suite.

---

## 24. Confirmed Implemented Features

- ✅ Real-time image gallery grid backed by a Firestore stream
- ✅ Add new image (pick from gallery, title, description, resized/quality-reduced before upload)
- ✅ View full image detail
- ✅ Edit image title, description, and/or replace the image
- ✅ Delete image with a confirmation dialog
- ✅ Base64 image storage directly inside Firestore documents
- ✅ Basic required-field form validation on the Add screen
- ✅ Loading states, empty-state messaging, and error messaging throughout
- ✅ Multi-platform Flutter project structure (Android, iOS, Web, macOS, Windows, Linux)
- ✅ One existing automated widget test

## 25. Partially Implemented Features

- ⚠️ **Category tagging** — fully supported in the data model and service layer, but no screen provides a UI to actually set or edit a category.
- ⚠️ **Image compression** — achieved via `image_picker`'s built-in resize/quality parameters; the dedicated `flutter_image_compress` dependency listed in `pubspec.yaml` is not actually used.
- ⚠️ **Sorting** — present but fixed to newest-first with no user control.

## 26. Features Not Implemented / Not Found

- ❌ Search functionality
- ❌ Filtering by category or any other field
- ❌ Pagination
- ❌ Authentication, user accounts, or authorization of any kind
- ❌ Firebase Storage-based image hosting (images are Base64 in Firestore instead)
- ❌ Custom REST/GraphQL API
- ❌ Firestore Security Rules file (presence/content not included in the project)
- ❌ Responsive/adaptive grid layout (column count is hard-coded)
- ❌ Environment-variable-based configuration (`.env`, `--dart-define`, etc.)

---

## 27. Current Project Status

```
Frontend:        IMPLEMENTED
Backend:         NOT APPLICABLE (no custom backend — Firebase SDK used directly)
Database:        IMPLEMENTED (Cloud Firestore, single collection)
Authentication:  NOT FOUND
Admin:           NOT APPLICABLE
API:             NOT FOUND (no custom API; direct Firestore SDK usage only)
Categories:      PARTIAL (data-layer only)
Search/Filter:   NOT FOUND
Security:        NEEDS IMPROVEMENT (no auth, no included Firestore rules, hard-coded Web config)
```

---

## 28. Project Workflow

```
User
  ↓
Gallery List Screen (Firestore live stream)
  ↓
Tap "+" ──► Add Image Screen
                ↓
          Pick image (gallery, resized)
                ↓
          Enter title + description
                ↓
          Save ──► Firestore ("images" collection, Base64 imageUrl field)
                ↓
          Return to Gallery (auto-updates via stream)

Gallery List Screen
  ↓
Tap an image ──► Image Detail Screen
                     ↓
              Edit title/description/image  ──► Firestore update
                     or
              Delete (confirm) ──► Firestore delete
                     ↓
              Return to Gallery (auto-updates via stream)
```

---

## 29. Project Architecture

```
┌───────────────────────────────┐
│   Flutter Client (lib/)        │  Screens: Gallery / Add / Detail
│   - Material 3 UI              │
└───────────────┬─────────────────┘
                │ cloud_firestore SDK
┌───────────────▼─────────────────┐
│   Cloud Firestore                │  Collection: "images"
│   (title, description, imageUrl  │  imageUrl = Base64-encoded string
│    [Base64], category, timestamp)│
└───────────────────────────────┘
```

There is no intermediate server tier — the Flutter client talks directly to Firebase's managed Firestore service.

---

## 30. Common Errors & Solutions

| Error | Likely Cause | Solution |
|---|---|---|
| `[core/no-app] No Firebase App '[DEFAULT]' has been created` | `Firebase.initializeApp()` failed or wasn't awaited before Firestore is used | Ensure `main()`'s `await Firebase.initializeApp(...)` completes before `runApp()`, and check that your Firebase config files match your actual Firebase project |
| Images fail to upload with a size-related error | Base64-encoded image exceeds Firestore's ~1MB per-document field limit | Reduce `imageQuality`/`maxWidth`/`maxHeight` further in `_pickImage()`, or migrate to Firebase Storage instead of storing Base64 in Firestore |
| Image picker does nothing / crashes on iOS | Missing `NSPhotoLibraryUsageDescription` in `ios/Runner/Info.plist` — not present in this project | Add the required photo-library usage description key to `Info.plist` before building for iOS |
| Data appears in one platform's app but not another | The Web and Android builds are configured against **different Firebase project IDs** (see [Section 5](#5-database-implementation)) | Point both configurations at the same Firebase project, or intentionally keep them separate if that is desired |
| `PERMISSION_DENIED` errors from Firestore | No/overly restrictive Firestore Security Rules configured on the Firebase console (none are included in this project) | Configure appropriate Firestore Security Rules for the `images` collection in the Firebase console |
| `flutter pub get` fails on dependency resolution | Flutter/Dart SDK version mismatch with `environment: sdk: ^3.10.7` in `pubspec.yaml` | Upgrade your Flutter SDK to a version that includes the required Dart SDK |

---

## 31. Future Improvements

*(Reasonable improvements based on the gaps identified above — not existing functionality.)*

- Move image storage from Base64-in-Firestore to actual **Firebase Storage** (the dependency is already present but unused), storing a download URL in `imageUrl` instead of a Base64 blob.
- Add a **category picker** to the Add/Edit screens so the existing `category` field can actually be set by users.
- Implement **search and filtering** (by title, description, or category).
- Add **pagination** to the gallery query instead of loading the entire collection at once.
- Add **authentication** (e.g., Firebase Authentication) so images can be scoped per user, and add corresponding **Firestore Security Rules**.
- Reconcile the **mismatched Firebase project IDs** between the Web and Android configurations.
- Add the missing **iOS photo-library usage description** to `Info.plist`.
- Make the **gallery grid responsive** (adaptive column count based on screen width) for a better experience on tablet/desktop/web.
- Move hard-coded Firebase Web credentials out of source and into a build-time configuration mechanism.
- Add broader automated test coverage (the project currently has a single smoke test).

---

## 32. Quick Start

```bash
1. flutter pub get
2. Ensure Firebase/Firestore is configured (existing config files are included)
3. flutter run            # or: flutter run -d chrome / -d macos / -d windows
4. Tap "+" to add your first image
```

---

## 33. Project URLs

This is a client application with no local server component, so there are no local frontend/backend/admin/API URLs to list. When run on Flutter Web (`flutter run -d chrome` or a production web build), the app is served at whatever local address the Flutter tooling assigns (typically printed in the terminal, e.g., `http://localhost:<port>`).

**GitHub repository:** Not found in the uploaded project.

---

## 34. Final Project Summary

PixelVault is a compact, functional Flutter application that implements genuine, working Create/Read/Update/Delete operations against a Cloud Firestore `images` collection, including a live-updating gallery grid, an add-image form with client-side validation, and an edit/delete detail screen — all confirmed directly from the source code. Images are stored as Base64 strings inside Firestore documents rather than in Firebase Storage, despite that package being listed as a dependency. The project has no backend server, no custom API, and no authentication system — it is a single-user, unauthenticated client talking directly to Firebase. Notable gaps include an unused `category` field with no UI to set it, no search/filter/pagination, a non-responsive fixed 2-column grid, hard-coded (and, between platforms, inconsistent) Firebase configuration, and no included Firestore Security Rules. As a focused CRUD demo/learning project, the core image-management functionality is genuinely implemented and works end-to-end; production readiness would require the security, authentication, and configuration improvements listed above.

---

## 35. Final Project Information

```
PROJECT NAME:     PixelVault (Flutter-Image-Crud / pixel_vault)
PROJECT TYPE:     Cross-Platform Flutter Application
CATEGORY:         Image Gallery CRUD Application
FRONTEND:         Flutter (Dart), Material 3
BACKEND:          None — direct Firebase SDK usage from the client
DATABASE:         Cloud Firestore (collection: "images")
API:              None — no custom REST/GraphQL API
AUTHENTICATION:   Not implemented
ARCHITECTURE:     Flutter client → cloud_firestore SDK → Cloud Firestore
ADMIN:            Not applicable
USER/CUSTOMER:    Single-role, unauthenticated app
INSTALLATION:     flutter pub get && flutter run
DEVELOPER:        Youza Ahsan
GITHUB:           (https://github.com/youzaahsan)
```

---

<div align="center">

**PixelVault** — A Flutter + Firebase Image CRUD Application

</div>
