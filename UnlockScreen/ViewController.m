//
//  ViewController.m
//  UnlockScreen
//
//  Created by bottle on 15-4-27.
//  Copyright (c) 2015年 bottle. All rights reserved.
//

#import "ViewController.h"
#import "HBLockView.h"
@interface ViewController ()<HBLockViewDelegate>
@property (weak, nonatomic) IBOutlet HBLockView *lockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lockView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)lockView:(HBLockView *)lockView lockPath:(NSString *)path {
    NSLog(path);
}

@end
