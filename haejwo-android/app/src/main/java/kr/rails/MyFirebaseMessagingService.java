package kr.rails;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.provider.Settings;
import android.support.v4.app.NotificationCompat;
import android.util.Log;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;



public class MyFirebaseMessagingService extends FirebaseMessagingService {

//    @Override
//    public void handleIntent(Intent intent) {
//        super.handleIntent(intent);
//        if (intent.getExtras() != null)
//        {
//            RemoteMessage.Builder builder = new RemoteMessage.Builder("MyFirebaseMessagingService");
//
//            for (String key : intent.getExtras().keySet())
//            {
//                builder.addData(key, intent.getExtras().get(key).toString());
//            }
//
//            onMessageReceived(builder.build());
//        }
//        else
//        {
//            super.handleIntent(intent);
//        }
//    }

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        if(!Util.getInstance().getIgnorePushFlag()) {

            int icon = Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP ? R.drawable.icon : R.mipmap.icon;

            Intent intent = new Intent(this, MainActivity.class);
            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

            //url 데이터 읽기
            String url = null;
            if(remoteMessage.getData() != null){
                try{
                    //data에 url key에 url value 넣어서 보냈을 경우
                    url = remoteMessage.getData().get("url");
                    intent.putExtra("url", url);
                }catch (Exception e){
                    e.printStackTrace();
                }
            }

            PendingIntent pendingIntent = PendingIntent.getActivity(this, 0 /* Request code */, intent,
                    PendingIntent.FLAG_ONE_SHOT);
            //안드로이드 O 채널 설정 후 노티 수신
            NotificationManager notificationManager =
                    (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                //채널 설정
                NotificationChannel channelMessage = new NotificationChannel("0", "인생코치 알림", android.app.NotificationManager.IMPORTANCE_DEFAULT);
                channelMessage.setDescription("인생코치 앱에서 알려드립니다");
                channelMessage.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);
                notificationManager.createNotificationChannel(channelMessage);

                Notification.Builder notificationBuilder = new Notification.Builder(getBaseContext(), "0")
                        .setSmallIcon(icon)
                        .setContentTitle(getResources().getString(R.string.app_name))
                        .setContentText(remoteMessage.getNotification().getBody())
                        .setAutoCancel(true)
                        .setSound(Settings.System.DEFAULT_NOTIFICATION_URI)
                        .setContentIntent(pendingIntent);

                if (BaseUtil.getBoolPref(getApplicationContext(), "push", true)) {
                    notificationManager.notify(0 /* ID of notification */, notificationBuilder.build());
                    Log.d("PUSHMESSAGE", "yes");
                } else {
                    Log.d("PUSHMESSAGE", "no");
                }
            }else{
                NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this)
                        .setSmallIcon(icon)
                        .setContentTitle(getResources().getString(R.string.app_name))
                        .setContentText(remoteMessage.getNotification().getBody())
                        .setAutoCancel(true)
                        .setSound(Settings.System.DEFAULT_NOTIFICATION_URI)
                        .setContentIntent(pendingIntent);

                if (BaseUtil.getBoolPref(getApplicationContext(), "push", true)) {
                    notificationManager.notify(0 /* ID of notification */, notificationBuilder.build());
                    Log.d("PUSHMESSAGE", "yes");
                } else {
                    Log.d("PUSHMESSAGE", "no");
                }
            }
        }
    }
}
