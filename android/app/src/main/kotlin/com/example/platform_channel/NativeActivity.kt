//package com.example.platform_channel
//import android.app.AlertDialog
package com.example.platform_channel
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity

class NativeActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native)

        val message = intent.getStringExtra("msg") ?: "No message received"
        val REQUEST_CODE_COMEBACK =202;

        // Show an AlertDialog with the received message
        showAlertDialog(message)

        // Or set the message to a TextView
        val textView = findViewById<TextView>(R.id.textView1)
        textView.text = message+" Rojesh"



        val edittext = findViewById<EditText>(R.id.editText)
        val navigatebtn = findViewById<Button>(R.id.nextScreen)
        val goBack = findViewById<Button>(R.id.goBack)


        navigatebtn.setOnClickListener {
            val text = edittext.text.toString()
            val intent = Intent(this,SecondNativeActivity::class.java)
            intent.putExtra("edit_message",text)
//            startActivityForResult(intent,REQUEST_CODE_COMEBACK)
            startActivity(intent)
        }

        goBack.setOnClickListener {
            val editValue = edittext.text.toString()
            val editValueIntent = Intent()
            editValueIntent.putExtra("returned_data",editValue)
            setResult(RESULT_OK,editValueIntent)
            finish()
        }

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

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        val getdata = data?.getStringExtra("returned_to")?:"No Data from Second Screen"
        val comebacktext = findViewById<TextView>(R.id.comeback)
        comebacktext.text = getdata
    }

}
