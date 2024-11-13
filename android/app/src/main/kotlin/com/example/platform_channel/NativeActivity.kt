//package com.example.platform_channel
//import android.app.AlertDialog
//import android.os.Bundle
//import androidx.appcompat.app.AppCompatActivity
//
//class NativeActivity : AppCompatActivity() {
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_native)
//
////       val textView = findViewById(R.id.textView)
////        textView.text = "Welcome to the Native Screen A"
////        val textView1= findViewById(R.id.textView1)
////        textView1.text="welcome to the native screen the original text is native screen 1"
//
//    }
//}
package com.example.platform_channel
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity

class NativeActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native)

        val message = intent.getStringExtra("msg") ?: "No message received"

        // Show an AlertDialog with the received message
        showAlertDialog(message)

        // Or set the message to a TextView
        val textView = findViewById<TextView>(R.id.textView1)
        textView.text = message+" Rojesh"
    }

    private fun showAlertDialog(message: String) {
        AlertDialog.Builder(this)
            .setTitle("Message from Flutter")
            .setMessage(message)
            .setPositiveButton("OK") { dialog, _ ->
                dialog.dismiss()
            }
            .show()
    }
}
