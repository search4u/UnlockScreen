//
//  HBLockView.h
//  UnlockScreen
//
//  Created by bottle on 15-4-27.
//  Copyright (c) 2015年 bottle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBLockView;
@protocol HBLockViewDelegate <NSObject>

@optional
- (void)lockView:(HBLockView*)lockView lockPath:(NSString*)path;

@end

@interface HBLockView : UIView

@property (nonatomic,weak) id<HBLockViewDelegate> delegate;

@end
