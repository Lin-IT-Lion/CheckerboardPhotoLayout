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

//间隔比列为宽度的百分比 最小为-overlapRatio 最大为 1
@property (nonatomic, assign) CGFloat spaceRatio;

//x偏移百分比 -1/2.f到 1/2.f之间 宽度的比列
@property (nonatomic, assign) CGFloat xOffestRatio;

//y偏移百分比 -1/2.f到 1/2.f之间 高度的比列
@property (nonatomic, assign) CGFloat yOffestRatio;


@property (nonatomic, assign) CGRect canvasFrame;

@property (nonatomic, assign) CGFloat chessAngle;

@property (nonatomic, assign) CGFloat boardAngle;

@end


@interface CBLayoutHelper : NSObject


/**
 二维数组，最里面是个字典 提供
 point 位置
 ...
 */
@property (nonatomic, strong, readonly) NSMutableArray<NSMutableArray<NSDictionary *> *> *pointList;
@property (nonatomic, strong, readonly) CBLayoutHelperConfig *config;
@property (nonatomic, assign, readonly) CGSize singleSize;

+ (instancetype)layoutHelperWithConfig:(CBLayoutHelperConfig *)config;

- (void)resetWithItemSize:(CGSize)size;

//+ (instancetype)layoutHelperWithFile:(NSString *)fileName;
//
//+ (instancetype)layoutHelperWithDict:(NSDictionary *)dict;

- (CGRect)loadFrameWithIndex:(NSInteger)index;



@end
