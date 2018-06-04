//
//  AddressBookHandle.h
//  collectionIos
//
//  Created by Mac on 2018/1/11.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#ifdef __IPHONE_9_0
#import <Contacts/Contacts.h>
#endif
#import <AddressBook/AddressBook.h>

#import "ADPersonModel.h"
#import "ABSingleton.h"

#define IOS9_LATER ([[UIDevice currentDevice] systemVersion].floatValue > 9.0 ? YES : NO )

/** 一个联系人的相关信息*/
typedef void(^PersonModelBlock) (ADPersonModel *model);

/** 授权失败的Block*/
typedef void (^AuthorizatationFailure)(void);


@interface AddressBookHandle : NSObject

ABSingletonH(AddressBookHandle)

/**
 请求用户通讯录授权
 
 @param success 授权成功的回调
 */
-(void)requestAuthorizationWithSuccessBlock:(void(^)(void))success;

/**
 *  返回每个联系人的模型
 *
 *  @param personModel 单个联系人模型
 *  @param failure     授权失败的Block
 */

-(void)getAddressBookDataSource:
    (PersonModelBlock)personModel
           authorizationFailure:
(AuthorizatationFailure)failure;

@end
