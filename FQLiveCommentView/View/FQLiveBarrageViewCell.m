//
//  FQLiveBarrageViewCell.m
//  chongchongtv
//
//  Created by fanqi on 17/7/13.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQLiveBarrageViewCell.h"
#import "FQLiveCommentViewModel.h"

#define ImageWidth          40

@interface FQLiveBarrageViewCell ()

@property (nonatomic, strong) FQLiveCommentViewModel *viewModel;

@end

@implementation FQLiveBarrageViewCell

- (instancetype)initWithFrame:(CGRect)frame viewModel:(FQLiveCommentViewModel *)viewModel {
    if (self = [super initWithFrame:frame]) {
        _viewModel = viewModel;
        
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI {
    CGFloat y = 5, x = 0, paddingX = 5, paddingY = 5;
    
    NSMutableAttributedString *mutAttr = nil;
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    shadow.shadowOffset = CGSizeMake(0, 3);
    shadow.shadowBlurRadius = 5;
    
    UILabel *nameLab = [[UILabel alloc] initWithFrame:CGRectMake(x, paddingY, CGRectGetWidth(self.frame) - x - paddingX, 0)];
//    nameLab.text = self.viewModel.userName;
    
    mutAttr = [[NSMutableAttributedString alloc] initWithString:self.viewModel.userName];
    [mutAttr setAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                             NSFontAttributeName: [UIFont systemFontOfSize:12],
                             NSShadowAttributeName: shadow}
                     range:NSMakeRange(0, mutAttr.length)];
    nameLab.attributedText = mutAttr;
    
    nameLab.textColor = [UIColor whiteColor];
    nameLab.font = [UIFont systemFontOfSize:12];
    [nameLab sizeToFit];
    
    [self addSubview:nameLab];
    y = nameLab.frame.origin.y + CGRectGetHeight(nameLab.frame) + paddingY;
    
    UILabel *cmtLab = [[UILabel alloc] initWithFrame:CGRectMake(x, y, CGRectGetWidth(self.frame) - x - paddingX, 0)];
//    cmtLab.text = self.viewModel.comment;
    
    mutAttr = [[NSMutableAttributedString alloc] initWithString:self.viewModel.comment];
    [mutAttr setAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                             NSFontAttributeName: [UIFont systemFontOfSize:12],
                             NSShadowAttributeName: shadow}
                     range:NSMakeRange(0, mutAttr.length)];
    cmtLab.attributedText = mutAttr;
    
    cmtLab.textColor = [UIColor whiteColor];
    cmtLab.font = [UIFont systemFontOfSize:12];
    cmtLab.numberOfLines = 0;
    [cmtLab sizeToFit];
    
    [self addSubview:cmtLab];
    y += CGRectGetHeight(cmtLab.frame) + paddingY * 2;
    
    
    CGRect frame = self.frame;
    frame.size.height = y;
    self.frame = frame;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CGPoint point = [[touches anyObject] locationInView:self];
//    if ([self.layer.presentationLayer hitTest:point]) {
//        NSLog(@"presentationLayer: %.2f -- %.2f / layer: %.2f -- %.2f",
//              self.layer.presentationLayer.position.x,
//              self.layer.presentationLayer.position.y,
//              self.layer.position.x,
//              self.layer.position.y);
//    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(liveBarrageViewCell:didSelectWithViewModel:)]) {
        [self.delegate liveBarrageViewCell:self didSelectWithViewModel:self.viewModel];
    }
}

@end
