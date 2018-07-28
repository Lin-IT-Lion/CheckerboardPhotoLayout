//
//  ViewController.m
//  CBPhotoLayout
//
//  Created by 幸.😳 on 2018/7/28.
//  Copyright © 2018年 林国强. All rights reserved.
//
#import "CBLayoutKit.h"
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CBLayoutHelper *help;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.help = [CBLayoutHelper layoutHelperWithConfig:[[CBLayoutHelperConfig alloc] init]];
    
    
    for (int row = 0; row < self.help.pointList.count; row++) {
        NSArray *rlist = self.help.pointList[row];
        for (int col = 0; col < rlist.count; col++) {
            CGPoint point = CGPointFromString(rlist[col]);
            UIImageView *imgView = [[UIImageView alloc] initWithImage:self.help.config.chess];
            imgView.frame = CGRectMake(point.x - self.help.singleSize.width / 2.f, point.y - self.help.singleSize.height / 2.f, self.help.singleSize.width, self.help.singleSize.height);
            
            [self.view addSubview:imgView];
        }
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
