package kr.rails;

import java.io.File;
import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.annotation.NonNull;
import android.webkit.ConsoleMessage;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Build;
import android.util.Log;
import android.annotation.TargetApi;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import android.text.TextUtils;
import android.support.v7.app.AlertDialog;
import android.content.DialogInterface;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.InstanceIdResult;
import com.google.firebase.messaging.FirebaseMessaging;


public class MainActivity extends Activity {

    //private Button button;
    private WebView webView;
    final Activity activity = this;
    public Uri imageUri;

    private static final int FILECHOOSER_RESULTCODE   = 2888;
    private ValueCallback<Uri> mUploadMessage;
    public ValueCallback<Uri[]> mFilePathCallback;
    private Uri mCapturedImageURI = null;
    public final static int FILECHOOSER_NORMAL_REQ_CODE = 2001;
    public final static int FILECHOOSER_LOLLIPOP_REQ_CODE = 2002;
    private Uri cameraImageUri = null;
    private String mCameraPhotoPath;
    private static final String TYPE_IMAGE = "image/*";
    public static final int INPUT_FILE_REQUEST_CODE = 1;

    public void setUserId(String userId) {
        final String user_id = userId;
        FirebaseInstanceId.getInstance().getInstanceId()
                .addOnCompleteListener(new OnCompleteListener<InstanceIdResult>() {
                    @Override
                    public void onComplete(@NonNull Task<InstanceIdResult> task) {

                        if(task.isSuccessful()){
                            String token = task.getResult().getToken();
                            String url = getString(R.string.domain) + "/users/" + user_id + "/token?token=" + token + "&device_type=android";
                            if (token != "") {
                                new BaseUtil.GetUrlContentTask().execute(url);
                            }
                        } else{
                            //
                        }
                    }
                });
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Get webview
        webView = (kr.rails.VideoEnabledWebView) findViewById(R.id.webView);


        // Javascript inabled on webview
        webView.getSettings().setJavaScriptEnabled(true);
        webView.getSettings().setSupportMultipleWindows(false);
        webView.getSettings().setJavaScriptCanOpenWindowsAutomatically(false); // 자바스크립트 새창 띄우기(멀티뷰) 허용 여부

        // Other webview options
        webView.getSettings().setLoadWithOverviewMode(true);
        webView.getSettings().setUseWideViewPort(true);

        //Other webview settings
        webView.setScrollBarStyle(WebView.SCROLLBARS_OUTSIDE_OVERLAY);
        webView.setScrollbarFadingEnabled(false);
        webView.getSettings().setBuiltInZoomControls(true);
        webView.getSettings().setDomStorageEnabled(true); // 로컬저장소 허용 여부
        webView.getSettings().setAllowFileAccess(true);
        webView.getSettings().setAllowUniversalAccessFromFileURLs(true);
        webView.getSettings().setSupportZoom(true);
        webView.getSettings().setCacheMode(webView.getSettings().LOAD_NO_CACHE);
        webView.addJavascriptInterface(new WebAppInterface(MainActivity.this), "Android");

        if (!BaseUtil.getBoolPref(this, "pushChecked", false)) {
            BaseUtil.makeAlert(this, "마케팅 수신 동의", "앱 전용 혜택, 실시간 할인 정보 등의 유용한 정보를 받아보시겠습니까", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    BaseUtil.setBoolPref(MainActivity.this, "push", true);
                }
            }, new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialogInterface, int i) {
                    BaseUtil.setBoolPref(MainActivity.this, "push", false);
                }
            }, R.string.yes, R.string.no);
            BaseUtil.setBoolPref(this, "pushChecked", true);
        }

        //Load url in webview
        String url = checkMessage(getIntent());
        if(url == null) {
            webView.loadUrl(getResources().getString(R.string.url));
        }else {
            webView.loadUrl(url);
        }

        checkVerify();

        // Define Webview manage classes
        startWebView();

    }

    private void startWebView() {



        // Create new webview Client to show progress dialog
        // Called When opening a url or click on link
        // You can create external class extends with WebViewClient
        // Taking WebViewClient as inner class

        webView.setWebViewClient(new WebViewClient() {
            ProgressDialog progressDialog;

            //If you will not use this method url links are open in new brower not in webview
            public boolean shouldOverrideUrlLoading(WebView view, String url) {

                // Check if Url contains ExternalLinks string in url
                // then open url in new browser
                // else all webview links will open in webview browser


                // Stay within this webview and load url
                view.loadUrl(url);
                return true;


            }



            //Show loader on url load
            public void onLoadResource (WebView view, String url) {

                // if url contains string androidexample
                // Then show progress  Dialog
                if (progressDialog == null && url.contains("any Text If you want")
                ) {

                    // in standard case YourActivity.this
                    progressDialog = new ProgressDialog(MainActivity.this);
                    progressDialog.setMessage("Loading...");
                    progressDialog.show();
                }
            }

        });


        // You can create external class extends with WebChromeClient
        // Taking WebViewClient as inner class
        // we will define openFileChooser for select file from camera or sdcard

        webView.setWebChromeClient(new WebChromeClient() {

            @Override
            public boolean onJsAlert(WebView view, String url, String message, final android.webkit.JsResult result)
            {
                new AlertDialog.Builder(MainActivity.this)
                        .setTitle("해줘")
                        .setMessage(message)
                        .setPositiveButton(android.R.string.ok,
                                new AlertDialog.OnClickListener()
                                {
                                    public void onClick(DialogInterface dialog, int which)
                                    {
                                        result.confirm();
                                    }
                                })
                        .setCancelable(false)
                        .create()
                        .show();

                return true;
            }

            // For Android Version < 3.0
            public void openFileChooser(ValueCallback<Uri> uploadMsg) {
                //System.out.println("WebViewActivity OS Version : " + Build.VERSION.SDK_INT + "\t openFC(VCU), n=1");
                mUploadMessage = uploadMsg;
                Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
                intent.addCategory(Intent.CATEGORY_OPENABLE);
                intent.setType(TYPE_IMAGE);
                startActivityForResult(intent, INPUT_FILE_REQUEST_CODE);
            }

            // For 3.0 <= Android Version < 4.1
            public void openFileChooser(ValueCallback<Uri> uploadMsg, String acceptType) {
                //System.out.println("WebViewActivity 3<A<4.1, OS Version : " + Build.VERSION.SDK_INT + "\t openFC(VCU,aT), n=2");
                openFileChooser(uploadMsg, acceptType, "");
            }

            // For 4.1 <= Android Version < 5.0
            public void openFileChooser(ValueCallback<Uri> uploadFile, String acceptType, String capture) {
                Log.d(getClass().getName(), "openFileChooser : "+acceptType+"/"+capture);
                mUploadMessage = uploadFile;
                imageChooser();
            }


            // For Android Version 5.0+
            public boolean onShowFileChooser(WebView webView,
                                             ValueCallback<Uri[]> filePathCallback, FileChooserParams fileChooserParams) {
                System.out.println("WebViewActivity A>5, OS Version : " + Build.VERSION.SDK_INT + "\t onSFC(WV,VCUB,FCP), n=3");
                if (mFilePathCallback != null) {
                    mFilePathCallback.onReceiveValue(null);
                }
                mFilePathCallback = filePathCallback;
                imageChooser();
                return true;
            }


            // The webPage has 2 filechoosers and will send a
            // console message informing what action to perform,
            // taking a photo or updating the file

            public boolean onConsoleMessage(ConsoleMessage cm) {

                onConsoleMessage(cm.message(), cm.lineNumber(), cm.sourceId());
                return true;
            }

            public void onConsoleMessage(String message, int lineNumber, String sourceID) {
                //Log.d("androidruntime", "Show console messages, Used for debugging: " + message);

            }
        });   // End setWebChromeClient

    }



// Return here when file selected from camera or from SDcard

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == INPUT_FILE_REQUEST_CODE && resultCode == RESULT_OK) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                if (mFilePathCallback == null) {
                    super.onActivityResult(requestCode, resultCode, data);
                    return;
                }
                Uri[] results = new Uri[]{getResultUri(data)};

                mFilePathCallback.onReceiveValue(results);
                mFilePathCallback = null;
            } else {
                if (mUploadMessage == null) {
                    super.onActivityResult(requestCode, resultCode, data);
                    return;
                }
                Uri result = getResultUri(data);

                Log.d(getClass().getName(), "openFileChooser : "+result);
                mUploadMessage.onReceiveValue(result);
                mUploadMessage = null;
            }
        } else {
            if (mFilePathCallback != null) mFilePathCallback.onReceiveValue(null);
            if (mUploadMessage != null) mUploadMessage.onReceiveValue(null);
            mFilePathCallback = null;
            mUploadMessage = null;
            super.onActivityResult(requestCode, resultCode, data);
        }
    }

// Open previous opened link from history on webview when back button pressed

    @Override
// Detect when the back button is pressed
    public void onBackPressed() {

        if(webView.canGoBack()) {

            webView.goBack();

        } else {
            // Let the system handle the back button
            super.onBackPressed();
        }
    }


    @TargetApi(Build.VERSION_CODES.M)
    public void checkVerify()
    {

        if (    checkSelfPermission(Manifest.permission.INTERNET) != PackageManager.PERMISSION_GRANTED ||
                checkSelfPermission(Manifest.permission.ACCESS_NETWORK_STATE) != PackageManager.PERMISSION_GRANTED ||
                checkSelfPermission(Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED ||
                checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED ||
                checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED
        )
        {
            // Should we show an explanation?
            if (shouldShowRequestPermissionRationale(Manifest.permission.WRITE_EXTERNAL_STORAGE))
            {

            }

            requestPermissions(new String[]{Manifest.permission.INTERNET,Manifest.permission.CAMERA,
                    Manifest.permission.ACCESS_NETWORK_STATE,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE, Manifest.permission.READ_EXTERNAL_STORAGE}, 1);
        }
        else
        {
            //startApp();
        }
    }



    private void imageChooser() {
        Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        if (takePictureIntent.resolveActivity(getPackageManager()) != null) {
            // Create the File where the photo should go
            File photoFile = null;
            try {
                photoFile = createImageFile();
                takePictureIntent.putExtra("PhotoPath", mCameraPhotoPath);
            } catch (IOException ex) {
                // Error occurred while creating the File
                Log.e(getClass().getName(), "Unable to create Image File", ex);
            }

            // Continue only if the File was successfully created
            if (photoFile != null) {
                mCameraPhotoPath = "file:"+photoFile.getAbsolutePath();
                takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT,
                        Uri.fromFile(photoFile));
            } else {
                takePictureIntent = null;
            }
        }

        Intent contentSelectionIntent = new Intent(Intent.ACTION_PICK);
        contentSelectionIntent.setType(MediaStore.Images.Media.CONTENT_TYPE);

        Intent[] intentArray;
        if(takePictureIntent != null) {
            intentArray = new Intent[]{takePictureIntent};
        } else {
            intentArray = new Intent[0];
        }

        String pickTitle = "사진 가져올 방법을 선택하세요.";
        Intent chooserIntent = Intent.createChooser(contentSelectionIntent, pickTitle);

        // 카메라 intent 포함시키기..
        chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS, intentArray);
        startActivityForResult(chooserIntent, INPUT_FILE_REQUEST_CODE);

    }


    private File createImageFile() throws IOException {
        // Create an image file name
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
        String imageFileName = "JPEG_" + timeStamp + "_";
        File storageDir = Environment.getExternalStoragePublicDirectory(
                Environment.DIRECTORY_PICTURES);
        File imageFile = File.createTempFile(
                imageFileName,  /* prefix */
                ".jpg",         /* suffix */
                storageDir      /* directory */
        );
        return imageFile;
    }

    private Uri getResultUri(Intent data) {
        Uri result = null;
        if(data == null || TextUtils.isEmpty(data.getDataString())) {
            // If there is not data, then we may have taken a photo
            if(mCameraPhotoPath != null) {
                result = Uri.parse(mCameraPhotoPath);
            }
        } else {
            String filePath = "";
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                filePath = data.getDataString();
            } else {
                filePath = "file:" + RealPathUtil.getRealPath(this, data.getData());
            }
            result = Uri.parse(filePath);
        }

        return result;
    }

    private String checkMessage(Intent intent) {
        String url = null;
        if(intent != null){
            Bundle bundle = intent.getExtras();
            if(bundle != null){
                url = bundle.getString("url");
            }
        }
        return url;
    }

}