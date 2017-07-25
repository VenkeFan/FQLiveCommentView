//
//  FQLiveCommentViewModel.h
//  FQLiveCommentView
//
//  Created by fanqi on 17/7/25.
//  Copyright © 2017年 fanqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FQLiveCommentViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *comment;

+ (instancetype)viewModelWithUserName:(NSString *)userName comment:(NSString *)comment;

@end
