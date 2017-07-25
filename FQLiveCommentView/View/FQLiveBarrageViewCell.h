//
//  FQLiveBarrageViewCell.h
//  chongchongtv
//
//  Created by fanqi on 17/7/13.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FQLiveCommentViewModel, FQLiveBarrageViewCell;

@protocol FQLiveBarrageViewCellDelegate <NSObject>

- (void)liveBarrageViewCell:(FQLiveBarrageViewCell *)cell didSelectWithViewModel:(FQLiveCommentViewModel *)viewModel;

@end

@interface FQLiveBarrageViewCell : UIView

@property (nonatomic, weak) id<FQLiveBarrageViewCellDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame viewModel:(FQLiveCommentViewModel *)viewModel;

@end
