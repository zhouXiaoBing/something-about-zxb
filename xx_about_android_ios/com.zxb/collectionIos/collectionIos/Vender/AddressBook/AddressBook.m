//
//  AddressBook.m
//  collectionIos
//
//  Created by Mac on 2018/1/11.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#import "AddressBook.h"

#define kAddressBookHandle [AddressBookHandle sharedAddressBookHandle]

#define START NSDate *startTime = [NSDate date]
#define END NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

@implementation AddressBook

+(void)requestAddressBookAuthorization{
    
    [kAddressBookHandle requestAuthorizationWithSuccessBlock:^{
        [self getOrderAddressBook:nil authorizationFailure:nil];
    }];
}

+ (void)initialize
{
    [self getOrderAddressBook:nil authorizationFailure:nil];
}

#pragma mark -获取原始顺序所有联系人
+(void)getOriginalAddressBook:(AddressBookArrayBlock)addressBookArray authorizationFailure:(AuthorizatationFailure)failure{
    //将耗时操作放到子线程
    dispatch_queue_t queue = dispatch_queue_create("addressBook.array", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSMutableArray *array = [NSMutableArray array];
        [kAddressBookHandle getAddressBookDataSource:^(ADPersonModel *model){
            [array addObject:model];
        } authorizationFailure:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                failure ? failure() : nil;
            });
        }];
        // 将联系人数组回调到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            addressBookArray ? addressBookArray(array) : nil ;
        });
    });
}

#pragma mark - 获取按A~Z顺序排列的所有联系人
+(void)getOrderAddressBook:(AddressBookDictBlock)addressBookInfo authorizationFailure:(AuthorizatationFailure)failure{
    
    //将耗时的操作放到子线程
    dispatch_queue_t queue = dispatch_queue_create("", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSMutableDictionary *addressBookDict = [NSMutableDictionary dictionary];
        [kAddressBookHandle getAddressBookDataSource:^(ADPersonModel *model){
            ////获取到姓名的大写首字母
            NSString *firstLetterString = [self getFirstLetterFromString:model.name];
            //如果该字母对应的联系人模型不为空,则将此联系人模型添加到此数组中
            if (addressBookDict[firstLetterString])
            {
                [addressBookDict[firstLetterString] addObject:model];
            }
            //没有出现过该首字母，则在字典中新增一组key-value
            else
            {
                //创建新发可变数组存储该首字母对应的联系人模型
                NSMutableArray *arrGroupNames = [NSMutableArray arrayWithObject:model];
                
                [arrGroupNames addObject:model];
                //将首字母-姓名数组作为key-value加入到字典中
                [addressBookDict setObject:arrGroupNames forKey:firstLetterString];
            }
        } authorizationFailure:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                failure ? failure() : nil;
            });
        }];
        // 将addressBookDict字典中的所有Key值进行排序: A~Z
        NSArray *nameKeys = [[addressBookDict allKeys]sortedArrayUsingSelector:@selector(compare:)];
        
        //将 "#" 排列在 A~Z 的后面
        if ([nameKeys.firstObject isEqualToString:@"#"]) {
            
            NSMutableArray *mutableNamekeys = [NSMutableArray arrayWithArray:nameKeys];
            [mutableNamekeys insertObject:nameKeys.firstObject atIndex:nameKeys.count];
            [mutableNamekeys removeObjectAtIndex:0];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                addressBookInfo ? addressBookInfo(addressBookDict,mutableNamekeys) : nil;
            });
            return;
        }
    });
}

#pragma mark - 获取联系人姓名首字母(传入汉字字符串, 返回大写拼音首字母)
+ (NSString *)getFirstLetterFromString:(NSString *)aString
{
    
}

/**
 多音字处理
 */
+ (NSString *)polyphoneStringHandle:(NSString *)aString pinyinString:(NSString *)pinyinString
{
    if ([aString hasPrefix:@"长"]) { return @"chang";}
    if ([aString hasPrefix:@"沈"]) { return @"shen"; }
    if ([aString hasPrefix:@"厦"]) { return @"xia";  }
    if ([aString hasPrefix:@"地"]) { return @"di";   }
    if ([aString hasPrefix:@"重"]) { return @"chong";}
    return pinyinString;
}

@end

