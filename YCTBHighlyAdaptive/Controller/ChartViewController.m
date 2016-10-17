//
//  ChartViewController.m
//  cell自适应高度
//
//  Created by yishanmen on 16/10/8.
//  Copyright © 2016年 yishanmen. All rights reserved.
//

#import "ChartViewController.h"
#import "YCChartView.h"

@interface ChartViewController () <YCChatrDelegate>

@property (nonatomic, strong) YCChartView *pieView;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *modelArray = [NSMutableArray array];
    NSArray *valueArray = @[@(9), @(21), @(30), @(40)];
    NSArray *colorArray = @[[UIColor redColor],
                            [UIColor orangeColor],
                            [UIColor yellowColor],
                            [UIColor greenColor],];
    
    for (int i = 0 ; i <valueArray.count ; i++) {
        YCChartModel *model = [[YCChartModel alloc] initWithColor:colorArray[i] value:[valueArray[i] floatValue] text:nil];
        [modelArray addObject:model];
    }
    
    YCChartView *pieView = [[YCChartView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, 100, 200, 200) values:modelArray];
    pieView.delegate = self;
    [self.view addSubview:pieView];
    self.pieView = pieView;
    
    
    NSArray *bookArray = @[@"水浒传",@"西游记",@"红楼梦",@"三国演义"];
    for (int i = 0; i<colorArray.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10 + self.view.frame.size.width/4*i,340, self.view.frame.size.width/4 - 20, 30)];
        btn.backgroundColor = colorArray[i];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:bookArray[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-25, 400, 50, 30)];
    [button setTitle:@"重绘" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(handleButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - LXMPieViewDelegate

- (void)ycChartView:(YCChartView *)pieView didSelectSectionAtIndex:(NSInteger)index {
    NSLog(@"didSelectSectionAtIndex : %@", @(index));
}

#pragma mark - buttonAction

- (void)handleButtonTapped:(UIButton *)sender {
    [self.pieView reloadData];
}

@end
