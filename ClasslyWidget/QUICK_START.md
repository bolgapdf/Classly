# 🚀 Quick Start Guide

## ⚡ 5-Minute Setup

### 1️⃣ Set Up App Groups (2 minutes)

**Main App Target:**
- Signing & Capabilities → + Capability → App Groups
- Create: `group.com.yourcompany.classly`
- ✅ Enable it

**Widget Target:**
- Signing & Capabilities → + Capability → App Groups  
- Select the SAME group identifier
- ✅ Enable it

### 2️⃣ Update Code (30 seconds)

Open `ScheduleManager.swift` → Line 14:
```swift
private let appGroupID = "group.com.yourcompany.classly" // Use YOUR identifier
```

### 3️⃣ Verify Targets (1 minute)

**ScheduleManager.swift** → Target Membership:
- ✅ Classly
- ✅ ClasslyWidgetExtension

**ColorHelper.swift** → Target Membership:
- ✅ Classly
- ✅ ClasslyWidgetExtension

**ContentView.swift, AddClassView.swift, SettingsView.swift** → Target Membership:
- ✅ Classly ONLY

### 4️⃣ Build & Test (1 minute)

1. Build and run (⌘R)
2. Add a class
3. Add widget to home screen
4. See your schedule! 🎉

---

## 📱 Using the App

| Action | How To |
|--------|--------|
| **Add Class** | Tap + button |
| **Edit Class** | Tap on class |
| **Delete Class** | Swipe left |
| **Change Color** | Tap gear icon → Choose color |
| **Add Widget** | Long press home screen → + → Classly |

---

## 🎨 Customization

**Emojis Available:** 18 options
**Colors Available:** 11 options
**Widget Updates:** Automatic

---

## ✅ Checklist

- [ ] App Groups enabled in both targets
- [ ] Same group ID in both targets
- [ ] ScheduleManager.swift updated with your group ID
- [ ] ScheduleManager.swift in both targets
- [ ] App builds successfully
- [ ] Can add a class
- [ ] Widget shows the class
- [ ] Can change background color

---

## 🆘 Help

**Widget shows nothing?**
→ Check App Groups setup

**Build error?**
→ Check target membership

**Need more help?**
→ See SETUP_GUIDE.md

---

## 🎯 That's It!

You now have a fully functional class schedule widget!

**Add your schedule → Widget updates automatically** ✨
