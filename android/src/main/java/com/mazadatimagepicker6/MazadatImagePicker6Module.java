package com.mazadatimagepicker6;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.util.Log;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.module.annotations.ReactModule;
import com.mazadatimagepicker6.Camera.MazadatCamera;
import com.mazadatimagepicker6.EditPhoto.MazadatEditPhoto;
import com.mazadatimagepicker6.Gallery.GalleryActivity;

@ReactModule(name = MazadatImagePicker6Module.NAME)
public class MazadatImagePicker6Module extends ReactContextBaseJavaModule {
  Promise promise;
  public static final String NAME = "MazadatImagePicker6";

  BroadcastReceiver receiver=new BroadcastReceiver() {
    @Override
    public void onReceive(Context context, Intent intent) {
      Log.i("datadata_path2",intent.getExtras().getString("path"));
      promise.resolve(intent.getExtras().getString("path"));
    }
  };

  public MazadatImagePicker6Module(ReactApplicationContext reactContext) {
    super(reactContext);
  }

  @Override
  @NonNull
  public String getName() {
    return NAME;
  }


  // Example method
  // See https://reactnative.dev/docs/native-modules-android
  @ReactMethod
  public void multiply(double a, double b, Promise promise) {
    promise.resolve(a * b);
  }

  @ReactMethod
  public void openCamera(String title, int AspectRatioX, int AspectRatioY, Promise promise){
    Intent intent=new Intent(getCurrentActivity(), MazadatCamera.class);
    intent.putExtra("Title",title);
    intent.putExtra("AspectRatioX",AspectRatioX);
    intent.putExtra("AspectRatioY",AspectRatioY);

    getCurrentActivity().startActivity(intent);
    this.promise=promise;
    IntentFilter filter=new IntentFilter();
    filter.addAction("data");
    getCurrentActivity().registerReceiver(receiver,filter);

  }

  @ReactMethod
  public void openGallery(String title,int AspectRatioX,int AspectRatioY,Promise promise){
    Intent intent=new Intent(getCurrentActivity(), GalleryActivity.class);
    intent.putExtra("Title",title);
    intent.putExtra("AspectRatioX",AspectRatioX);
    intent.putExtra("AspectRatioY",AspectRatioY);

    getCurrentActivity().startActivity(intent);
    this.promise=promise;
    IntentFilter filter=new IntentFilter();
    filter.addAction("data");
    getCurrentActivity().registerReceiver(receiver,filter);

  }

  @ReactMethod
  public void editPhoto(String title,String path,int AspectRatioX,int AspectRatioY,Promise promise){
    Intent intent=new Intent(getCurrentActivity(), MazadatEditPhoto.class);
    intent.putExtra("path",path);
    intent.putExtra("Title",title);
    intent.putExtra("AspectRatioX",AspectRatioX);
    intent.putExtra("AspectRatioY",AspectRatioY);
    intent.putExtra("from","camera");

    getCurrentActivity().startActivity(intent);
    this.promise=promise;
    IntentFilter filter=new IntentFilter();
    filter.addAction("data");
    getCurrentActivity().registerReceiver(receiver,filter);



  }
}
