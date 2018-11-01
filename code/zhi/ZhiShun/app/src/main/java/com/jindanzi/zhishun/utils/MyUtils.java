package com.jindanzi.zhishun.utils;

import android.util.Log;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by PENGCONG on 2017/10/12.
 */

public class MyUtils {


    /**
     * @param code 事件id
     * @param map  参数
     * @return 请求参数
     */
    public static Map<String, String> setParams(String code, Map map) {
        Map<String, String> params = new HashMap<String, String>();
        Map<String, String> param = new HashMap<String, String>();
        param.put("code", code);
        if (!map.isEmpty()) {
            JSONObject mapjson = new JSONObject(map);
            param.put("params", mapjson.toString());
        }
        JSONObject paramsjson = new JSONObject(param);
        params.put("params", paramsjson.toString());
        Log.i("params", params.toString());
        return params;
    }

}
