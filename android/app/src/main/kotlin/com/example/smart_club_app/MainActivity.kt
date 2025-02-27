package com.example.smart_club_app

import android.app.AlertDialog
import android.app.admin.DevicePolicyManager
import android.content.ComponentName
import android.content.Context
import android.os.Bundle
import android.text.InputType
import android.view.View
import android.view.accessibility.AccessibilityEvent
import android.widget.EditText
import android.widget.Toast
import com.example.smart_club_app.DialogUtils.bringAppToForeground
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Enable Kiosk Mode
        enableKioskMode()

        // Enable Immersive Mode
        enableImmersiveMode()
    }

    private fun enableKioskMode() {
        val devicePolicyManager = getSystemService(Context.DEVICE_POLICY_SERVICE) as DevicePolicyManager
        val componentName = ComponentName(this, MyDeviceAdminReceiver::class.java)

        if (devicePolicyManager.isDeviceOwnerApp(packageName)) {
            // Set the app as a lock task package
            devicePolicyManager.setLockTaskPackages(componentName, arrayOf(packageName))
            startLockTask() // Enter Kiosk Mode
        } else {
            Toast.makeText(
                this,
                "App is not set as Device Owner. Kiosk mode cannot be enabled.",
                Toast.LENGTH_LONG
            ).show()
        }
    }

    private fun enableImmersiveMode() {
        window.decorView.systemUiVisibility = (
                View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                        or View.SYSTEM_UI_FLAG_FULLSCREEN
                        or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                        or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                        or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                )
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            // Reapply immersive mode if the focus is regained
            enableImmersiveMode()
        }
    }

    override fun onBackPressed() {
        DialogUtils.showAdminKeyDialog(this) {
            // Perform back button functionality only if admin key is correct
            super.onBackPressed()
        }
    }




}


