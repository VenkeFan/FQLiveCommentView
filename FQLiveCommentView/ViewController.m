//
//  ViewController.m
//  FQLiveCommentView
//
//  Created by fanqi on 17/7/25.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "ViewController.h"
#import "FQLiveCommentView.h"
#import "FQLiveCommentViewModel.h"

@interface ViewController ()

@property (nonatomic, strong) FQLiveCommentView *commentView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layoutUI];
    
    
    [self didReceiveMessage:self.dataArray];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)layoutUI {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.view.bounds;
    layer.colors = @[(__bridge id)[UIColor colorWithWhite:0 alpha:0.5].CGColor, (__bridge id)[UIColor colorWithWhite:1 alpha:0.2].CGColor];
    layer.startPoint = CGPointMake(0.5, 1.0);
    layer.endPoint = CGPointMake(0.5, 0.0);
    [self.view.layer addSublayer:layer];
    
    
    [self.view addSubview:self.commentView];
}

#pragma mark - 模拟收到消息

static int i = 0;
- (void)didReceiveMessage:(NSArray *)messages {
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(timerStep) userInfo:nil repeats:YES];
}

- (void)timerStep {
    // 这里注意数组长度越界
    if (i < self.dataArray.count) {
        if (i == 2) {
            [self p_addComments:@[self.dataArray[i], self.dataArray[i + 1]]];
            i += 2;
        } else if (i == 5) {
            [self p_addComments:@[self.dataArray[i], self.dataArray[i + 1], self.dataArray[i + 2], self.dataArray[i + 3]]];
            i += 4;
        } else {
            [self p_addComments:@[self.dataArray[i]]];
            i++;
        }
    }
}

- (void)p_addComments:(NSArray *)array {
    [self.commentView addComments:array];
}

#pragma mark - Getter

- (FQLiveCommentView *)commentView {
    if (!_commentView) {
        CGFloat x = 20, height = 260;
        CGFloat width = self.view.frame.size.width - x * 2;
        CGFloat y = self.view.frame.size.height - height - 20;
        
        _commentView = [[FQLiveCommentView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    }
    return _commentView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray array];
        for (NSInteger i = 0; i < 10; i++) {
            
            NSString *str;
            if (i % 2 == 0) {
                str = [NSString stringWithFormat:@"这是测试评论消息 -- %zd", i];
            } else {
                str = [NSString stringWithFormat:@"这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息这是测试评论消息 -- %zd", i];
            }
            
            FQLiveCommentViewModel *cmtViewModel = [FQLiveCommentViewModel viewModelWithUserName:[NSString stringWithFormat:@"番茄%zd", i]
                                                                                         comment:str];
            [_dataArray addObject:cmtViewModel];
        }
        
    }
    return _dataArray;
}

@end
