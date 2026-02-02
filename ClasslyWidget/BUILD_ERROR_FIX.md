# 🔧 Build Error Fix - ClassSchedule Duplicate

## The Problem
You're getting "Invalid redeclaration of ClassSchedule" because the struct was defined in multiple places.

## The Solution
I've created a new shared file `ClassSchedule.swift` that both targets can use.

---

## ✅ Steps to Fix:

### 1️⃣ Add ClassSchedule.swift to BOTH Targets

The new file `ClassSchedule.swift` needs to be in BOTH targets:

1. **Find the file** in Project Navigator (left sidebar)
2. **Click on ClassSchedule.swift**
3. Open the **File Inspector** (right sidebar, or press ⌥⌘1)
4. Look for **Target Membership** section
5. Make sure BOTH are checked:
   - ✅ **Classly**
   - ✅ **ClasslyWidgetExtension**

### 2️⃣ Verify Other Shared Files

These files should ALSO be in both targets:

**ScheduleManager.swift** → Target Membership:
- ✅ Classly
- ✅ ClasslyWidgetExtension

**ColorHelper.swift** → Target Membership:
- ✅ Classly
- ✅ ClasslyWidgetExtension

**ClassSchedule.swift** → Target Membership:
- ✅ Classly
- ✅ ClasslyWidgetExtension

### 3️⃣ Clean and Build

1. **Clean Build Folder**: Product → Clean Build Folder (⇧⌘K)
2. **Build**: Product → Build (⌘B)

---

## 📋 File Structure (Should Be):

```
Shared Files (BOTH targets):
├── ClassSchedule.swift       ✅ App + Widget
├── ScheduleManager.swift     ✅ App + Widget
└── ColorHelper.swift         ✅ App + Widget

App Only Files (Classly target):
├── ClasslyApp.swift          ✅ App only
├── ContentView.swift         ✅ App only
├── AddClassView.swift        ✅ App only
└── SettingsView.swift        ✅ App only

Widget Only Files (Widget target):
├── ClasslyWidget.swift       ✅ Widget only
└── AppIntent.swift           ✅ Widget only
```

---

## 🔍 How to Check Target Membership:

### Method 1: File Inspector
1. Click on the file in Project Navigator
2. Press ⌥⌘1 to open File Inspector
3. Scroll to "Target Membership"
4. Check the boxes for the targets you need

### Method 2: Target Settings
1. Select your project in Project Navigator
2. Select the **Classly** target
3. Go to **Build Phases** tab
4. Expand **Compile Sources**
5. You should see:
   - ClassSchedule.swift
   - ScheduleManager.swift
   - ColorHelper.swift
   - ContentView.swift
   - AddClassView.swift
   - SettingsView.swift
   - ClasslyApp.swift

6. Select the **ClasslyWidgetExtension** target
7. Go to **Build Phases** tab
8. Expand **Compile Sources**
9. You should see:
   - ClassSchedule.swift
   - ScheduleManager.swift
   - ColorHelper.swift
   - ClasslyWidget.swift
   - AppIntent.swift

---

## ⚠️ Common Mistakes:

❌ **ClassSchedule.swift only in main app**
   → Widget can't see the struct

❌ **ScheduleManager.swift only in main app**
   → Widget can't access data

❌ **UI files (ContentView, AddClassView) in widget target**
   → Unnecessary and can cause conflicts

---

## ✅ Quick Test:

After fixing target membership:

1. Clean build (⇧⌘K)
2. Build (⌘B)
3. Should build successfully! ✨
4. Run the app
5. Add a class
6. Check console for: "✅ Saved 1 schedules to App Group"

---

**The key is making sure shared data files are in BOTH targets, but UI files are only in the app target!** 🎯
