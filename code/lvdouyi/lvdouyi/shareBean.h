//
//  shareBean.h
//  lvdouyi
//
//  Created by Mac on 2018/9/12.
//  Copyright © 2018年 vitagou. All rights reserved.
/*
 {"title":"被“烟”包围的中国女人，应该如何自救？",
 "icon":"http://s5.inbjo.com/views/mobile/skin/default/images/lvdouyi_01.jpg",
 "description":"速溶罗汉果茶，即冲即用，出差办公之选  方便快捷",
 "url":"http://s5-test.vitagou.com/site/products/id/279/recommend/LDY11763422"}
 */
@interface shareBean :NSObject

@property (nonatomic,strong) NSString *title;

@property (nonatomic,strong) NSString *icon;

@property (nonatomic,strong) NSString *description;

@property (nonatomic,strong) NSString *url;

@end
