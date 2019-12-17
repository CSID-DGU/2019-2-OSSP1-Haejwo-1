package kr.rails;

import android.content.Context;
import android.webkit.JavascriptInterface;


public class WebAppInterface {
    Context mContext;

    public WebAppInterface(Context c) {
        mContext = c;
    }

    @SuppressWarnings("unused")
    @JavascriptInterface
    public void setUserId(String userId) {
        MainActivity mainActivity = (MainActivity) mContext;
        mainActivity.setUserId(userId);
    }
}

