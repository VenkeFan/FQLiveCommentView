//
//  FQLiveCommentViewModel.m
//  FQLiveCommentView
//
//  Created by fanqi on 17/7/25.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import "FQLiveCommentViewModel.h"

@interface FQLiveCommentViewModel ()

@property (nonatomic, copy, readwrite) NSString *userName;
@property (nonatomic, copy, readwrite) NSString *comment;

@end

@implementation FQLiveCommentViewModel

+ (instancetype)viewModelWithUserName:(NSString *)userName comment:(NSString *)comment {
    FQLiveCommentViewModel *viewModel = [[FQLiveCommentViewModel alloc] init];
    viewModel.userName = userName;
    viewModel.comment = comment;
    return viewModel;
}

@end
