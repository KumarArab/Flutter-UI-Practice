package com.example.testapp

import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.provider.Settings
import androidx.annotation.DrawableRes
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.ByteArrayOutputStream


class MainActivity: FlutterActivity() {

    private val CHANNEL = "methodChannel/deviceData"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // This method is invoked on the main thread.
            call, result ->
            if (call.method == "getInstalledApps") {
              val installedAppsList = getInstalledApplications()
              if (installedAppsList.size != 0) {
                result.success(installedAppsList)
              } else {
                result.error("UNAVAILABLE", "Installed Apps information not available", null)
              }
            }
            else if(call.method == "getDeviceId"){
              val id: String = getUniqueDeviceId(context)
                result.success(id)
            }
            else {
              result.notImplemented()
            }
          }
      }

     @SuppressLint("QueryPermissionsNeeded")
     private fun getInstalledApplications(): ArrayList<HashMap<String,Any?>> {
      try {
        val packageManager = context.packageManager
        val installedApps = packageManager.getInstalledApplications(PackageManager.GET_META_DATA)
        val userApps = installedApps.filter {
            (it.flags and ApplicationInfo.FLAG_SYSTEM) != ApplicationInfo.FLAG_SYSTEM
        }
        val apps: ArrayList<HashMap<String,Any?>>  = ArrayList()
        for (app in userApps) {
           val appName =  app.loadLabel(packageManager).toString()
            val appData : HashMap<String, Any?>
           = HashMap<String, Any?> ()
            appData["package_name"] = app.packageName
            appData["app_name"] = appName
            val iconData = getDrawableFromRes(context,app.loadIcon(packageManager))
            if(iconData != null){
                appData["icon"] = iconData
            }
            apps.add(appData)
        }
        return apps;
    } catch (e: Exception) {
        println("Failed to query packages with error $e")
        return ArrayList()
    }
     }


    @SuppressLint("HardwareIds")
    fun getUniqueDeviceId(context: Context): String {
        return Settings.Secure.getString(context.contentResolver, Settings.Secure.ANDROID_ID)
    }

    /**
     * @param ctx the context
     * @param res the resource id
     * @return the byte[] data of the fiven drawable identified with the resId
     */
    private fun getDrawableFromRes(ctx: Context, res: Drawable?): ByteArray? {
        return if(res == null){
            null
        } else{
            val bmp:Bitmap = Bitmap.createBitmap(res.intrinsicWidth, res.intrinsicHeight, Bitmap.Config.ARGB_8888);
            val canvas: Canvas = Canvas(bmp);
            res.setBounds(0, 0, canvas.width, canvas.height);
            res.draw(canvas);
            val stream = ByteArrayOutputStream()
            bmp.compress(Bitmap.CompressFormat.JPEG, 100, stream)
            stream.toByteArray()
        }

    }


}
