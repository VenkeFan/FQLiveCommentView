//
//  FQLiveBarrageContentView.m
//  chongchongtv
//
//  Created by fanqi on 17/7/19.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQLiveBarrageContentView.h"

@interface FQLiveBarrageContentView () {
    CGFloat _referHeight;
}

@end

@implementation FQLiveBarrageContentView

- (instancetype)initWithFrame:(CGRect)frame referHeight:(CGFloat)referHeight {
    if (self = [super initWithFrame:frame]) {
        _status = FQLiveBarrageContentViewStatus_Prepare;
        _referHeight = referHeight;
    }
    return self;
}

- (void)startAnimation {
    [UIView animateWithDuration:1 / 60.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         if (self.status == FQLiveBarrageContentViewStatus_Prepare) {
                             self.status = FQLiveBarrageContentViewStatus_WillDisplay;
                         }
                         
                         CGRect frame = self.frame;
                         frame.origin.y -= 1.0;
                         self.frame = frame;
                         
                         if (self.frame.origin.y <= (_referHeight - self.frame.size.height)) {
                             self.status = FQLiveBarrageContentViewStatus_Enter;
                         }
                     }
                     completion:^(BOOL finished) {
                         if (self.frame.origin.y <= -self.frame.size.height) {
                             self.status = FQLiveBarrageContentViewStatus_End;
                         } else {
                             [self startAnimation];
                         }
                     }];
}

- (void)setStatus:(FQLiveBarrageContentViewStatus)status {
    _status = status;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(liveBarrageContentView:statusDidChanged:)]) {
        [self.delegate liveBarrageContentView:self statusDidChanged:status];
    }
}

@end
