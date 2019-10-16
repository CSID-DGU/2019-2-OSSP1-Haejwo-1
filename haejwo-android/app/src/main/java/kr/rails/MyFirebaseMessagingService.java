package kr.rails;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.media.AudioAttributes;
import android.media.RingtoneManager;
import android.os.Build;
import android.provider.Settings;
import android.support.v4.app.NotificationCompat;
import android.text.TextUtils;
import android.util.Log;
import android.net.Uri;
import kr.rails.MainActivity;

import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.iid.FirebaseInstanceId;
import com.google.firebase.iid.InstanceIdResult;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import java.util.Map;
import java.util.Random;

import kr.rails.R;


public class MyFirebaseMessagingService extends FirebaseMessagingService {
    public static int NOTIFICATION_ID = 1;
    @Override
    public void onNewToken(String token) {
        super.onNewToken(token);
        Log.e("NEW_TOKEN", token);
    }

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);

        if(remoteMessage.getData().isEmpty())
            showNotification(remoteMessage.getNotification().getTitle(), remoteMessage.getNotification().getBody());
        else
            showNotification(remoteMessage.getData());
    }

    private void showNotification(Map<String, String> data) {

        String title = data.get("title").toString();
        String body = data.get("body").toString();

        NotificationManager notificationManager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);
        String NOTIFICATION_CHANNEL_ID = "kr.rails";

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
        {
            NotificationChannel notificationChannel = new NotificationChannel(NOTIFICATION_CHANNEL_ID, "Notification",
                    NotificationManager.IMPORTANCE_DEFAULT);

            notificationChannel.setDescription("해줘 알림");
            notificationChannel.enableLights(true);
            notificationChannel.setLightColor(Color.BLUE);
            notificationChannel.setVibrationPattern(new long[]{0,1000,500,1000});
            notificationChannel.enableLights(true);
            notificationManager.createNotificationChannel(notificationChannel);
        }

        NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID);

        notificationBuilder.setAutoCancel(true)
                .setDefaults(Notification.DEFAULT_ALL)
                .setWhen(System.currentTimeMillis())
                .setSmallIcon(R.drawable.ic_launcher_background)
                .setContentTitle(title)
                .setContentText(body)
                .setContentInfo("Info");

        notificationManager.notify(new Random().nextInt(), notificationBuilder.build());
    }

    private void showNotification(String title, String body) {
        NotificationManager notificationManager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);
        String NOTIFICATION_CHANNEL_ID = "kr.rails";

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O)
        {
            NotificationChannel notificationChannel = new NotificationChannel(NOTIFICATION_CHANNEL_ID, "Notification",
                    NotificationManager.IMPORTANCE_DEFAULT);

            notificationChannel.setDescription("해줘 알림");
            notificationChannel.enableLights(true);
            notificationChannel.setLightColor(Color.BLUE);
            notificationChannel.setVibrationPattern(new long[]{0,1000,500,1000});
            notificationChannel.enableLights(true);
            notificationManager.createNotificationChannel(notificationChannel);
        }

        NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this, NOTIFICATION_CHANNEL_ID);

        notificationBuilder.setAutoCancel(true)
                .setDefaults(Notification.DEFAULT_ALL)
                .setWhen(System.currentTimeMillis())
                .setSmallIcon(R.drawable.ic_launcher_background)
                .setContentTitle(title)
                .setContentText(body)
                .setContentInfo("Info");

        notificationManager.notify(new Random().nextInt(), notificationBuilder.build());

    }

    private void generateNotification(String body, String title) {
        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intent,
                PendingIntent.FLAG_ONE_SHOT);

        Uri soundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);

        NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle(title)
            .setContentText(body)
            .setAutoCancel(true)
            .setSound(soundUri)
            .setContentIntent(pendingIntent);

        NotificationManager notificationManager = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);

        if(NOTIFICATION_ID > 1073741824) {
            NOTIFICATION_ID = 0;
        }

        notificationManager.notify(NOTIFICATION_ID++, notificationBuilder.build());


    }

//        Log.d("PUSHMESSAGE", "received");
//        if(!Util.getInstance().getIgnorePushFlag()) {
//
//            int icon = Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP ? R.drawable.icon : R.mipmap.icon;
//
//            Intent intent = new Intent(this, MainActivity.class);
//            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//
//            //url 데이터 읽기
//            String url = null;
//            if(remoteMessage.getData() != null){
//                try{
//                    //data에 url key에 url value 넣어서 보냈을 경우
//                    url = remoteMessage.getData().get("url");
//                    intent.putExtra("url", url);
//                }catch (Exception e){
//                    e.printStackTrace();
//                }
//            }
//
//            String CHANNEL_ID = "0";
//            String CHANNEL_NOTI_NAME = "해줘 알림";
//
//            Uri soundUri = Uri.parse(ContentResolver.SCHEME_ANDROID_RESOURCE + "://"+ getApplicationContext().getPackageName() + "/" + R.raw.mysound);
//            NotificationManager mNotificationManager = (NotificationManager) getApplicationContext().getSystemService(Context.NOTIFICATION_SERVICE);
//            NotificationChannel mChannel;
//            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//                mChannel = new NotificationChannel(CHANNEL_ID, CHANNEL_NOTI_NAME, NotificationManager.IMPORTANCE_HIGH);
//                mChannel.setLightColor(Color.GRAY);
//                mChannel.enableLights(true);
//                mChannel.setDescription("해줘에서 알려드립니다.");
//                AudioAttributes audioAttributes = new AudioAttributes.Builder()
//                        .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
//                        .setUsage(AudioAttributes.USAGE_NOTIFICATION)
//                        .build();
//                mChannel.setSound(soundUri, audioAttributes);
//
//                if (mNotificationManager != null) {
//                    mNotificationManager.createNotificationChannel( mChannel );
//                }
//            }
//
//            NotificationCompat.Builder mBuilder = new NotificationCompat.Builder(this, CHANNEL_ID)
//                    .setSmallIcon(icon)
//                    .setLargeIcon(BitmapFactory.decodeResource(getApplicationContext().getResources(), icon))
//                    .setTicker("해줘")
//                    .setContentTitle(getResources().getString(R.string.app_name))
//                    .setContentText(remoteMessage.getNotification().getBody())
//                    .setAutoCancel(true)
//                    .setLights(0xff0000ff, 300, 1000) // blue color
//                    .setWhen(System.currentTimeMillis())
//                    .setPriority(NotificationCompat.PRIORITY_DEFAULT);
//
//            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O) {
//                mBuilder.setSound(soundUri);
//            }
//
//            int NOTIFICATION_ID = 1; // Causes to update the same notification over and over again.
//            if (mNotificationManager != null) {
//                mNotificationManager.notify(NOTIFICATION_ID, mBuilder.build());
//            }
//        }
//    }
}
