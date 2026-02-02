# 📚 Classly - Class Schedule Widget

A beautiful, functional iOS widget for managing your class schedule right from your home screen!

## ✨ Features

### 📱 Main App
- **Add Classes**: Create classes with custom emojis, times, and room numbers
- **Edit & Delete**: Tap to edit, swipe to delete
- **Day Selection**: Choose which days each class occurs
- **Beautiful UI**: Clean, modern interface with empty states

### 🎨 Customization
- **18 Emoji Options**: Choose from a variety of emojis to represent each class
- **11 Background Colors**: Customize your widget's appearance
- **Instant Sync**: Changes appear in the widget immediately

### 📊 Widget Display
- **Next Class**: Shows your upcoming class at a glance
- **Time Range**: Clear start and end times
- **Room Number**: Location info with icon
- **Remaining Classes**: Counts how many classes you have left today
- **Smart Status**: Shows "No more classes!" when you're done for the day

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 17.0+
- An Apple Developer account (for App Groups)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/classly.git
   cd classly
   ```

2. **Open in Xcode**
   ```bash
   open Classly.xcodeproj
   ```

3. **Set up App Groups** (REQUIRED!)
   - See [APP_GROUPS_SETUP.md](APP_GROUPS_SETUP.md) for detailed instructions
   - Add App Groups capability to both targets
   - Use the same group identifier: `group.com.yourcompany.classly`
   - Update `ScheduleManager.swift` with your group identifier

4. **Configure Target Membership**
   - Ensure `ScheduleManager.swift` is added to BOTH targets
   - Ensure UI files are only in the main app target

5. **Build and Run**
   - Select your device or simulator
   - Build and run the app (⌘R)
   - Add some classes
   - Add the widget to your home screen!

## 📖 Documentation

- **[SETUP_GUIDE.md](SETUP_GUIDE.md)** - Complete setup instructions and troubleshooting
- **[APP_GROUPS_SETUP.md](APP_GROUPS_SETUP.md)** - Detailed App Groups configuration
- **[IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)** - Full implementation details

## 🎯 Usage

### Adding a Class

1. Open the Classly app
2. Tap the **+** button in the top right
3. Select an emoji for your class
4. Enter the class name (e.g., "Biology 101")
5. Enter the room number (e.g., "Room 204")
6. Set start and end times
7. Select the days this class occurs
8. Tap **Save**

### Editing a Class

1. Tap on any class in the list
2. Modify the details
3. Tap **Save**

### Deleting a Class

1. Swipe left on a class
2. Tap **Delete**

### Customizing Widget

1. Tap the **gear icon** in the top left
2. Choose a background color
3. The widget updates immediately!

### Adding the Widget

1. Long-press on your home screen
2. Tap the **+** button
3. Search for "Classly"
4. Select the small widget size
5. Tap **Add Widget**

## 🏗️ Architecture

```
Classly/
├── App/
│   ├── ClasslyApp.swift          # App entry point
│   ├── ContentView.swift         # Main schedule list
│   ├── AddClassView.swift        # Add/edit class form
│   └── SettingsView.swift        # Customization settings
├── Shared/
│   ├── ScheduleManager.swift     # Data persistence & sync
│   ├── ColorHelper.swift         # Color utilities
│   └── ClassSchedule.swift       # Data model (in ClasslyWidget.swift)
└── Widget/
    └── ClasslyWidget.swift       # Widget implementation
```

## 🔧 Technologies

- **SwiftUI** - Modern, declarative UI framework
- **WidgetKit** - For home screen widgets
- **App Groups** - For data sharing between app and widget
- **UserDefaults** - For persistent storage
- **Codable** - For data serialization

## 🎨 Color Options

The widget supports these background colors:
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

## 📚 Emoji Options

Choose from 18 emojis:
📚 🧬 ➗ 📖 🧪 🎨 🎵 ⚽️ 💻 🌍 📐 ✏️ 🔬 🎭 📱 🏃 🎤 📝

## 🐛 Troubleshooting

### Widget not updating?
- Verify App Groups are configured correctly
- Make sure both targets use the SAME group identifier
- Try removing and re-adding the widget
- Force quit the app

### "Cannot find ScheduleManager"?
- Check that `ScheduleManager.swift` is added to the widget target
- Clean build folder (⇧⌘K) and rebuild

### Build errors?
- Verify target membership for all files
- Ensure UI files are NOT in the widget target
- Check that App Groups are enabled

See [SETUP_GUIDE.md](SETUP_GUIDE.md) for more troubleshooting.

## 🚧 Future Enhancements

- [ ] Medium and large widget sizes
- [ ] Multiple schedules (A/B day support)
- [ ] Notifications for upcoming classes
- [ ] Import from calendar
- [ ] Dark mode customization
- [ ] Export/share schedule
- [ ] Widget configuration options
- [ ] Class color coding
- [ ] Study timer integration
- [ ] Assignment tracking

## 📄 License

This project is available for personal and educational use.

## 👨‍💻 Author

Created by Jacob Silva

## 🙏 Acknowledgments

- SwiftUI community for inspiration
- Apple's WidgetKit documentation
- Beta testers and early users

---

**Made with ❤️ for students everywhere**

If you find this useful, consider sharing it with your classmates! 🎓
