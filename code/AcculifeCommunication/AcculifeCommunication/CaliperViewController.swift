//
//  CaliperViewController
//  Caliper_Reader
//
//  Created by Wesley Chen on 2017/3/30.
//  Copyright © 2017年 Wesley Chen. All rights reserved.
//

import UIKit
import CoreBluetooth
import AVFoundation
import MediaPlayer

var ADCMap : [[Double]] =
[
[1800 ,    160   ],
[1792 ,    160.4 ],
[1784 ,    160.8 ],
[1776 ,    161.2 ],
[1768 ,    161.6 ],
[1760 ,    162   ],
[1752 ,    162.4 ],
[1744 ,    162.8 ],
[1736 ,    163.2 ],
[1728 ,    163.6 ],
[1720 ,    164   ],
[1712 ,    164.4 ],
[1704 ,    164.8 ],
[1696 ,    165.2 ],
[1688 ,    165.6 ],
[1680 ,    166   ],
[1672 ,    166.4 ],
[1664 ,    166.8 ],
[1656 ,    167.2 ],
[1648 ,    167.6 ],
[1640 ,    168   ],
[1632 ,    168.4 ],
[1624 ,    168.8 ],
[1616 ,    169.2 ],
[1608 ,    169.6 ],
[1600 ,    170   ],
[1592 ,    170.4 ],
[1584 ,    170.8 ],
[1576 ,    171.2 ],
[1568 ,    171.6 ],
[1560 ,    172   ],
[1552 ,    172.4 ],
[1544 ,    172.8 ],
[1536 ,    173.2 ],
[1528 ,    173.6 ],
[1520 ,    174   ],
[1512 ,    174.4 ],
[1504 ,    174.8 ],
[1496 ,    175.2 ],
[1488 ,    175.6 ],
[1480 ,    176   ],
[1472 ,    176.4 ],
[1464 ,    176.8 ],
[1456 ,    177.2 ],
[1448 ,    177.6 ],
[1440 ,    178   ],
[1432 ,    178.4 ],
[1424 ,    178.8 ],
[1416 ,    179.2 ],
[1408 ,    179.6 ],
[1400 ,    180   ],
[1392 ,    180.4 ],
[1384 ,    180.8 ],
[1376 ,    181.2 ],
[1368 ,    181.6 ],
[1360 ,    182   ],
[1352 ,    182.4 ],
[1344 ,    182.8 ],
[1336 ,    183.2 ],
[1328 ,    183.6 ],
[1320 ,    184   ],
[1312 ,    184.4 ],
[1304 ,    184.8 ],
[1296 ,    185.2 ],
[1288 ,    185.6 ],
[1280 ,    186   ],
[1272 ,    186.4 ],
[1264 ,    186.8 ],
[1256 ,    187.2 ],
[1248 ,    187.6 ],
[1240 ,    188   ],
[1232 ,    188.4 ],
[1224 ,    188.8 ],
[1216 ,    189.2 ],
[1208 ,    189.6 ],
[1200 ,    190   ],
[1192 ,    190.4 ],
[1184 ,    190.8 ],
[1176 ,    191.2 ],
[1168 ,    191.6 ],
[1160 ,    192   ],
[1152 ,    192.4 ],
[1144 ,    192.8 ],
[1136 ,    193.2 ],
[1128 ,    193.6 ],
[1120 ,    194   ],
[1112 ,    194.4 ],
[1104 ,    194.8 ],
[1096 ,    195.2 ],
[1088 ,    195.6 ],
[1080 ,    196   ],
[1072 ,    196.4 ],
[1064 ,    196.8 ],
[1056 ,    197.2 ],
[1048 ,    197.6 ],
[1040 ,    198   ],
[1032 ,    198.4 ],
[1024 ,    198.8 ],
[1016 ,    199.2 ],
[1008 ,    199.6 ],
[1000 ,    200   ],
[992     ,200.4  ],
[984     ,200.8  ],
[976     ,201.2  ],
[968     ,201.6  ],
[960     ,202    ],
[952     ,202.4  ],
[944     ,202.8  ],
[936     ,203.2  ],
[928     ,203.6  ],
[920     ,204    ],
[912     ,204.4  ],
[904     ,204.8  ],
[896     ,205.2  ],
[888     ,205.6  ],
[880     ,206    ],
[872     ,206.4  ],
[864     ,206.8  ],
[856     ,207.2  ],
[848     ,207.6  ],
[840     ,208    ],
[832     ,208.4  ],
[824     ,208.8  ],
[816     ,209.2  ],
[808     ,209.6  ],
[800     ,210    ],
[792     ,210.4  ],
[784     ,210.8  ],
[776     ,211.2  ],
[768     ,211.6  ],
[760     ,212    ],
[752     ,212.4  ],
[744     ,212.8  ],
[736     ,213.2  ],
[728     ,213.6  ],
[720     ,214    ],
[712     ,214.4  ],
[704     ,214.8  ],
[696     ,215.2  ],
[688     ,215.6  ],
[680     ,216    ],
[672     ,216.4  ],
[664     ,216.8  ],
[656     ,217.2  ],
[648     ,217.6  ],
[640     ,218    ],
[632     ,218.4  ],
[624     ,218.8  ],
[616     ,219.2  ],
[608     ,219.6  ],
[600     ,220    ],
[592     ,220.4  ],
[584     ,220.8  ],
[576     ,221.2  ],
[568     ,221.6  ],
[560     ,222    ],
[552     ,222.4  ],
[544     ,222.8  ],
[536     ,223.2  ],
[528     ,223.6  ],
[520     ,224    ],
[512     ,224.4  ],
[504     ,224.8  ],
[496     ,225.2  ],
[488     ,225.6  ],
[480     ,226    ],
[472     ,226.4  ],
[464     ,226.8  ],
[456     ,227.2  ],
[448     ,227.6  ],
[440     ,228    ],
[432     ,228.4  ],
[424     ,228.8  ],
[416     ,229.2  ],
[408     ,229.6  ],
[400     ,230    ],
[392     ,230.4  ],
[384     ,230.8  ],
[376     ,231.2  ],
[368     ,231.6  ],
[360     ,232    ],
[352     ,232.4  ],
[344     ,232.8  ],
[336     ,233.2  ],
[328     ,233.6  ],
[320     ,234    ],
[312     ,234.4  ],
[304     ,234.8  ],
[296     ,235.2  ],
[288     ,235.6  ],
[280     ,236    ],
[272     ,236.4  ],
[264     ,236.8  ],
[256     ,237.2  ],
[248     ,237.6  ],
[240     ,238    ],
[232     ,238.4  ],
[224     ,238.8  ],
[216     ,239.2  ],
[208     ,239.6  ]
];

//double[][] T2Map = new double[][][
var T2Map : [[Double]] =
[
    [946,    50   ],
    [942,    50.25],
    [938,    50.5 ],
    [934,    50.75],
    [930,    51   ],
    [926,    51.25],
    [922,    51.5 ],
    [918,    51.75],
    [914,    52   ],
    [910,    52.25],
    [906,    52.5 ],
    [902,    52.75],
    [898,    53   ],
    [894,    53.25],
    [890,    53.5 ],
    [886,    53.75],
    [882,    54   ],
    [878,    54.25],
    [874,    54.5 ],
    [870,    54.75],
    [866,    55   ],
    [862,    55.25],
    [858,    55.5 ],
    [854,    55.75],
    [850,    56   ],
    [846,    56.25],
    [842,    56.5 ],
    [838,    56.75],
    [834,    57   ],
    [830,    57.25],
    [826,    57.5 ],
    [822,    57.75],
    [818,    58   ],
    [814,    58.25],
    [810,    58.5 ],
    [806,    58.75],
    [802,    59   ],
    [798,    59.25],
    [794,    59.5 ],
    [790,    59.75],
    [786,    60   ],
    [782,    60.25],
    [778,    60.5 ],
    [774,    60.75],
    [770,    61   ],
    [766,    61.25],
    [762,    61.5 ],
    [758,    61.75],
    [754,    62   ],
    [750,    62.25],
    [746,    62.5 ],
    [742,    62.75],
    [738,    63   ],
    [734,    63.25],
    [730,    63.5 ],
    [726,    63.75],
    [722,    64   ],
    [718,    64.25],
    [714,    64.5 ],
    [710,    64.75],
    [706,    65   ],
    [702,    65.25],
    [698,    65.5 ],
    [694,    65.75],
    [690,    66   ],
    [686,    66.25],
    [682,    66.5 ],
    [678,    66.75],
    [674,    67   ],
    [670,    67.25],
    [666,    67.5 ],
    [662,    67.75],
    [658,    68   ],
    [654,    68.25],
    [650,    68.5 ],
    [646,    68.75],
    [642,    69   ],
    [638,    69.25],
    [634,    69.5 ],
    [630,    69.75],
    [626,    70   ],
    [622,    70.25],
    [618,    70.5 ],
    [614,    70.75],
    [610,    71   ],
    [606,    71.25],
    [602,    71.5 ],
    [598,    71.75],
    [594,    72   ],
    [590,    72.25],
    [586,    72.5 ],
    [582,    72.75],
    [578,    73   ],
    [574,    73.25],
    [570,    73.5 ],
    [566,    73.75],
    [562,    74   ],
    [558,    74.25],
    [554,    74.5 ],
    [550,    74.75],
    [546,    75   ],
    [542,    75.25],
    [538,    75.5 ],
    [534,    75.75],
    [530,    76   ],
    [526,    76.25],
    [522,    76.5 ],
    [518,    76.75],
    [514,    77   ],
    [510,    77.25],
    [506,    77.5 ],
    [502,    77.75],
    [498,    78   ],
    [494,    78.25],
    [490,    78.5 ],
    [486,    78.75],
    [482,    79   ],
    [478,    79.25],
    [474,    79.5 ],
    [470,    79.75],
    [466,    80   ],
    [462,    80.25],
    [458,    80.5 ],
    [454,    80.75],
    [450,    81   ],
    [446,    81.25],
    [442,    81.5 ],
    [438,    81.75],
    [434,    82   ],
    [430,    82.25],
    [426,    82.5 ],
    [422,    82.75],
    [418,    83   ],
    [414,    83.25],
    [410,    83.5 ],
    [406,    83.75],
    [402,    84   ],
    [398,    84.25],
    [394,    84.5 ],
    [390,    84.75],
    [386,    85   ],
    [382,    85.25],
    [378,    85.5 ],
    [374,    85.75],
    [370,    86   ],
    [366,    86.25],
    [362,    86.5 ],
    [358,    86.75],
    [354,    87   ],
    [350,    87.25],
    [346,    87.5 ],
    [342,    87.75],
    [338,    88   ],
    [334,    88.25],
    [330,    88.5 ],
    [326,    88.75],
    [322,    89   ],
    [318,    89.25],
    [314,    89.5 ],
    [310,    89.75],
    [306,    90   ],
    [302,    90.25],
    [298,    90.5 ],
    [294,    90.75],
    [290,    91   ],
    [286,    91.25],
    [282,    91.5 ],
    [278,    91.75],
    [274,    92   ],
    [270,    92.25],
    [266,    92.5 ],
    [262,    92.75],
    [258,    93   ],
    [254,    93.25],
    [250,    93.5 ],
    [246,    93.75],
    [242,    94   ],
    [238,    94.25],
    [234,    94.5 ],
    [230,    94.75],
    [226,    95   ],
    [222,    95.25],
    [218,    95.5 ],
    [214,    95.75],
    [210,    96   ],
    [206,    96.25],
    [202,    96.5 ],
    [198,    96.75],
    [194,    97   ],
    [190,    97.25],
    [186,    97.5 ],
    [182,    97.75],
    [178,    98   ],
    [174,    98.25],
    [170,    98.5 ],
    [166,    98.75],
    [162,    99   ],
    [158,    99.25],
    [154,    99.5 ],
    [150,    99.75],
];

class CaliperViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, AVSpeechSynthesizerDelegate ,UIGestureRecognizerDelegate{
    
    //let UUID_SERVICE = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
    //let UUID_BLE_WRITE = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"
    //let UUID_BLE_READ = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"
//    let UUID_SERVICE = "0000FFF0-0000-1000-8000-00805f9b34fb"
//    let UUID_BLE_WRITE = "0000FFF1-0000-1000-8000-00805f9b34fb"
//    let UUID_BLE_READ = "0000FFF2-0000-1000-8000-00805f9b34fb"
    //let UUID_SERVICE =      "0000FEF0-0000-1000-8000-00805f9b34fb"
    //let UUID_BLE_WRITE =    "0000FEF2-0000-1000-8000-00805f9b34fb"
    //let UUID_BLE_READ =     "0000FEF1-0000-1000-8000-00805f9b34fb"
    let UUID_SERVICE =      "FFF0"
    let UUID_BLE_WRITE =    "FFF2"
    let UUID_BLE_READ =     "FFF1"
    
    let synth = AVSpeechSynthesizer() //TTS對象
    let audioSession = AVAudioSession.sharedInstance() //語音引擎

    
    var centralManager: CBCentralManager!
    var connectPeripheral: CBPeripheral!
    var WriteCharacteristic: CBCharacteristic!
    var uuid: UUID!
    var uuidfromViewController: String!
    
    var bleFindPeripheral = [CBPeripheral!]()
    var bleDeviceNameList = [String]()
    var bleDeviceUUIDList = [String]()
    var bleDeviceRSSIList = [NSNumber]()
    var getTxValue: Float = 0.0
    var getTxUnit: String = ""
    var rectTableCell: CGRect!
    
    var bleNoNewUpdate: uint = 0
    
    
    var timerDisconnectBLE: Timer!
    
    var viewTextFieldBeforeCenterY: CGFloat = 0.0
    
    @IBOutlet weak var viewScanBle: UIView!
    @IBOutlet weak var btnBleConnect: UIButton!
    @IBOutlet weak var btnBleScan: UIButton!
    
    @IBOutlet weak var btnReadE0: UIButton!
    @IBOutlet weak var btnReadE1: UIButton!
    @IBOutlet weak var btnReadE3: UIButton!
    @IBOutlet weak var btnReadE4: UIButton!
    
    //@IBOutlet weak var labelGetRxData: UILabel!
    @IBOutlet weak var labelADCData: UILabel!
    @IBOutlet weak var labelT1Data: UILabel!
    @IBOutlet weak var labelT2Data: UILabel!
    @IBOutlet weak var textFieldSecond: UITextField!
    //@IBOutlet weak var textFieldUpLimit: UITextField!
    //@IBOutlet weak var textFieldDownLimit: UITextField!
    //@IBOutlet weak var labelBleDeviceInfo: UILabel!
    
    @IBOutlet weak var tableViewBle: UITableView!
    
    //@IBOutlet weak var viewTextField: UIView!
    
    override func viewDidLoad() {
        print("CaliperViewController viewDidLoad")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(uuidfromViewController)
//        var itemString:String?
//        print("zxb:")
//        print(itemString)
        //右滑返回
//        let target = self.navigationController?.interactivePopGestureRecognizer!.delegate
//        let pan = UIPanGestureRecognizer(target: target, action: Selector("handleNavigationTransition:"))
//        pan.delegate = self
//        self.view.addGestureRecognizer(pan)
//        //同时禁用系统原先的侧滑功能
//        self.navigationController?.interactivePopGestureRecognizer!.isEnabled = false
        
        
        let queue = DispatchQueue.global()
        centralManager = CBCentralManager(delegate: self, queue: queue)
        
        
        self.timerDisconnectBLE = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            
            self.bleNoNewUpdate += 1
            
            if self.bleNoNewUpdate == 600 {
                
                if self.connectPeripheral != nil {
                    self.centralManager.cancelPeripheralConnection(self.connectPeripheral)
                    print("Timeout BLE Disconnect")
                }
            }
        })
        
        
        viewScanBle.isHidden = true
        textFieldSecond.keyboardType = UIKeyboardType.decimalPad
        //textFieldUpLimit.keyboardType = UIKeyboardType.decimalPad
        //textFieldDownLimit.keyboardType = UIKeyboardType.decimalPad
        //textFieldUpLimit.placeholder = "Please Enter Upper Limit Value"
        //textFieldDownLimit.placeholder = "Please Enter Downer Limit Value"
        
        let nibTableCell = UINib(nibName: "BleTableViewCell", bundle: nil)
        let viewTableCell = nibTableCell.instantiate(withOwner: self, options: nil).first as! UIView
        rectTableCell = viewTableCell.frame
        tableViewBle.register(nibTableCell, forCellReuseIdentifier: "TableCell")
        
        textFieldSecond.delegate = self
        //textFieldUpLimit.delegate = self
        //textFieldDownLimit.delegate = self
        
        //labelBleDeviceInfo.text = "Device: Not Connected"
        btnReadE0.isEnabled = false
        
        synth.delegate = self
        
        //viewTextFieldBeforeCenterY = viewTextField.center.y
        
        textFieldSecond.text = "1.0"
        //textFieldUpLimit.text = "20"
        //textFieldDownLimit.text = "10"
        
    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if self.childViewControllers.count == 1{
//            return false
//        }
//        return true
//    }
//
//    @objc func handleNavigationTransition(){
//
//    }
    override func viewWillAppear(_ animated: Bool) {
        print("CaliperViewController viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("CaliperViewController viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("CaliperViewController viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("CaliperViewController viewDidDisappear")
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // TableView func
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Select a device"
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bleDeviceUUIDList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! BleTableViewCell
        
        cell.deviceName.text = bleDeviceNameList[indexPath.row]
        cell.deviceUUID.text = bleDeviceUUIDList[indexPath.row]
        cell.deviceRSSI.text = "RSSI = \(bleDeviceRSSIList[indexPath.row])"
        
//        cell.backgroundColor = UIColor (colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
        cell.selectionStyle = UITableViewCellSelectionStyle.none //no select gray
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rectTableCell.size.height
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select: \(bleDeviceUUIDList[indexPath.row])")
        
        centralManager.stopScan()
        print("BLE Stop Scan")
        
        if connectPeripheral != nil {
            if connectPeripheral.identifier.uuidString != bleFindPeripheral[indexPath.row]?.identifier.uuidString {
                if self.connectPeripheral != nil {
                    //取消连接 有蓝牙连接的时候
                    centralManager.cancelPeripheralConnection(connectPeripheral)
                }
                
            }
        }
        centralManager.connect(bleFindPeripheral[indexPath.row]!, options: nil)
    }
    
    
    
    
    
    
    
    // BLE func
    func centralManagerDidUpdateState(_ cManager: CBCentralManager) {
        let nsmString = NSMutableString (string: "UpdateState")
        switch cManager.state {
        case .unknown:
            nsmString .append("Unknown\n")
        case .unsupported:
            nsmString .append("Unsupported\n")
        case .unauthorized:
            nsmString .append("Unauthorized\n")
        case .resetting:
            nsmString .append("Resetting\n")
        case .poweredOff:
            nsmString .append("PoweredOff\n")
        case .poweredOn:
            nsmString .append("PoweredOn\n")
        }
        
        print("Central BLE State = ", nsmString)
        guard cManager.state == .poweredOn else {
            return
        }
        
        
    }
    
    
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        // 阻擋開發者的藍芽滑鼠訊號
        guard peripheral.identifier.uuidString != "994C005F-874E-187F-7B3E-F94D6EEC7079" else {
            return
        }
        
        guard peripheral.name != nil else {
            return
        }
        
        print("UUID: " + peripheral.identifier.uuidString)
        print("Name: \(peripheral.name!)")
        print("RSSI: \(RSSI)\n")
        /*
        guard peripheral.name == "ugolazy_CaliperReader" else {
            return
        }*/
        
        for i in 0 ..< bleDeviceUUIDList.count {
            if bleDeviceUUIDList[i] == peripheral.identifier.uuidString {
                bleDeviceRSSIList[i] = RSSI
                DispatchQueue.main.async(){
                    self.tableViewBle.reloadData()
                }
                print("New RSSI: \(RSSI)\n")
                return
            }
        }
        bleFindPeripheral.append(peripheral)
        bleDeviceNameList.append(peripheral.name!)
        bleDeviceUUIDList.append(peripheral.identifier.uuidString)
        bleDeviceRSSIList.append(RSSI)
        
        for i in 0 ..< bleDeviceUUIDList.count {
            print("\(bleDeviceNameList[i]) \(bleDeviceUUIDList[i]) \(bleDeviceRSSIList[i])")
        }
        DispatchQueue.main.async(){
            self.tableViewBle.reloadData()
        }

        
        
        
        
        
    }
    
    
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connect To: \(peripheral.name!)\nUUID: \(peripheral.identifier.uuidString)\n")
        
        uuid = peripheral.identifier
        connectPeripheral = peripheral
        connectPeripheral.delegate = self
        
        peripheral.discoverServices(nil)
    }
    
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard error == nil else {
            print("ERROR: \(#file, #function)")
            print("Service discovery was unsuccessfull !\n");
            return
        }
        
        print("didDiscoverServices: \(peripheral.identifier.uuidString)")
        print("===== \(peripheral.services!.count) of service for UUID \(peripheral.identifier.uuidString) =====")
        for service in peripheral.services! {
            print("Service found with UUID: \(service.uuid)");
            connectPeripheral.discoverCharacteristics(nil, for: service)
        }
        print("")
    }
    
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard error == nil else {
            print("ERROR: \(#file, #function)")
            print("Characteristic discorvery unsuccessfull !\n")
            return
        }
        print("=========== \(service.characteristics!.count) Characteristics of \(service.uuid) service ")
        for characteristic in service.characteristics!
        {
            print(characteristic.uuid)
            if characteristic.uuid.uuidString == UUID_BLE_READ
            {
                peripheral.setNotifyValue(true, for: characteristic)
            }
            else if characteristic.uuid.uuidString == UUID_BLE_WRITE
            {
                WriteCharacteristic = characteristic
            }
        }
        print("")
        
        
        
        DispatchQueue.main.async(){
            
            self.viewScanBle.isHidden = true
            self.btnBleScan.setTitle("Scan", for: .normal)
            
            self.bleFindPeripheral.removeAll()
            self.bleDeviceNameList.removeAll()
            self.bleDeviceUUIDList.removeAll()
            self.bleDeviceRSSIList.removeAll()
            self.tableViewBle.reloadData()
            //self.labelBleDeviceInfo.text = "Device: Connected"
            self.btnReadE0.isEnabled = true
            self.btnBleConnect.setTitle("Disconnect", for: .normal)
        }
        
        
        
        
    }
    
    func _CheckADCVal(ADC: UInt16) -> Double {
        print(_CheckADCVal)
        //ADC=3971;
        var ADCV : Double = 0
        if(Double(ADC) <= ADCMap[ADCMap.count-1][0]) {
            ADCV = ADCMap[ADCMap.count-1][1]
        }
        else if(Double(ADC) >= ADCMap[0][0])
        {
            ADCV = ADCMap[0][1]
        }
        else
        {
            //for var i = 0 ; i < ADCMap.count ; i++ {
            for i in stride(from: 0, to: ADCMap.count, by: 1){
                if(Double(ADC)>=ADCMap[i][0])
                {
                    ADCV=ADCMap[i][1]
                    break;
                }
            }
        }
        return ADCV;

        //return Double(ADC)/100
    }
    
    func _CheckT2Val(T2: UInt16) -> Double {
    
    
        var t2Val : Double = 0;
        if(Double(T2) <= T2Map[T2Map.count-1][0])
        {
            t2Val=T2Map[T2Map.count-1][1];
        }
        else if(Double(T2) >= T2Map[0][0])
        {
            t2Val=T2Map[0][1];
        }
        else
        {
            //for(int i=0;i<T2Map.length;i++) {
            for i in stride(from: 0, to: T2Map.count, by: 1) {
                if(Double(T2) >= T2Map[i][0])
                {
                    t2Val=T2Map[i][1];
                    break;
                }
            }
        }
        return t2Val;
    }

    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            print("ERROR: \(#file, #function)")
            print(error.debugDescription)
            return
        }
        let data = characteristic.value! as NSData
        print("zxb_data")
        print("====\(data)")
        
        if(data.length>12)
        {
            var ADC : UInt16 = 0
            var T1 : UInt16 = 0
            var T2 : UInt16 = 0
            var fADCVal : Double = 0
            var fT1Val : Double = 0
            var fT2Val : Double = 0

            //data.getBytes(&value,start:8, length: 2)
            data.getBytes(&ADC,range: NSRange(location: 8, length: 2))
            ADC = UInt16(bigEndian: ADC)
            //ADC = 205
            fADCVal = _CheckADCVal(ADC: ADC)
            print(ADC)
            data.getBytes(&T1,range: NSRange(location: 10, length: 2))
            T1 = UInt16(bigEndian: T1)
            fT1Val=1000000/Double(T1);
            print(T1)
            data.getBytes(&T2,range: NSRange(location: 12, length: 2))
            T2 = UInt16(bigEndian: T2)
            fT2Val = _CheckT2Val(T2: T2)
            print(T2)
            DispatchQueue.main.async(){
                let str = String(format: "ADC:%d=%.2f", ADC,fADCVal)
                self.labelADCData.text = str
                let str1 = String(format: "T1:%d=%.2f", T1,fT1Val)
                self.labelT1Data.text = str1
                let str2 = String(format: "T2:%d=%.2f", T2,fT2Val)
                self.labelT2Data.text = str2
            }
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnect")
        
        
        
        DispatchQueue.main.async(){
            //self.labelBleDeviceInfo.text = "Device: Not Connected"
            self.btnReadE0.isEnabled = false
            
            self.btnBleConnect.setTitle("Connect", for: .normal)
        }
        
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("Connect Fail")
        
        DispatchQueue.main.async(){
            //self.labelBleDeviceInfo.text = "Device: Not Connected"
            self.btnReadE0.isEnabled = false
            self.btnBleConnect.setTitle("Connect", for: .normal)
        }
    }
    
    
    
    @IBAction func dismissCon(_ sender: UIButton){
        print("dismiss")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ConnectToBle(_ sender: UIButton) {
        self.view.endEditing(true)
        if viewScanBle.isHidden == true {
            viewScanBle.isHidden = false

            self.centralManager.scanForPeripherals(withServices: nil, options: nil)
            print("BLE Scan")
            btnBleScan.setTitle("Stop Scan", for: .normal)
        } else {
            viewScanBle.isHidden = true
            centralManager.stopScan()
            print("BLE Stop Scan")
            btnBleScan.setTitle("Scan", for: .normal)
            
            bleFindPeripheral.removeAll()
            bleDeviceNameList.removeAll()
            bleDeviceUUIDList.removeAll()
            bleDeviceRSSIList.removeAll()
            
            DispatchQueue.main.async(){
                self.tableViewBle.reloadData()
            }
        }
        
        if btnBleConnect.titleLabel?.text == "Disconnect" {
            if self.connectPeripheral != nil {
                centralManager.cancelPeripheralConnection(connectPeripheral)
            }
        }
        
        
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction (name: kCAMediaTimingFunctionLinear)
        transition.type = kCATransitionFade
        
        viewScanBle.layer.add(transition, forKey: nil)
    }
    
    
    @IBAction func ScanBleDevice(_ sender: UIButton) {
        if btnBleScan.titleLabel?.text == "Scan" {
            btnBleScan.setTitle("Stop Scan", for: .normal)
            self.centralManager.scanForPeripherals(withServices: nil, options: nil)
            print("BLE Scan")
        } else if btnBleScan.titleLabel?.text == "Stop Scan" {
            btnBleScan.setTitle("Scan", for: .normal)
            centralManager.stopScan()
            print("BLE Stop Scan")
        }
        
    }
    
//    @IBAction func ReadFromBle(_ sender: UIButton) {
    @IBAction func SendE0(_ sender: UIButton) {
        let TxNSData = NSData(bytes: [0xA5, 0xE0, 0x01,0x86] as [UInt8], length: 4)
        //connectPeripheral.writeValue(TxNSData as Data, for: WriteCharacteristic, type: .withoutResponse)
        connectPeripheral.writeValue(TxNSData as Data, for: WriteCharacteristic, type: .withResponse)
    }
    @IBAction func SendE1(_ sender: UIButton) {
        
        //let TxNSData = NSData(bytes: [0xA5, 0xE1, 0x03, 0x00, 0x14,0x9D] as [UInt8], length: 6)
        //var TxNSData = Data(bytes: [0xA5, 0xE1, 0x03, 0x00, 0x14,0x9D] as [UInt8], length: 6)
        var TxNSData = Data(bytes: [0xA5, 0xE1, 0x03, 0x00, 0x14,0x9D])
        let d = Double(textFieldSecond.text!)!*10
        let a = UInt16(d)
        print(a)
        //TxNSData[4] = a%0x100
        TxNSData[4] = UInt8(a & 0x00FF)
        var ii: UInt16 = 0//(0xA5+0xE1+0x03+0x00+0x05)%0x100
        for element in TxNSData {
            //print(element)
            ii += UInt16(element)
        }
        ii -= UInt16(TxNSData[5])
        TxNSData[5] = UInt8(ii & 0x00FF)
        //connectPeripheral.writeValue(TxNSData as Data, for: WriteCharacteristic, type: .withoutResponse)
        connectPeripheral.writeValue(TxNSData as Data, for: WriteCharacteristic, type: .withResponse)
    }
    @IBAction func SendE3(_ sender: UIButton) {
        let TxNSData = NSData(bytes: [0xA5, 0xE3, 0x01, 0x89] as [UInt8], length: 4)
        //connectPeripheral.writeValue(TxNSData as Data, for: WriteCharacteristic, type: .withoutResponse)
        connectPeripheral.writeValue(TxNSData as Data, for: WriteCharacteristic, type: .withResponse)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField BeginEditing")
        viewScanBle.isHidden = true
        
        UIView.animate(withDuration: 0.50, animations: {
            //self.viewTextField.center.y = self.view.center.y
            self.textFieldSecond.center.y = self.view.center.y
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        /*
        print("textField EndEditing")
        if(Double(textFieldUpLimit.text!) != nil && Double(textFieldDownLimit.text!) != nil) {
            if Double(textFieldDownLimit.text!)! > Double(textFieldUpLimit.text!)! {
                let temp = textFieldDownLimit.text
                textFieldDownLimit.text = textFieldUpLimit.text
                textFieldUpLimit.text = temp
            }
        }*/
        UIView.animate(withDuration: 0.50, animations: {
            self.textFieldSecond.center.y = self.viewTextFieldBeforeCenterY
        })
    }
    
    
    @IBAction func CloseKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    
    
}

