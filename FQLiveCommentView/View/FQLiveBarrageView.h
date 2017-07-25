//
//  FQLiveBarrageView.h
//  chongchongtv
//
//  Created by fanqi on 17/7/18.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FQLiveBarrageView : UIView

@property (nonatomic, assign, getter=isAnimationPaused) BOOL animationPaused;

- (void)addBulletArray:(NSArray *)bulletArray;

@end
