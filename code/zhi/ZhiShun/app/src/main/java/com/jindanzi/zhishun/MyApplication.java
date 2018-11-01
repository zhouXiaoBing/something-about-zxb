package com.jindanzi.zhishun;

import android.app.Application;
import android.util.Log;


import org.xutils.x;

/**
 * Created by pengcong on 2017/8/8.
 */

public class MyApplication extends Application {
    public static String APP_NAME = null;
    public static boolean isDebug = false;


    @Override
    public void onCreate() {
        super.onCreate();
        x.Ext.init(this);
        x.Ext.setDebug(false); //输出debug日志，开启会影响性能
        APP_NAME = this.getPackageName();
        Log.i("APP_NAME", APP_NAME);
    }
}
