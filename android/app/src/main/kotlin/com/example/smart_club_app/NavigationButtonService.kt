package com.example.smart_club_app

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.view.accessibility.AccessibilityEvent

class NavigationButtonService : AccessibilityService() {

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event?.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED ||
            event?.eventType == AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED) {

            val packageName = event.packageName?.toString()
            if (isNavigationButton(packageName)) {
                DialogUtils.showAdminKeyDialog(this) {
                    // Bring app back to the foreground
                    bringAppToForeground()
                }
            }
        }
    }

    override fun onInterrupt() {}

    private fun isNavigationButton(packageName: String?): Boolean {
        return packageName != null && (
                packageName.contains("systemui") || // For general navigation buttons
                        packageName.contains("launcher")  // For home/launcher apps
                )
    }
    private fun bringAppToForeground() {
        val intent = packageManager.getLaunchIntentForPackage(packageName)
        intent?.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }



}