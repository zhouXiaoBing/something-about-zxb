package com.jindanzi.zhishun.utils;

import android.annotation.TargetApi;
import android.graphics.Bitmap;
import android.webkit.WebResourceError;
import android.webkit.WebResourceRequest;
import android.webkit.WebView;
import android.webkit.WebViewClient;

/**
 * 自定义实现WebViewClient类
 */
public class MWebViewClient extends WebViewClient {

    /**
     * 在webview加载URL的时候可以截获这个动作, 这里主要说它的返回值的问题：
     *  1、返回: return true;  webview处理url是根据程序来执行的。
     *  2、返回: return false; webview处理url是在webview内部执行。
     */
    @Override
    public boolean shouldOverrideUrlLoading(WebView view, String url) {

        return false;
    }

    /**
     * 在webview开始加载页面的时候回调该方法
     */
    @Override
    public void onPageStarted(WebView view, String url, Bitmap favicon) {
        super.onPageStarted(view, url, favicon);

    }

    /**
     * 在webview加载页面结束的时候回调该方法
     */
    @Override
    public void onPageFinished(WebView view, String url) {
        super.onPageFinished(view, url);
    }

    /**
     * 加载页面失败的时候回调该方法
     */
    // 该方法为Android23中新添加的API，Android23中会执行该方法
    @TargetApi(21)
    @Override
    public void onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) {

    }

    /**
     * 加载页面失败的时候回调该方法
     */
    /**
     * 在Android23中改方法被onReceivedError(WebView view, WebResourceRequest request, WebResourceError error) 替代
     * 因此在Android23中执行替代方法
     * 在Android23之前执行该方法
     * @param view
     * @param errorCode
     * @param description
     * @param failingUrl
     */
    @Override
    public void onReceivedError(WebView view, int errorCode, String description, String failingUrl) {

    }
}
