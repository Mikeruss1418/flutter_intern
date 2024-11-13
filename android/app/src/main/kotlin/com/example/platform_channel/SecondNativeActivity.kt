package com.example.platform_channel
import android.app.AlertDialog
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity

class SecondNativeActivity:AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native_1)
        val message = intent.getStringExtra("msg")?:"No Message Found"
        showAlertDialog(message)
        val textView = findViewById<TextView>(R.id.secondText)
        textView.text = message+" Rojesh"

    }
    private fun showAlertDialog(message: String) {
        AlertDialog.Builder(this).setTitle("Message from flutter 2").setMessage(message) .setPositiveButton("OK") { dialog, _ ->
            dialog.dismiss()
         }.show()
    }
}
