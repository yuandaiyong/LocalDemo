//
//  ViewController.m
//  LocalDemo
//
//  Created by Clover on 2018/5/16.
//  Copyright © 2018年 yuandaiyong. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "NSBundle+Language.h"
@interface ViewController ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic,strong) UITableView            *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect rect = [[UIScreen mainScreen] bounds];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, CGRectGetWidth(rect) - 10, 30)];
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    label.text = NSLocalizedString(@"hello", nil);
    label.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:label];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), CGRectGetWidth(rect), CGRectGetHeight(rect) - CGRectGetMaxY(label.frame)) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"tableViewCellIdentifier"];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewCellIdentifier"];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor blackColor];
        CGRect rect = [[UIScreen mainScreen] bounds];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, CGRectGetWidth(rect), 1)];
        lineView.backgroundColor = [UIColor colorWithRed:200 / 255. green:200 / 255. blue:200 / 255. alpha:1];
        [cell.contentView addSubview:lineView];
        
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"英文";
            break;
        }
        case 1:
        {
            cell.textLabel.text = @"中文";
            break;
        }
        case 2:
        {
            cell.textLabel.text = @"韩文";
            break;
        }
        case 3:
        {
            cell.textLabel.text = @"日文";
            break;
        }
        default:
        break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [userDefaults arrayForKey:@"AppleLanguages"];
    NSString *language = [languages firstObject];
    switch (indexPath.row) {
        case 0:
        {
            language = @"en";
            break;
        }
        case 1:
        {
            language = @"ZH-Hans-CN";
            break;
        }
        case 2:
        {
            language = @"ko";
            break;
            
        }
        case 3:
        {
            language = @"ja";
            break;
            
        }
        default:
            break;
    }
    // 设置语言
    [NSBundle setLanguage:language];
    
    [userDefaults setObject:language forKey:@"myLanguage"];
    [userDefaults synchronize];
    
    ViewController *tab = [[ViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
    
}
@end
