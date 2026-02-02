# Classly Widget Setup Guide

## 📋 Overview
Your Classly app now has full functionality to:
- ✅ Add, edit, and delete classes
- ✅ Choose custom emojis for each class
- ✅ Customize widget background colors
- ✅ Share data between the main app and widget

## 🔧 Required Setup Steps

### 1. Enable App Groups (IMPORTANT!)

To share data between your app and widget, you need to set up App Groups:

1. **Select your main app target** in Xcode
2. Go to **Signing & Capabilities**
3. Click **+ Capability** and add **App Groups**
4. Click the **+** button under App Groups
5. Name it: `group.com.yourcompany.classly` (or use your own identifier)
6. Check the box to enable it

7. **Repeat for the widget target**:
   - Select `ClasslyWidgetExtension` target
   - Add **App Groups** capability
   - **Use the same group identifier** from step 5

8. **Update ScheduleManager.swift**:
   - Open `ScheduleManager.swift`
   - Change line 14: `private let appGroupID = "group.com.yourcompany.classly"`
   - Replace with your actual App Group identifier

### 2. Add New Files to Targets

Make sure these new files are added to the correct targets:

**ScheduleManager.swift** → Add to BOTH:
- ☑️ Classly (main app)
- ☑️ ClasslyWidgetExtension

**ContentView.swift, AddClassView.swift, SettingsView.swift** → Add to:
- ☑️ Classly (main app only)

To check/fix targets:
1. Select the file in the Project Navigator
2. Open the File Inspector (⌥⌘1)
3. Check "Target Membership" section

## 📱 Features

### Main App Features:
- **Empty State**: Beautiful welcome screen when no classes exist
- **Add Classes**: Tap the + button to add a new class
- **Edit Classes**: Tap on any class to edit it
- **Delete Classes**: Swipe left on a class to delete
- **Settings**: Tap the gear icon to customize widget background color

### Add/Edit Class Screen:
- Choose from 18 emojis
- Enter class name and room number
- Set start and end times
- Select which days the class occurs

### Settings Screen:
- Choose from 11 background colors for the widget
- Changes apply immediately to the widget

## 🎨 Available Colors:
- Gray (default)
- Blue
- Purple
- Pink
- Red
- Orange
- Yellow
- Green
- Teal
- Indigo
- Black

## 🔄 How It Works

1. When you add/edit/delete a class in the app, it saves to `UserDefaults` in the App Group
2. The `ScheduleManager` automatically calls `WidgetCenter.shared.reloadAllTimelines()`
3. The widget fetches the latest data and updates immediately

## ⚠️ Troubleshooting

### Widget Not Updating?
1. Verify App Groups are set up correctly in BOTH targets
2. Make sure both use the SAME App Group identifier
3. Check that `ScheduleManager.swift` has the correct `appGroupID`
4. Try force-quitting the app and removing/re-adding the widget

### Widget Shows "No Classes"?
1. Make sure you've added classes in the main app
2. Verify the classes are scheduled for today
3. Check that at least one class has a start time in the future

### Build Errors?
1. Make sure `ScheduleManager.swift` is added to both targets
2. Clean build folder (⇧⌘K)
3. Rebuild the project

## 🚀 Next Steps

Your widget is now fully functional! Here are some ideas for enhancements:

- Add support for different widget sizes (medium, large)
- Add notifications for upcoming classes
- Support for custom color picker
- Import schedule from calendar
- Export schedule to share with friends

## 📝 File Structure

```
Classly/
├── ClasslyApp.swift          # App entry point
├── ContentView.swift         # Main schedule list (NEW!)
├── AddClassView.swift        # Add/edit class screen (NEW!)
├── SettingsView.swift        # Settings screen (NEW!)
├── ScheduleManager.swift     # Shared data manager (NEW!)
└── ClasslyWidget/
    └── ClasslyWidget.swift   # Widget implementation (UPDATED!)
```

Enjoy your new Classly widget! 🎉
