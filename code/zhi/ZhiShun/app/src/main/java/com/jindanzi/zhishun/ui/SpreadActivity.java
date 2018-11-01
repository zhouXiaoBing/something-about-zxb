package com.jindanzi.zhishun.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.app.Activity;
import android.os.Handler;
import android.view.View;
import android.widget.LinearLayout;

import com.jindanzi.zhishun.R;
import com.jindanzi.zhishun.base.BaseActivity;

import java.util.Timer;
import java.util.TimerTask;


public class SpreadActivity extends BaseActivity {

    @Override
    public void widgetClick(View v) {

    }

    @Override
    public void initParms(Bundle parms) {
        setAllowFullScreen(false);
        setSteepStatusBar(false);
    }

    @Override
    public View bindView() {
        return null;
    }

    @Override
    public int bindLayout() {
        return R.layout.activity_spread;
    }

    @Override
    public void initView(View view) {

    }

    @Override
    public void setListener() {

    }

    @Override
    public void doBusiness(Context mContext) {
        /*final LinearLayout layout = (LinearLayout) findViewById(R.id.index);
        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                layout.setBackgroundResource(R.mipmap.kaiping2);
            }
        },1000);*/
        final Intent it = new Intent(this, MainActivity.class); //你要转向的Activity
        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                startActivity(it); //执行
                finish();
            }
        };
        timer.schedule(task, 2000 * 1); //10秒后


    }



}
