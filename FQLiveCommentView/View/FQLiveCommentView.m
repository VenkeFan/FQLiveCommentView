//
//  FQLiveCommentView.m
//  chongchongtv
//
//  Created by fanqi on 17/7/13.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQLiveCommentView.h"
#import "FQLiveCommentViewModel.h"
#import "FQLiveBarrageView.h"

@interface FQLiveCommentView () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) FQLiveBarrageView *barrageView;

@end

@implementation FQLiveCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self layoutUI];
    }
    return self;
}

#pragma mark - UI

- (void)layoutUI {
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.barrageView];
    
    [self addSubview:self.textField];
}

#pragma mark - Public

- (void)addComments:(NSArray *)comments {
    [self.barrageView addBulletArray:comments];
}

#pragma mark - ViewModel

- (void)postComment:(NSString *)comment {
    if (comment.length == 0) {
        return;
    }
    
    // 向服务器提交评论
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.barrageView addBulletArray:@[[FQLiveCommentViewModel viewModelWithUserName:@"番茄"
                                                                                 comment:self.textField.text]]];
        
        self.textField.text = nil;
    });
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self postComment:textField.text];
    
    return YES;
}

#pragma mark - Getter & Setter

- (FQLiveBarrageView *)barrageView {
    if (!_barrageView) {
        _barrageView = [[FQLiveBarrageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - self.textField.bounds.size.height)];
    }
    return _barrageView;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40)];
        _textField.delegate = self;
        _textField.layer.borderWidth = 1.5;
        _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textField.layer.cornerRadius = 8;
        _textField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"评论"
                                                                                  attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                                               NSFontAttributeName: [UIFont systemFontOfSize:12]}];
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.textColor = [UIColor whiteColor];
        _textField.font = [UIFont systemFontOfSize:12];
        _textField.returnKeyType = UIReturnKeySend;
    }
    return _textField;
}

@end
