# App Groups Setup - Step by Step

## Why App Groups?
App Groups allow your main app and widget extension to share data through a shared container. Without this, the widget cannot access the class schedule you create in the main app.

## Setup Steps

### Step 1: Enable App Groups for Main App

1. In Xcode, select your project in the Navigator
2. Select the **Classly** target
3. Click on **Signing & Capabilities** tab
4. Click the **+ Capability** button
5. Search for and add **App Groups**
6. Click the **+** button in the App Groups section
7. Enter: `group.com.yourcompany.classly`
   - Replace `yourcompany` with your team identifier or company name
   - Must start with `group.`
8. Check the box to enable it

### Step 2: Enable App Groups for Widget Extension

1. Select the **ClasslyWidgetExtension** target
2. Click on **Signing & Capabilities** tab
3. Click the **+ Capability** button
4. Add **App Groups**
5. **Important**: Select the SAME group identifier you created in Step 1
   - It should appear in the dropdown
   - If not, click + and enter the exact same identifier
6. Check the box to enable it

### Step 3: Update the Code

1. Open `ScheduleManager.swift`
2. Find line 14:
   ```swift
   private let appGroupID = "group.com.yourcompany.classly"
   ```
3. Replace with YOUR App Group identifier from Steps 1 & 2

### Step 4: Verify Target Membership

Make sure files are added to the correct targets:

**ScheduleManager.swift** should be checked for:
- ✅ Classly
- ✅ ClasslyWidgetExtension

**ColorHelper.swift** should be checked for:
- ✅ Classly
- ✅ ClasslyWidgetExtension

**ContentView.swift, AddClassView.swift, SettingsView.swift** should be checked for:
- ✅ Classly only (NOT the widget extension)

To check/change target membership:
1. Select a file in the Project Navigator
2. Open the File Inspector (View → Inspectors → File Inspector or ⌥⌘1)
3. Look at the "Target Membership" section
4. Check/uncheck boxes as needed

## Verification

After setup, you should see:
- App Groups capability in both targets
- Same group identifier in both
- ScheduleManager.swift with matching appGroupID

## Common Mistakes

❌ **Using different group identifiers** in the two targets
   → Both must be EXACTLY the same

❌ **Forgetting to update ScheduleManager.swift**
   → The code must use the same identifier

❌ **Not adding ScheduleManager.swift to widget target**
   → The widget needs access to this file

❌ **Adding UI files to widget target**
   → ContentView, AddClassView, SettingsView should NOT be in widget target

## Testing

1. Build and run the app
2. Add a class
3. Add the widget to your home screen
4. The class should appear in the widget

If the widget shows "No more classes" even though you added classes:
- Double-check App Groups setup
- Verify both targets use the same identifier
- Check ScheduleManager.swift has correct appGroupID
- Clean build (⇧⌘K) and rebuild

## Need Help?

If you're still having issues:
1. Check the Console for error messages
2. Try removing and re-adding the App Groups capability
3. Make sure you're signed in with a valid Apple ID
4. Verify your bundle identifiers are correct
5. Clean build folder and rebuild

## App Group Naming Convention

Good examples:
- `group.com.yourcompany.classly`
- `group.com.example.classly`
- `group.dev.yourname.classly`

Bad examples:
- `classly` (missing `group.` prefix)
- `group.classly` (needs reverse domain notation)
- `com.yourcompany.classly` (missing `group.` prefix)

---

**Once App Groups is set up correctly, data will sync automatically between your app and widget!** 🚀
