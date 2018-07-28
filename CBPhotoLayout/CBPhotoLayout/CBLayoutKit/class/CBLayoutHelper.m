//
//  CBLayoutHelper.m
//  CBPhotoLayout
//
//  Created by 幸.😳 on 2018/7/28.
//  Copyright © 2018年 林国强. All rights reserved.
//

#import "CBLayoutHelper.h"

@interface CBLayoutHelperConfig()

@property (nonatomic, assign) CGFloat minWidth;
@property (nonatomic, assign) CGFloat minSpace;

@property (nonatomic, assign) CGFloat overlapRatio;

@property (nonatomic, assign) CGRect canvasFrame;

@end

@implementation CBLayoutHelperConfig

- (instancetype)init {
    
    self = [super init];
    if (self) {
        self.chess = [UIImage imageNamed:@"cat_small.png"];
        self.minWidth = 40.f;
        self.minSpace = -10.f;
        self.overlapRatio = 1/4.f;
        self.canvasFrame = [UIScreen mainScreen].bounds;
    }
    return self;
}

#pragma mark - get & set

- (CGFloat)minWidth {
    return _minWidth <= 0 ? 1 : _minWidth;
}

- (CGFloat)spaceRatio {
    return MIN(1, MAX(-self.overlapRatio, _spaceRatio));
}

@end

@interface CBLayoutHelper()

@property (nonatomic, strong, readwrite) CBLayoutHelperConfig *config;

@property (nonatomic, assign, readwrite) CGSize singleSize;

@property (nonatomic, strong, readwrite) NSMutableArray *pointList;

@end

@implementation CBLayoutHelper

+ (instancetype)layoutHelperWithConfig:(CBLayoutHelperConfig *)config {
    
    __kindof CBLayoutHelper *helper = [[[self class] alloc] init];
    
    helper.config = config;
    
    return helper;
}

#pragma mark - public
- (CGRect)loadFrameWithIndex:(NSInteger)index {
    
    return CGRectZero;
}

#pragma mark - private

- (void)settingInit {
    if (!self.config.chess) {
        return;
    }
    CGSize size = self.config.chess.size;
    
    if (size.width <= 0 || size.height <= 0) {
        return;
    }
    
    CGFloat w = self.config.minWidth;
    CGFloat ratio = size.width / w;
    self.singleSize = CGSizeMake(self.config.minWidth, size.height / ratio);
    
    [self clacPointList];
    
}

- (void)clacPointList {
    [self.pointList removeAllObjects];
    
    NSInteger col = ceilf((self.config.canvasFrame.size.width + self.config.overlapRatio * self.singleSize.width) / (self.singleSize.width + self.config.overlapRatio * self.singleSize.width));
    NSInteger row = ceilf((self.config.canvasFrame.size.height + self.config.overlapRatio * self.singleSize.height) / (self.singleSize.height + self.config.overlapRatio * self.singleSize.height));
    
    
    CGPoint centerPoint = CGPointMake(col/2, row/2);
    CGPoint centerPointLocal = CGPointMake(CGRectGetMidX(self.config.canvasFrame), CGRectGetMidY(self.config.canvasFrame));
    
    CGFloat sw = self.config.spaceRatio * self.singleSize.width;
    CGFloat sh = self.config.spaceRatio * self.singleSize.height;
    for (int r = 0; r < row; r ++) {
        NSMutableArray *rlist = @[].mutableCopy;
        for (int c = 0; c < col; c ++) {
            CGFloat x = 0;
            CGFloat y = 0;
            x = centerPointLocal.x - (centerPoint.x - c) * (self.singleSize.width + sw);
            y = centerPointLocal.y - (centerPoint.y - r) * (self.singleSize.height + sh);
            [rlist addObject:NSStringFromCGPoint(CGPointMake(x, y))];
        }
        [self.pointList addObject:rlist];
    }
    NSLog(@"row %ld col%ld",row,col);
    
    NSLog(@"================================");
    
    NSLog(@"%@",self.pointList);
    
}

#pragma mark - set & get

- (void)setConfig:(CBLayoutHelperConfig *)config {
    _config = config;
    
    [self settingInit];
    
}

- (NSMutableArray *)pointList {
    if (!_pointList) {
        _pointList = @[].mutableCopy;
    }
    return _pointList;
}

@end
