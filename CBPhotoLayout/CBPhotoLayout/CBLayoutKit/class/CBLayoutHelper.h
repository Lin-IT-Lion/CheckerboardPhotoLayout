//
//  CBLayoutHelper.h
//  CBPhotoLayout
//
//  Created by 幸.😳 on 2018/7/28.
//  Copyright © 2018年 林国强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CBLayoutHelperConfig : NSObject

/**
 图片 这里类比成棋子
 */
@property (nonatomic, strong) UIImage *chess;

@property (nonatomic, assign) CGFloat spaceRatio;

@property (nonatomic, assign) CGFloat xOffset;

@property (nonatomic, assign) CGFloat yOffset;

@property (nonatomic, assign) CGFloat chessAngle;

@property (nonatomic, assign) CGFloat boardAngle;

@end


@interface CBLayoutHelper : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *pointList;
@property (nonatomic, strong, readonly) CBLayoutHelperConfig *config;
@property (nonatomic, assign, readonly) CGSize singleSize;

+ (instancetype)layoutHelperWithConfig:(CBLayoutHelperConfig *)config;

//+ (instancetype)layoutHelperWithFile:(NSString *)fileName;
//
//+ (instancetype)layoutHelperWithDict:(NSDictionary *)dict;

- (CGRect)loadFrameWithIndex:(NSInteger)index;



@end
