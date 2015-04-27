//
//  HBCircleView.m
//  UnlockScreen
//
//  Created by bottle on 15-4-27.
//  Copyright (c) 2015年 bottle. All rights reserved.
//

#import "HBCircleView.h"

@implementation HBCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.userInteractionEnabled = NO;
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
    //[self setBackgroundColor:[UIColor blueColor]];
}
@end
