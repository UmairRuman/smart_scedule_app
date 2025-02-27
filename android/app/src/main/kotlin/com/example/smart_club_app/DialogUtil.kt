package com.example.smart_club_app

import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.text.InputType
import android.widget.EditText
import android.widget.Toast

object DialogUtils {

    fun showAdminKeyDialog(
        context: Context,
        onKeyValid: () -> Unit
    ) {
        val dialogBuilder = AlertDialog.Builder(context)
        dialogBuilder.setTitle("Admin Key Required")
        dialogBuilder.setMessage("Enter the admin key to perform this action.")

        val input = EditText(context)
        input.inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD
        dialogBuilder.setView(input)

        dialogBuilder.setPositiveButton("Submit") { dialog, _ ->
            val enteredKey = input.text.toString()
            if (isAdminKeyValid(enteredKey)) {
                onKeyValid()
            } else {
                Toast.makeText(context, "Invalid Admin Key", Toast.LENGTH_SHORT).show()
            }
            dialog.dismiss()
        }

        dialogBuilder.setNegativeButton("Cancel") { dialog, _ ->
            dialog.dismiss()
        }

        dialogBuilder.show()
    }

    private fun isAdminKeyValid(key: String): Boolean {
        val adminKey = "12345" // Replace with your actual admin key
        return key == adminKey
    }

    fun bringAppToForeground(context: Context) {
        val intent = context.packageManager.getLaunchIntentForPackage(context.packageName)
        intent?.flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        context.startActivity(intent)
    }
}