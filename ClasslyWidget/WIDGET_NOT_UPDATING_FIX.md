# 🔧 Widget Not Updating - Troubleshooting Guide

## Your Issue: Widget shows "No more classes" even though you have classes

This is almost always caused by **App Groups not being configured correctly**. Here's how to fix it:

---

## ✅ Step-by-Step Fix

### 1. Check if App Groups is Enabled

**In Xcode:**

1. Select your **Classly** project in the Navigator
2. Select the **Classly** target (main app)
3. Go to **Signing & Capabilities** tab
4. Look for **App Groups**
   - ❌ If you DON'T see it → Add it (click **+ Capability** → **App Groups**)
   - ✅ If you DO see it → Continue to step 2

5. Repeat for **ClasslyWidgetExtension** target
   - ❌ If you DON'T see App Groups → Add it
   - ✅ If you DO see it → Continue to step 2

### 2. Create/Select the App Group

**In the main app target (Classly):**

1. In the **App Groups** section, click the **+** button
2. Enter a group identifier like: `group.com.jacobsilva.classly`
   - Replace `jacobsilva` with your name/company
   - Must start with `group.`
   - Use reverse domain notation
3. Click **OK**
4. **Check the box** next to the group to enable it

**In the widget target (ClasslyWidgetExtension):**

1. In the **App Groups** section, you should see the same group appear in the list
2. If not, click **+** and enter the **EXACT SAME** group identifier
3. **Check the box** to enable it

### 3. Update ScheduleManager.swift

1. Open `ScheduleManager.swift`
2. Find line 15:
   ```swift
   private let appGroupID = "group.com.yourcompany.classly"
   ```
3. Replace with YOUR App Group identifier:
   ```swift
   private let appGroupID = "group.com.jacobsilva.classly" // Use YOUR group ID!
   ```

### 4. Verify Everything Matches

**All three of these MUST be EXACTLY the same:**
- ✅ App Group in **Classly** target
- ✅ App Group in **ClasslyWidgetExtension** target  
- ✅ `appGroupID` in **ScheduleManager.swift**

Example (all matching):
```
Classly target:               group.com.jacobsilva.classly ✓
Widget target:                group.com.jacobsilva.classly ✓
ScheduleManager.swift:        group.com.jacobsilva.classly ✓
```

### 5. Clean Build and Test

1. Clean build folder: **Product → Clean Build Folder** (or **⇧⌘K**)
2. Build and run the app
3. Check the Xcode console for messages:
   - ✅ "Saved X schedules to App Group"
   - ✅ "Loaded X schedules from App Group"
   - ❌ "ERROR: Could not access App Group" → App Groups not set up correctly

4. Add a class in the app
5. **Remove and re-add the widget** to your home screen
6. The class should now appear!

---

## 🔍 Check the Console

When you add a class, you should see in Xcode's console:

```
✅ Saved 1 schedules to App Group
✅ Requested widget reload
📊 Widget loaded 1 schedules
  - 🧬 Biology 101: [2, 4, 6]
📅 Today (2026-02-02): 1 classes
⏰ Next class: Biology 101 at 2026-02-02 14:00:00
```

If you see:
```
❌ ERROR: Could not access App Group 'group.com.yourcompany.classly'
❌ Cannot save: App Group not configured
```

→ Your App Groups are NOT set up correctly. Go back to Step 1.

---

## 🐛 Other Possible Issues

### Widget Shows No Classes Even After Fix

**Possible causes:**

1. **The class is not scheduled for today**
   - Check that you selected today's weekday when creating the class
   - Sunday = 1, Monday = 2, etc.

2. **The class time has already passed**
   - The widget only shows FUTURE classes
   - If your class was at 9am and it's now 3pm, it won't show
   - Add a class scheduled for later today to test

3. **Widget cache issue**
   - Remove the widget from home screen
   - Force quit the app (swipe up in app switcher)
   - Re-add the widget

4. **Time zone issues**
   - Make sure your device time is correct
   - Check the console to see what time the widget thinks it is

### Widget Still Not Updating After Everything

Try this **nuclear option**:

1. Delete the app from your device completely
2. In Xcode: **Product → Clean Build Folder** (⇧⌘K)
3. Rebuild and reinstall
4. Set up your schedule again
5. Add the widget

---

## 📋 Quick Checklist

Use this to verify everything:

- [ ] App Groups capability added to **Classly** target
- [ ] App Groups capability added to **ClasslyWidgetExtension** target
- [ ] Both targets use the **EXACT SAME** group identifier
- [ ] The group identifier is **enabled** (checked) in both targets
- [ ] `ScheduleManager.swift` has the correct `appGroupID`
- [ ] `ScheduleManager.swift` is added to **BOTH** targets (check Target Membership)
- [ ] Cleaned build and rebuilt the app
- [ ] Added a class scheduled for **later today**
- [ ] Removed and re-added the widget
- [ ] Console shows "✅ Saved X schedules to App Group"

---

## 🆘 Still Not Working?

If you've tried everything above and it's still not working:

1. **Check the exact error messages** in the console
2. **Screenshot your App Groups settings** in both targets
3. **Verify the `appGroupID`** in ScheduleManager.swift
4. Make sure the class you added is:
   - Scheduled for today (correct weekday)
   - Has a time in the future
   - Has all required fields filled out

---

## 💡 Pro Tip

To quickly test if it's working:

1. Add a class scheduled for **right now** (or 1 minute from now)
2. Make sure today's weekday is selected
3. Save it
4. Check the console for success messages
5. Remove and re-add the widget
6. The class should appear immediately!

---

**The most common issue is forgetting to update the `appGroupID` in ScheduleManager.swift!** Make sure all three places match exactly! 🎯
