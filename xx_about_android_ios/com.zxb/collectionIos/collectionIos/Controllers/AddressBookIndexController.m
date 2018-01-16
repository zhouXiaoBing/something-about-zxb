//
//  AddressBookIndexController.m
//  collectionIos
//
//  Created by Mac on 2018/1/10.
//  Copyright © 2018年 Vitagou. All rights reserved.
//

#import "AddressBookIndexController.h"
#import "AddressBook.h"
#import "ADPersonModel.h"

#define START NSDate *startTime = [NSDate date]
#define END NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

@interface AddressBookIndexController ()

@property (nonatomic, copy) NSArray *keys;//功能索引

@property (nonatomic, copy) NSDictionary *contactPeople;

@end


@implementation AddressBookIndexController

-(void)viewDidLoad{

    [super viewDidLoad];
    NSLog(@"enter A~Z顺序排列通讯录!!!");
    self.navigationItem.title = @"A~Z顺序排列通讯录";
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0, 0, 80, 80);
    indicator.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.5-80);
    indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    indicator.clipsToBounds = YES;
    indicator.layer.cornerRadius = 6;
    [indicator startAnimating];
    [self.view addSubview:indicator];
    
    //获取按名字联系人姓名首字母拼音A~Z排序（已经对姓名的第二个字做了处理）
    [AddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict,NSArray *nameKeys){
//        NSLog(@"AddressBookIndexController:namekeys的数量 %lu",(unsigned long)nameKeys.count);
        [indicator stopAnimating];
        //装着所有联系人的字典
        self.contactPeople = addressBookDict;
        
        //联系人分组按拼音的key值
        self.keys = nameKeys;
        
        [self.tableView reloadData];
    } authorizationFailure:^{
        //alert弹出提示 未获得通讯录访问的额权限
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"需要通讯录权限" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
    }];
    
    self.tableView.rowHeight = 60;
}

#pragma mark - TableViewDatasouce/TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = _keys[section];
    return [_contactPeople[key] count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _keys[section];
}

//右侧的索引
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    NSString *key = _keys[indexPath.section];
    ADPersonModel *people = [_contactPeople[key] objectAtIndex:indexPath.row];
    
    cell.imageView.image = people.headerImage ? people.headerImage : [UIImage imageNamed:@"tab_normal"];
//    cell.imageView.layer.cornerRadius = 60/2; //切圆角
    cell.imageView.clipsToBounds = YES;
    cell.textLabel.text = people.name;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *key = _keys[indexPath.section];
    ADPersonModel *people = [_contactPeople[key] objectAtIndex:indexPath.row];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;//文字模式
    hud.label.text =[NSString stringWithFormat:@"号码:%@",people.mobileArray];
    [hud hideAnimated:YES afterDelay:1.f];
}


@end
