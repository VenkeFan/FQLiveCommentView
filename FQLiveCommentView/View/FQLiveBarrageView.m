//
//  FQLiveBarrageView.m
//  chongchongtv
//
//  Created by fanqi on 17/7/18.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQLiveBarrageView.h"
#import "FQLiveBarrageContentView.h"
#import "FQLiveBarrageViewCell.h"
#import "MBProgressHUD.h"

@interface FQLiveBarrageView () <FQLiveBarrageViewCellDelegate, FQLiveBarrageContentViewDelegate>

@property (nonatomic, strong) NSMutableArray<FQLiveBarrageContentView *> *contentViewArray;

@end

@implementation FQLiveBarrageView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark - Public

- (void)addBulletArray:(NSArray *)bulletArray {
    CGFloat y = 0, width = self.bounds.size.width;
    
    FQLiveBarrageContentView *contentView = [[FQLiveBarrageContentView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, width, 0)
                                                                                referHeight:self.frame.size.height];
    contentView.delegate = self;
    [self addSubview:contentView];
    [self.contentViewArray addObject:contentView];
    
    for (int i = 0; i < bulletArray.count; i++) {
        FQLiveBarrageViewCell *cell = [[FQLiveBarrageViewCell alloc] initWithFrame:CGRectMake(0, y, width, 0) viewModel:bulletArray[i]];
        cell.delegate = self;
        [contentView addSubview:cell];
        
        y += cell.frame.size.height;
    }
    
    CGRect frame = contentView.frame;
    frame.size.height = y;
    contentView.frame = frame;
    
    // 这个标记很重要，避免重复调用动画
    if (self.contentViewArray.count == 1) {
        [self.contentViewArray.firstObject startAnimation];
    }
}

#pragma mark - FQLiveBarrageContentViewDelegate

- (void)liveBarrageContentView:(FQLiveBarrageContentView *)contentView statusDidChanged:(FQLiveBarrageContentViewStatus)status {
    switch (status) {
        case FQLiveBarrageContentViewStatus_Prepare:
            
            break;
        case FQLiveBarrageContentViewStatus_WillDisplay:
            
            break;
        case FQLiveBarrageContentViewStatus_Enter: {
            
            NSUInteger index = [self.contentViewArray indexOfObject:contentView];
            if (index + 1 < self.contentViewArray.count) {
                FQLiveBarrageContentView *nextView = self.contentViewArray[index + 1];
                if (nextView.status == FQLiveBarrageContentViewStatus_Prepare) {
                    [nextView startAnimation];
                }
            }
        }
            break;
        case FQLiveBarrageContentViewStatus_End: {
            [contentView removeFromSuperview];
            [self.contentViewArray removeObject:contentView];
        }
            break;
    }
}

#pragma mark - FQLiveBarrageViewCellDelegate

- (void)liveBarrageViewCell:(FQLiveBarrageViewCell *)cell didSelectWithViewModel:(FQLiveCommentViewModel *)viewModel {
    self.animationPaused = YES;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.animationPaused = NO;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"举报成功";
        [hud hideAnimated:YES afterDelay:3.f];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.animationPaused = NO;
    }]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Getter & Setter

- (void)setAnimationPaused:(BOOL)animationPaused {
    _animationPaused = animationPaused;
    
    self.layer.speed = animationPaused ? 0 : 1;
}

- (NSMutableArray<FQLiveBarrageContentView *> *)contentViewArray {
    if (!_contentViewArray) {
        _contentViewArray = [NSMutableArray array];
    }
    return _contentViewArray;
}

@end
