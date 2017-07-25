//
//  FQLiveBarrageContentView.h
//  chongchongtv
//
//  Created by fanqi on 17/7/19.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FQLiveBarrageContentView;

typedef NS_ENUM(NSInteger, FQLiveBarrageContentViewStatus) {
    FQLiveBarrageContentViewStatus_Prepare,         /**< 准备显示 */
    FQLiveBarrageContentViewStatus_WillDisplay,     /**< 将要显示 */
    FQLiveBarrageContentViewStatus_Enter,           /**< 完全显示 */
    FQLiveBarrageContentViewStatus_End              /**< 完全消失 */
};

@protocol FQLiveBarrageContentViewDelegate <NSObject>

- (void)liveBarrageContentView:(FQLiveBarrageContentView *)contentView statusDidChanged:(FQLiveBarrageContentViewStatus)status;

@end

@interface FQLiveBarrageContentView : UIView

- (instancetype)initWithFrame:(CGRect)frame referHeight:(CGFloat)referHeight;

@property (nonatomic, assign, readonly) FQLiveBarrageContentViewStatus status;
@property (nonatomic, weak) id<FQLiveBarrageContentViewDelegate> delegate;

- (void)startAnimation;

@end
