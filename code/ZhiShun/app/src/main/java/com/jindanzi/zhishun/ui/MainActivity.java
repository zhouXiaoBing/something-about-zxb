package com.jindanzi.zhishun.ui;

import android.annotation.TargetApi;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.graphics.Bitmap;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.IBinder;
import android.support.v4.content.LocalBroadcastManager;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.Toast;

import com.jindanzi.zhishun.R;
import com.jindanzi.zhishun.base.BaseActivity;
import com.jindanzi.zhishun.constant.Config;
import com.jindanzi.zhishun.service.UartService;
import com.jindanzi.zhishun.utils.MWebChromeClient;
import com.jindanzi.zhishun.utils.MWebViewClient;

import java.text.DateFormat;
import java.util.Date;

public class MainActivity extends BaseActivity {

    public static WebView mWebView;

    private static final int UART_PROFILE_CONNECTED = 20;
    private static final int UART_PROFILE_DISCONNECTED = 21;
    private int mState = UART_PROFILE_DISCONNECTED;
    private UartService mService = null;

    private String memberbid = null;

    private ValueCallback<Uri> mUploadMessage;
    public ValueCallback<Uri[]> uploadMessage;
    public static final int REQUEST_SELECT_FILE = 100;
    private final static int FILECHOOSER_RESULTCODE = 2;

    /**
     * 这个是要修改的集合
     */
    double[][] ADCMap = new double[][]{
           /* {7000, 	60   },
            {6967, 	61.5 },
            {6934, 	63   },
            {6901, 	64.5 },
            {6868, 	66   },
            {6835, 	67.5 },
            {6802, 	69   },
            {6769, 	70.5 },
            {6736, 	72   },
            {6703, 	73.5 },
            {6670, 	75   },
            {6637, 	76.5 },
            {6604, 	78   },
            {6571, 	79.5 },
            {6538, 	81   },
            {6505, 	82.5 },
            {6472, 	84   },
            {6439, 	85.5 },
            {6406, 	87   },
            {6373, 	88.5 },
            {6340, 	90   },
            {6307, 	91.5 },
            {6274, 	93   },
            {6241, 	94.5 },
            {6208, 	96   },
            {6175, 	97.5 },
            {6142, 	99   },
            {6109, 	100.5},
            {6076, 	102  },
            {6043, 	103.5},
            {6010, 	105  },
            {5977, 	106.5},
            {5944, 	108  },
            {5911, 	109.5},
            {5878, 	111  },
            {5845, 	112.5},
            {5812, 	114  },
            {5779, 	115.5},
            {5746, 	117  },
            {5713, 	118.5},
            {5680, 	120  },
            {5647, 	121.5},
            {5614, 	123  },
            {5581, 	124.5},
            {5548, 	126  },
            {5515, 	127.5},
            {5482, 	129  },
            {5449, 	130.5},
            {5416, 	132  },
            {5383, 	133.5},
            {5350, 	135  },
            {5317, 	136.5},
            {5284, 	138  },
            {5251, 	139.5},
            {5218, 	141  },
            {5185, 	142.5},
            {5152, 	144  },
            {5119, 	145.5},
            {5086, 	147  },
            {5053, 	148.5},
            {5020, 	150  },
            {4987, 	151.5},
            {4954, 	153  },
            {4921, 	154.5},
            {4888, 	156  },
            {4855, 	157.5},
            {4822, 	159  },
            {4789, 	160.5},
            {4756, 	162  },
            {4723, 	163.5},
            {4690, 	165  },
            {4657, 	166.5},
            {4624, 	168  },
            {4591, 	169.5},
            {4558, 	171  },
            {4525, 	172.5},
            {4492, 	174  },
            {4459, 	175.5},
            {4426, 	177  },
            {4393, 	178.5},
            {4360, 	180  },
            {4327, 	181.5},
            {4294, 	183  },
            {4261, 	184.5},
            {4228, 	186  },
            {4195, 	187.5},
            {4162, 	189  },
            {4129, 	190.5},
            {4096, 	192  },
            {4063, 	193.5},
            {4030, 	195  },
            {3997, 	196.5},
            {3964, 	198  },
            {3931, 	199.5},
            {3898, 	201  },
            {3865, 	202.5},
            {3832, 	204  },
            {3799, 	205.5},
            {3766, 	207  },
            {3733, 	208.5},
            {3700, 	210  },
            {3667, 	211.5},
            {3634, 	213  },
            {3601, 	214.5},
            {3568, 	216  },
            {3535, 	217.5},
            {3502, 	219  },
            {3469, 	220.5},
            {3436, 	222  },
            {3403, 	223.5},
            {3370, 	225  },
            {3337, 	226.5},
            {3304, 	228  },
            {3271, 	229.5},
            {3238, 	231  },
            {3205, 	232.5},
            {3172, 	234  },
            {3139, 	235.5},
            {3106, 	237  },
            {3073, 	238.5},
            {3040, 	240  },
            {3007, 	241.5},
            {2974, 	243  },
            {2941, 	244.5},
            {2908, 	246  },
            {2875, 	247.5},
            {2842, 	249  },
            {2809, 	250.5},
            {2776, 	252  },
            {2743, 	253.5},
            {2710, 	255  },
            {2677, 	256.5},
            {2644, 	258  },
            {2611, 	259.5},
            {2578, 	261  },
            {2545, 	262.5},
            {2512, 	264  },
            {2479, 	265.5},
            {2446, 	267  },
            {2413, 	268.5},
            {2380, 	270  },
            {2347, 	271.5},
            {2314, 	273  },
            {2281, 	274.5},
            {2248, 	276  },
            {2215, 	277.5},
            {2182, 	279  },
            {2149, 	280.5},
            {2116, 	282  },
            {2083, 	283.5},
            {2050, 	285  },
            {2017, 	286.5},
            {1984, 	288  },
            {1951, 	289.5},
            {1918, 	291  },
            {1885, 	292.5},
            {1852, 	294  },
            {1819, 	295.5},
            {1786, 	297  },
            {1753, 	298.5},
            {1720, 	300  },
            {1687, 	301.5},
            {1654, 	303  },
            {1621, 	304.5},
            {1588, 	306  },
            {1555, 	307.5},
            {1522, 	309  },
            {1489, 	310.5},
            {1456, 	312  },
            {1423, 	313.5},
            {1390, 	315  },
            {1357, 	316.5},
            {1324, 	318  },
            {1291, 	319.5},
            {1258, 	321  },
            {1225, 	322.5},
            {1192, 	324  },
            {1159, 	325.5},
            {1126, 	327  },
            {1093, 	328.5},
            {1060, 	330  },
            {1027, 	331.5},
            {994 ,	333  },
            {961 ,	334.5},
            {928 ,	336  },
            {895 ,	337.5},
            {862 ,	339  },
            {829 ,	340.5},
            {796 ,	342  },
            {763 ,	343.5},
            {730 ,	345  },
            {697 ,	346.5},
            {664 ,	348  },
            {631 ,	349.5},
            {598 ,	351  },
            {565 ,	352.5},
            {532 ,	354  },
            {499 ,	355.5},
            {466 ,	357  },
            {433 ,	358.5},*/
               {14000, 	60    },
                {13931, 	61.5  },
                {13862, 	63    },
                {13793, 	64.5  },
                {13724, 	66    },
                {13655, 	67.5  },
                {13586, 	69    },
                {13517, 	70.5  },
                {13448, 	72    },
                {13379, 	73.5  },
                {13310, 	75    },
                {13241, 	76.5  },
                {13172, 	78    },
                {13103, 	79.5  },
                {13034, 	81    },
                {12965, 	82.5  },
                {12896, 	84    },
                {12827, 	85.5  },
                {12758, 	87    },
                {12689, 	88.5  },
                {12620, 	90    },
                {12551, 	91.5  },
                {12482, 	93    },
                {12413, 	94.5  },
                {12344, 	96    },
                {12275, 	97.5  },
                {12206, 	99    },
                {12137, 	100.5 },
                {12068, 	102   },
                {11999, 	103.5 },
                {11930, 	105   },
                {11861, 	106.5 },
                {11792, 	108   },
                {11723, 	109.5 },
                {11654, 	111   },
                {11585, 	112.5 },
                {11516, 	114   },
                {11447, 	115.5 },
                {11378, 	117   },
                {11309, 	118.5 },
                {11240, 	120   },
                {11171, 	121.5 },
                {11102, 	123   },
                {11033, 	124.5 },
                {10964, 	126   },
                {10895, 	127.5 },
                {10826, 	129   },
                {10757, 	130.5 },
                {10688, 	132   },
                {10619, 	133.5 },
                {10550, 	135   },
                {10481, 	136.5 },
                {10412, 	138   },
                {10343, 	139.5 },
                {10274, 	141   },
                {10205, 	142.5 },
                {10136, 	144   },
                {10067, 	145.5 },
                {9998 ,	147     },
                {9929 ,	148.5   },
                {9860 ,	150     },
                {9791 ,	151.5   },
                {9722 ,	153     },
                {9653 ,	154.5   },
                {9584 ,	156     },
                {9515 ,	157.5   },
                {9446 ,	159     },
                {9377 ,	160.5   },
                {9308 ,	162     },
                {9239 ,	163.5   },
                {9170 ,	165     },
                {9101 ,	166.5   },
                {9032 ,	168     },
                {8963 ,	169.5   },
                {8894 ,	171     },
                {8825 ,	172.5   },
                {8756 ,	174     },
                {8687 ,	175.5   },
                {8618 ,	177     },
                {8549 ,	178.5   },
                {8480 ,	180     },
                {8411 ,	181.5   },
                {8342 ,	183     },
                {8273 ,	184.5   },
                {8204 ,	186     },
                {8135 ,	187.5   },
                {8066 ,	189     },
                {7997 ,	190.5   },
                {7928 ,	192     },
                {7859 ,	193.5   },
                {7790 ,	195     },
                {7721 ,	196.5   },
                {7652 ,	198     },
                {7583 ,	199.5   },
                {7514 ,	201     },
                {7445 ,	202.5   },
                {7376 ,	204     },
                {7307 ,	205.5   },
                {7238 ,	207     },
                {7169 ,	208.5   },
                {7100 ,	210     },
                {7031 ,	211.5   },
                {6962 ,	213     },
                {6893 ,	214.5   },
                {6824 ,	216     },
                {6755 ,	217.5   },
                {6686 ,	219     },
                {6617 ,	220.5   },
                {6548 ,	222     },
                {6479 ,	223.5   },
                {6410 ,	225     },
                {6341 ,	226.5   },
                {6272 ,	228     },
                {6203 ,	229.5   },
                {6134 ,	231     },
                {6065 ,	232.5   },
                {5996 ,	234     },
                {5927 ,	235.5   },
                {5858 ,	237     },
                {5789 ,	238.5   },
                {5720 ,	240     },
                {5651 ,	241.5   },
                {5582 ,	243     },
                {5513 ,	244.5   },
                {5444 ,	246     },
                {5375 ,	247.5   },
                {5306 ,	249     },
                {5237 ,	250.5   },
                {5168 ,	252     },
                {5099 ,	253.5   },
                {5030 ,	255     },
                {4961 ,	256.5   },
                {4892 ,	258     },
                {4823 ,	259.5   },
                {4754 ,	261     },
                {4685 ,	262.5   },
                {4616 ,	264     },
                {4547 ,	265.5   },
                {4478 ,	267     },
                {4409 ,	268.5   },
                {4340 ,	270     },
                {4271 ,	271.5   },
                {4202 ,	273     },
                {4133 ,	274.5   },
                {4064 ,	276     },
                {3995 ,	277.5   },
                {3926 ,	279     },
                {3857 ,	280.5   },
                {3788 ,	282     },
                {3719 ,	283.5   },
                {3650 ,	285     },
                {3581 ,	286.5   },
                {3512 ,	288     },
                {3443 ,	289.5   },
                {3374 ,	291     },
                {3305 ,	292.5   },
                {3236 ,	294     },
                {3167 ,	295.5   },
                {3098 ,	297     },
                {3029 ,	298.5   },
                {2960 ,	300     },
                {2891 ,	301.5   },
                {2822 ,	303     },
                {2753 ,	304.5   },
                {2684 ,	306     },
                {2615 ,	307.5   },
                {2546 ,	309     },
                {2477 ,	310.5   },
                {2408 ,	312     },
                {2339 ,	313.5   },
                {2270 ,	315     },
                {2201 ,	316.5   },
                {2132 ,	318     },
                {2063 ,	319.5   },
                {1994 ,	321     },
                {1925 ,	322.5   },
                {1856 ,	324     },
                {1787 ,	325.5   },
                {1718 ,	327     },
                {1649 ,	328.5   },
                {1580 ,	330     },
                {1511 ,	331.5   },
                {1442 ,	333     },
                {1373 ,	334.5   },
                {1304 ,	336     },
                {1235 ,	337.5   },
                {1166 ,	339     },
                {1097 ,	340.5   },
                {1028 ,	342     },
                {959 	,343.5    },
                {890 	,345      },
                {821 	,346.5    },
                {752 	,348      },
                {683 	,349.5    },
                {614 	,351      },
                {545 	,352.5    },
                {476 	,354      },
                {407 	,355.5    },
                {338 	,357      },
                {269 	,358.5    },

        };
        /**
         * 还有这个
         */
    double[][] T1Map = new double[][]{
            {42000, 20},
            {41975, 20.2},
            {41950, 20.4},
            {41925, 20.6},
            {41900, 20.8},
            {41875, 21},
            {41850, 21.2},
            {41825, 21.4},
            {41800, 21.6},
            {41775, 21.8},
            {41750, 22},
            {41725, 22.2},
            {41700, 22.4},
            {41675, 22.6},
            {41650, 22.8},
            {41625, 23},
            {41600, 23.2},
            {41575, 23.4},
            {41550, 23.6},
            {41525, 23.8},
            {41500, 24},
            {41475, 24.2},
            {41450, 24.4},
            {41425, 24.6},
            {41400, 24.8},
            {41375, 25},
            {41350, 25.2},
            {41325, 25.4},
            {41300, 25.6},
            {41275, 25.8},
            {41250, 26},
            {41225, 26.2},
            {41200, 26.4},
            {41175, 26.6},
            {41150, 26.8},
            {41125, 27},
            {41100, 27.2},
            {41075, 27.4},
            {41050, 27.6},
            {41025, 27.8},
            {41000, 28},
            {40975, 28.2},
            {40950, 28.4},
            {40925, 28.6},
            {40900, 28.8},
            {40875, 29},
            {40850, 29.2},
            {40825, 29.4},
            {40800, 29.6},
            {40775, 29.8},
            {40750, 30},
            {40725, 30.2},
            {40700, 30.4},
            {40675, 30.6},
            {40650, 30.8},
            {40625, 31},
            {40600, 31.2},
            {40575, 31.4},
            {40550, 31.6},
            {40525, 31.8},
            {40500, 32},
            {40475, 32.2},
            {40450, 32.4},
            {40425, 32.6},
            {40400, 32.8},
            {40375, 33},
            {40350, 33.2},
            {40325, 33.4},
            {40300, 33.6},
            {40275, 33.8},
            {40250, 34},
            {40225, 34.2},
            {40200, 34.4},
            {40175, 34.6},
            {40150, 34.8},
            {40125, 35},
            {40100, 35.2},
            {40075, 35.4},
            {40050, 35.6},
            {40025, 35.8},
            {40000, 36},
            {39975, 36.2},
            {39950, 36.4},
            {39925, 36.6},
            {39900, 36.8},
            {39875, 37},
            {39850, 37.2},
            {39825, 37.4},
            {39800, 37.6},
            {39775, 37.8},
            {39750, 38},
            {39725, 38.2},
            {39700, 38.4},
            {39675, 38.6},
            {39650, 38.8},
            {39625, 39},
            {39600, 39.2},
            {39575, 39.4},
            {39550, 39.6},
            {39525, 39.8},
            {39500, 40},
            {39475, 40.2},
            {39450, 40.4},
            {39425, 40.6},
            {39400, 40.8},
            {39375, 41},
            {39350, 41.2},
            {39325, 41.4},
            {39300, 41.6},
            {39275, 41.8},
            {39250, 42},
            {39225, 42.2},
            {39200, 42.4},
            {39175, 42.6},
            {39150, 42.8},
            {39125, 43},
            {39100, 43.2},
            {39075, 43.4},
            {39050, 43.6},
            {39025, 43.8},
            {39000, 44},
            {38975, 44.2},
            {38950, 44.4},
            {38925, 44.6},
            {38900, 44.8},
            {38875, 45},
            {38850, 45.2},
            {38825, 45.4},
            {38800, 45.6},
            {38775, 45.8},
            {38750, 46},
            {38725, 46.2},
            {38700, 46.4},
            {38675, 46.6},
            {38650, 46.8},
            {38625, 47},
            {38600, 47.2},
            {38575, 47.4},
            {38550, 47.6},
            {38525, 47.8},
            {38500, 48},
            {38475, 48.2},
            {38450, 48.4},
            {38425, 48.6},
            {38400, 48.8},
            {38375, 49},
            {38350, 49.2},
            {38325, 49.4},
            {38300, 49.6},
            {38275, 49.8},
            {38250, 50},
            {38225, 50.2},
            {38200, 50.4},
            {38175, 50.6},
            {38150, 50.8},
            {38125, 51},
            {38100, 51.2},
            {38075, 51.4},
            {38050, 51.6},
            {38025, 51.8},
            {38000, 52},
            {37975, 52.2},
            {37950, 52.4},
            {37925, 52.6},
            {37900, 52.8},
            {37875, 53},
            {37850, 53.2},
            {37825, 53.4},
            {37800, 53.6},
            {37775, 53.8},
            {37750, 54},
            {37725, 54.2},
            {37700, 54.4},
            {37675, 54.6},
            {37650, 54.8},
            {37625, 55},
            {37600, 55.2},
            {37575, 55.4},
            {37550, 55.6},
            {37525, 55.8},
            {37500, 56},
            {37475, 56.2},
            {37450, 56.4},
            {37425, 56.6},
            {37400, 56.8},
            {37375, 57},
            {37350, 57.2},
            {37325, 57.4},
            {37300, 57.6},
            {37275, 57.8},
            {37250, 58},
            {37225, 58.2},
            {37200, 58.4},
            {37175, 58.6},
            {37150, 58.8},
            {37125, 59},
            {37100, 59.2},
            {37075, 59.4},
            {37050, 59.6},
            {37025, 59.8},
    };
    double[][] T2Map = new double[][]{
            {946,	25    },
            {942,	25.25 },
            {938,	25.5  },
            {934,	25.75 },
            {930,	26    },
            {926,	26.25 },
            {922,	26.5  },
            {918,	26.75 },
            {914,	27    },
            {910,	27.25 },
            {906,	27.5  },
            {902,	27.75 },
            {898,	28    },
            {894,	28.25 },
            {890,	28.5  },
            {886,	28.75 },
            {882,	29    },
            {878,	29.25 },
            {874,	29.5  },
            {870,	29.75 },
            {866,	30    },
            {862,	30.25 },
            {858,	30.5  },
            {854,	30.75 },
            {850,	31    },
            {846,	31.25 },
            {842,	31.5  },
            {838,	31.75 },
            {834,	32    },
            {830,	32.25 },
            {826,	32.5  },
            {822,	32.75 },
            {818,	33    },
            {814,	33.25 },
            {810,	33.5  },
            {806,	33.75 },
            {802,	34    },
            {798,	34.25 },
            {794,	34.5  },
            {790,	34.75 },
            {786,	35    },
            {782,	35.25 },
            {778,	35.5  },
            {774,	35.75 },
            {770,	36    },
            {766,	36.25 },
            {762,	36.5  },
            {758,	36.75 },
            {754,	37    },
            {750,	37.25 },
            {746,	37.5  },
            {742,	37.75 },
            {738,	38    },
            {734,	38.25 },
            {730,	38.5  },
            {726,	38.75 },
            {722,	39    },
            {718,	39.25 },
            {714,	39.5  },
            {710,	39.75 },
            {706,	40    },
            {702,	40.25 },
            {698,	40.5  },
            {694,	40.75 },
            {690,	41    },
            {686,	41.25 },
            {682,	41.5  },
            {678,	41.75 },
            {674,	42    },
            {670,	42.25 },
            {666,	42.5  },
            {662,	42.75 },
            {658,	43    },
            {654,	43.25 },
            {650,	43.5  },
            {646,	43.75 },
            {642,	44    },
            {638,	44.25 },
            {634,	44.5  },
            {630,	44.75 },
            {626,	45    },
            {622,	45.25 },
            {618,	45.5  },
            {614,	45.75 },
            {610,	46    },
            {606,	46.25 },
            {602,	46.5  },
            {598,	46.75 },
            {594,	47    },
            {590,	47.25 },
            {586,	47.5  },
            {582,	47.75 },
            {578,	48    },
            {574,	48.25 },
            {570,	48.5  },
            {566,	48.75 },
            {562,	49    },
            {558,	49.25 },
            {554,	49.5  },
            {550,	49.75 },
            {546,	50    },
            {542,	50.25 },
            {538,	50.5  },
            {534,	50.75 },
            {530,	51    },
            {526,	51.25 },
            {522,	51.5  },
            {518,	51.75 },
            {514,	52    },
            {510,	52.25 },
            {506,	52.5  },
            {502,	52.75 },
            {498,	53    },
            {494,	53.25 },
            {490,	53.5  },
            {486,	53.75 },
            {482,	54    },
            {478,	54.25 },
            {474,	54.5  },
            {470,	54.75 },
            {466,	55    },
            {462,	55.25 },
            {458,	55.5  },
            {454,	55.75 },
            {450,	56    },
            {446,	56.25 },
            {442,	56.5  },
            {438,	56.75 },
            {434,	57    },
            {430,	57.25 },
            {426,	57.5  },
            {422,	57.75 },
            {418,	58    },
            {414,	58.25 },
            {410,	58.5  },
            {406,	58.75 },
            {402,	59    },
            {398,	59.25 },
            {394,	59.5  },
            {390,	59.75 },
            {386,	60    },
            {382,	60.25 },
            {378,	60.5  },
            {374,	60.75 },
            {370,	61    },
            {366,	61.25 },
            {362,	61.5  },
            {358,	61.75 },
            {354,	62    },
            {350,	62.25 },
            {346,	62.5  },
            {342,	62.75 },
            {338,	63    },
            {334,	63.25 },
            {330,	63.5  },
            {326,	63.75 },
            {322,	64    },
            {318,	64.25 },
            {314,	64.5  },
            {310,	64.75 },
            {306,	65    },
            {302,	65.25 },
            {298,	65.5  },
            {294,	65.75 },
            {290,	66    },
            {286,	66.25 },
            {282,	66.5  },
            {278,	66.75 },
            {274,	67    },
            {270,	67.25 },
            {266,	67.5  },
            {262,	67.75 },
            {258,	68    },
            {254,	68.25 },
            {250,	68.5  },
            {246,	68.75 },
            {242,	69    },
            {238,	69.25 },
            {234,	69.5  },
            {230,	69.75 },
            {226,	70    },
            {222,	70.25 },
            {218,	70.5  },
            {214,	70.75 },
            {210,	71    },
            {206,	71.25 },
            {202,	71.5  },
            {198,	71.75 },
            {194,	72    },
            {190,	72.25 },
            {186,	72.5  },
            {182,	72.75 },
            {178,	73    },
            {174,	73.25 },
            {170,	73.5  },
            {166,	73.75 },
            {162,	74    },
            {158,	74.25 },
            {154,	74.5  },
            {150,	74.75 },
    };
    long ADCVal = 0;
    long T1 = 0;
    long T2 = 0;


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
        return R.layout.activity_main;
    }

    @Override
    public void initView(View view) {
        mWebView = $(R.id.mWebView);
    }

    @Override
    public void setListener() {




    }

    @Override
    public void doBusiness(Context mContext) {
        loadHTML(Config.IP + "app/index.html");
        service_init();
    }

    public void loadHTML(String url) {
        mWebView.loadUrl(url);
        //启用支持javascript
        WebSettings webSettings = mWebView.getSettings();
        webSettings.setJavaScriptEnabled(true);
        webSettings.setLoadWithOverviewMode(true);
        webSettings.setDefaultTextEncodingName("GBK");//设置字符编码
        webSettings.setBlockNetworkImage(false);//不加載圖片

/**
 * 设置支持 LocalStorage
 */
        webSettings.setDomStorageEnabled(true);
        webSettings.setAppCacheMaxSize(1024 * 1024 * 8);
        String appCachePath = getApplicationContext().getCacheDir().getAbsolutePath();
        webSettings.setAppCachePath(appCachePath);
        webSettings.setAllowFileAccess(true);
        webSettings.setAppCacheEnabled(true);

        mWebView.addJavascriptInterface(this, "nativeMethod");

        final ProgressDialog progressDialog = new ProgressDialog(MainActivity.this);

        mWebView.setWebChromeClient(new MWebChromeClient() {
            // For 3.0+ Devices (Start)
            // onActivityResult attached before constructor
            protected void openFileChooser(ValueCallback uploadMsg, String acceptType) {
                mUploadMessage = uploadMsg;
                Intent i = new Intent(Intent.ACTION_GET_CONTENT);
                i.addCategory(Intent.CATEGORY_OPENABLE);
                i.setType("image/*");
                startActivityForResult(Intent.createChooser(i, "File Browser"), FILECHOOSER_RESULTCODE);
            }


            // For Lollipop 5.0+ Devices
            @TargetApi(Build.VERSION_CODES.LOLLIPOP)
            public boolean onShowFileChooser(WebView mWebView, ValueCallback<Uri[]> filePathCallback, WebChromeClient.FileChooserParams fileChooserParams) {
                if (uploadMessage != null) {
                    uploadMessage.onReceiveValue(null);
                    uploadMessage = null;
                }

                uploadMessage = filePathCallback;

                Intent intent = fileChooserParams.createIntent();
                try {
                    startActivityForResult(intent, REQUEST_SELECT_FILE);
                } catch (ActivityNotFoundException e) {
                    uploadMessage = null;
                    showToast("Cannot Open File Chooser");
                    return false;
                }
                return true;
            }

            //For Android 4.1 only
            protected void openFileChooser(ValueCallback<Uri> uploadMsg, String acceptType, String capture) {
                mUploadMessage = uploadMsg;
                Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
                intent.addCategory(Intent.CATEGORY_OPENABLE);
                intent.setType("image/*");
                startActivityForResult(Intent.createChooser(intent, "File Browser"), FILECHOOSER_RESULTCODE);
            }

            protected void openFileChooser(ValueCallback<Uri> uploadMsg) {
                mUploadMessage = uploadMsg;
                Intent i = new Intent(Intent.ACTION_GET_CONTENT);
                i.addCategory(Intent.CATEGORY_OPENABLE);
                i.setType("image/*");
                startActivityForResult(Intent.createChooser(i, "File Chooser"), FILECHOOSER_RESULTCODE);
                                    }
//            @Override
//            //速度正在改变
//            public void onProgressChanged(WebView view, int newProgress) {
////                progressDialog.setMessage("加载" + newProgress);
//            }
//
//            @Override
//            public boolean onConsoleMessage(ConsoleMessage consoleMessage) {
//                Log.i("console", "["+consoleMessage.messageLevel()+"] "+ consoleMessage.message() + "(" +consoleMessage.sourceId()  + ":" + consoleMessage.lineNumber()+")");
//                return super.onConsoleMessage(consoleMessage);
//            }
        });

        //覆盖WebView默认使用第三方或系统默认浏览器打开网页的行为，使网页用WebView打开
        mWebView.setWebViewClient(new MWebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                // TODO Auto-generated method stub
                //返回值是true的时候控制去WebView打开，为false调用系统浏览器或第三方浏览器
                view.loadUrl(url);
                return true;
            }

            /**
             * 页面开始的时候 回调此方法
             * @param view
             * @param url
             * @param favicon
             */
            @Override
            public void onPageStarted(WebView view, String url, Bitmap favicon) {
                super.onPageStarted(view, url, favicon);
//                if (progressDialog == null){
//                    progressDialog.setMessage("加载中。。。。。。。。。。。");
//                }
//                progressDialog.show();
            }


            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
//                progressDialog.dismiss();
            }

        });


    }


    @JavascriptInterface
    public void toNrfActivity(String memberbid, String xueweibid) {
        //此处应该定义常量对应，同时提供给web页面编写者
        if (memberbid != null && xueweibid != null) {
            Intent intent = new Intent();
            Bundle bundle = new Bundle();
            bundle.putString("memberbid", memberbid);
            bundle.putString("xueweibid", xueweibid);
            intent.setClass(this, NrfActivity.class);
            intent.putExtras(bundle);
            startActivity(intent);
        }
    }


    private void service_init() {
        Intent bindIntent = new Intent(this, UartService.class);
        bindService(bindIntent, mServiceConnection, Context.BIND_AUTO_CREATE);

        LocalBroadcastManager.getInstance(this).registerReceiver(UARTStatusChangeReceiver, makeGattUpdateIntentFilter());
    }

    private static IntentFilter makeGattUpdateIntentFilter() {
        final IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction(UartService.ACTION_GATT_CONNECTED);
        intentFilter.addAction(UartService.ACTION_GATT_DISCONNECTED);
        intentFilter.addAction(UartService.ACTION_GATT_SERVICES_DISCOVERED);
        intentFilter.addAction(UartService.ACTION_DATA_AVAILABLE);
        intentFilter.addAction(UartService.DEVICE_DOES_NOT_SUPPORT_UART);
        return intentFilter;
    }

    //UART service connected/disconnected
    private ServiceConnection mServiceConnection = new ServiceConnection() {
        public void onServiceConnected(ComponentName className, IBinder rawBinder) {
            mService = ((UartService.LocalBinder) rawBinder).getService();
            Log.d(TAG, "onServiceConnected mService= " + mService);
            if (!mService.initialize()) {
                Log.e(TAG, "Unable to initialize Bluetooth");
                finish();
            }

        }

        public void onServiceDisconnected(ComponentName classname) {
            ////     mService.disconnect(mDevice);
            mService = null;
        }
    };

    private final BroadcastReceiver UARTStatusChangeReceiver = new    BroadcastReceiver() {

        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();

            final Intent mIntent = intent;
            //*********************//
            if (action.equals(UartService.ACTION_GATT_CONNECTED)) {
                runOnUiThread(new Runnable() {
                    public void run() {
                        String currentDateTimeString = DateFormat.getTimeInstance().format(new Date());
                        Log.d(TAG, "UART_CONNECT_MSG");
                        Log.d(TAG, "==============================连接蓝牙============================");
                        mState = UART_PROFILE_CONNECTED;
                    }
                });
            }

            //*********************//
            if (action.equals(UartService.ACTION_GATT_DISCONNECTED)) {
                runOnUiThread(new Runnable() {
                    public void run() {
                        String currentDateTimeString = DateFormat.getTimeInstance().format(new Date());
                        Log.d(TAG, "UART_DISCONNECT_MSG");
                        Log.d(TAG, "==============================连接蓝牙断开============================");
                        mState = UART_PROFILE_DISCONNECTED;
                        mService.close();
                        //setUiState();

                    }
                });
            }


            //*********************//
            if (action.equals(UartService.ACTION_GATT_SERVICES_DISCOVERED)) {
                mService.enableTXNotification();
            }
            //*********************//
            if (action.equals(UartService.ACTION_DATA_AVAILABLE)) {
                Log.d(TAG,"连续读取数据------------------------------------------------------");
                final byte[] txValue = intent.getByteArrayExtra(UartService.EXTRA_DATA);
                runOnUiThread(new Runnable() {
                    public void run() {
                        try {
                            if (txValue[1] == (byte) 0xE0 || txValue[1] == (byte) 0xE2) {
                                ADCVal = (long) (txValue[9] & 0xFF | (txValue[8] & 0xFF) << 8);
                                T1 = (long) (txValue[11] & 0xFF | (txValue[10] & 0xFF) << 8);
                                T2 = (long) (txValue[13] & 0xFF | (txValue[12] & 0xFF) << 8);

                                double ADCV = CheckADCVal(ADCVal);
//                                ((TextView) findViewById(R.id.textView)).setText("ADC:" + ADCVal +","+ADCV+"V");
//                                Log.d(TAG,"ADC(T2轉換):" + T2 +","+ADCV+"V");


                                //T1=2844;
                                //double T1Val=CheckT1Val(T1);
                                double T1Val = 1000000 / (double) T1;
                                String headerText = String.format("%.1f ", T1Val);
//                                ((TextView) findViewById(R.id.textView2)).setText("T1:" + T1 +"="+headerText+"Hz");
//                                Log.d(TAG,"T1:" + T1+"="+T1Val+"Hz");


                                //T2=156;
                                double T2Val = CheckT2Val(T2);
//                                ((TextView) findViewById(R.id.textView3)).setText("T2:" + T2+"="+T2Val+"uS");
//                                Log.d(TAG,"T2:" + T2+"="+T2Val+"uS");

                                saveSession(ADCV, headerText, T2Val);

//                                showToast("ADC(T2轉換):"+ADCV+"T1:"+headerText+"T2:"+T2);
                            }
                        } catch (Exception e) {
                            Log.e(TAG, e.toString());
                            Log.e(TAG, e.toString()+"============================================");
                        }
                    }
                });
            }
            //*********************//
            if (action.equals(UartService.DEVICE_DOES_NOT_SUPPORT_UART)) {
                showToast("Device doesn't support UART. Disconnecting");
                //mService.disconnect();
            }


        }
    };


    public static void saveSession(double ADCVal, String T1, double T2) {

        mWebView.loadUrl(
                "javascript:(function(){" +
                        "window.sessionStorage.setItem('ADCVal','" + ADCVal + "');" +
                        "window.sessionStorage.setItem('T1','" + T1 + "');" +
                        "window.sessionStorage.setItem('T2','" + T2 + "');" +
                        "})();");


    }



    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.d(TAG, "onDestroy()");

        try {
            LocalBroadcastManager.getInstance(this).unregisterReceiver(UARTStatusChangeReceiver);
        } catch (Exception ignore) {
            Log.e(TAG, ignore.toString());
        }
        unbindService(mServiceConnection);
        mService.stopSelf();
        mService = null;

    }


    //记录用户首次点击返回键的时间
    private long firstTime = 0;

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK && event.getAction() == KeyEvent.ACTION_DOWN) {
            long secondTime = System.currentTimeMillis();
            if (secondTime - firstTime > 2000) {
                Toast.makeText(MainActivity.this, "再按一次退出程序", Toast.LENGTH_SHORT).show();
                firstTime = secondTime;
                return true;
            } else {
                System.exit(0);
            }
        }
        return super.onKeyDown(keyCode, event);
    }
    //改写物理按键——返回的逻辑
    /*@Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        // TODO Auto-generated method stub
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            if (mWebView.canGoBack()) {
                mWebView.goBack();//返回上一页面
                return true;
            } else {
                if (System.currentTimeMillis() - firstTime > 2000) {
                    showToast("再按一次退出程式");
                    firstTime = System.currentTimeMillis();
                } else {
//                    finish();
//                    System.exit(0);
                    new AlertDialog.Builder(this).setTitle("確定要退出程式嗎？")
                            .setPositiveButton("確定", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {
                                    // 点击“确认”后的操作
                                    finish();
                                    System.exit(0);
                                }
                            })
                            .setNegativeButton("取消", null).show();

                }
            }
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }*/


    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent) {

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            if (requestCode == REQUEST_SELECT_FILE) {
                if (uploadMessage == null)
                    return;
                uploadMessage.onReceiveValue(WebChromeClient.FileChooserParams.parseResult(resultCode, intent));
                uploadMessage = null;
            }
        } else if (requestCode == FILECHOOSER_RESULTCODE) {
            if (null == mUploadMessage)
                return;
            // Use MainActivity.RESULT_OK if you're implementing WebView inside Fragment
            // Use RESULT_OK only if you're implementing WebView inside an Activity
            Uri result = intent == null || resultCode != MainActivity.RESULT_OK ? null : intent.getData();
            mUploadMessage.onReceiveValue(result);
            mUploadMessage = null;
        } else
            Toast.makeText(getBaseContext(), "Failed to Upload Image", Toast.LENGTH_LONG).show();
    }

    public double CheckADCVal(long ADC) {
        //ADC=3971;
        double ADCV = 0;
        if (ADC <= ADCMap[ADCMap.length - 1][0])
            ADCV = ADCMap[ADCMap.length - 1][1];
        else if (ADC >= ADCMap[0][0])
            ADCV = ADCMap[0][1];
        else {
            for (int i = 0; i < ADCMap.length; i++) {
                if (ADC >= ADCMap[i][0]) {
                    ADCV = ADCMap[i][1];
                    break;
                }
            }
        }
        return ADCV;
    }

    public double CheckT1Val(long t1) {
        //t1=1391;
        double t1Val = 0;

        if (t1 <= T1Map[T1Map.length - 1][0])
            t1Val = T1Map[T1Map.length - 1][1];
        else if (t1 >= T1Map[0][0])
            t1Val = T1Map[0][1];
        else {
            for (int i = 0; i < T1Map.length; i++) {
                if (t1 >= T1Map[i][0]) {
                    t1Val = T1Map[i][1];
                    break;
                }
            }
        }
        return t1Val;
    }

    public double CheckT2Val(long t2) {

        double t2Val = 0;
        if (t2 <= T2Map[T2Map.length - 1][0])
            t2Val = T2Map[T2Map.length - 1][1];
        else if (t2 >= T2Map[0][0])
            t2Val = T2Map[0][1];
        else {
            for (int i = 0; i < T2Map.length; i++) {
                if (t2 >= T2Map[i][0]) {
                    t2Val = T2Map[i][1];
                    break;
                }
            }
        }
        return t2Val;
    }


}
