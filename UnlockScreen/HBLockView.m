//
//  HBLockView.m
//  UnlockScreen
//
//  Created by bottle on 15-4-27.
//  Copyright (c) 2015年 bottle. All rights reserved.
//

#import "HBLockView.h"
#import "HBCircleView.h"
#define  Total_Btns 9

@interface HBLockView()
@property (nonatomic,strong) NSMutableArray *selectedBtns;
@property (nonatomic,assign) CGPoint currentPoint;
@end

@implementation HBLockView

- (NSMutableArray *)selectedBtns {
    if (_selectedBtns == nil) {
        _selectedBtns = [NSMutableArray array];
    }
    return _selectedBtns;
}

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
    //放置9个按钮
    for (int i=0; i < Total_Btns; i ++) {
        HBCircleView *btn = [HBCircleView buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [self addSubview:btn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnW = 74;
    CGFloat btnH = btnW;
    CGFloat marginX = ([UIScreen mainScreen].bounds.size.width  - btnW *3) /4;
    CGFloat marginY = (self.frame.size.height - btnH*3) /4;
    for (int i=0; i<self.subviews.count; i ++) {
        int row = i / 3;
        int col = i % 3;
        CGFloat btnX = marginX + col * (btnW + marginX);
        CGFloat btnY = marginY + row * (btnH + marginY);
        HBCircleView *btn = self.subviews[i];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}

- (CGPoint)pointInTouch:(NSSet *)touches {
    UITouch *touch = [touches anyObject];
    return  [touch locationInView:touch.view];
}
- (HBCircleView*)buttonWithPoint:(CGPoint)point {
    for (HBCircleView *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
    }
    return nil;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [self pointInTouch:touches];
    self.currentPoint = pt;
    HBCircleView *btn = [self buttonWithPoint:pt];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectedBtns addObject:btn];
    }
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint pt = [self pointInTouch:touches];
    HBCircleView *btn = [self buttonWithPoint:pt];
    if (btn && btn.selected == NO) {
        btn.selected = YES;
        [self.selectedBtns addObject:btn];
    }else {
        self.currentPoint = pt;
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSMutableString *path = [NSMutableString string];
    for (int i=0 ;i< self.selectedBtns.count ;i++) {
        HBCircleView *btn = self.selectedBtns[i];
        btn.selected = NO;
        [path appendFormat:@"%d",btn.tag];
    }
    [self.selectedBtns removeAllObjects];
    if ([self.delegate respondsToSelector:@selector(lockView:lockPath:)]) {
        [self.delegate lockView:self lockPath:path];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    if(self.selectedBtns.count == 0) return;
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 10;
    path.lineJoinStyle = kCGLineJoinRound;
    [[UIColor greenColor] set];
    
    //[path moveToPoint:CGPointZero];
    for (int i=0; i <self.selectedBtns.count; i++) {
        HBCircleView *btn = self.selectedBtns[i];
        if (i==0) {
            [path moveToPoint:btn.center];
        }else {
            [path addLineToPoint:btn.center];
        }
    }
    
    [path addLineToPoint:self.currentPoint];
    [path stroke];
}

@end
