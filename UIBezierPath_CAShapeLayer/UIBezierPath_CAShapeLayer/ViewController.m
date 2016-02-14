//
//  ViewController.m
//  UIBezierPath_CAShapeLayer
//
//  Created by sourcecode on 16/2/14.
//  Copyright © 2016年 sourcecode. All rights reserved.
//

#import "ViewController.h"
#import "eyes.h"

@interface ViewController ()
<
UIScrollViewDelegate
>
@property (nonatomic ,strong) eyes *eye;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+200);
    [self.view addSubview:scrollView];
    [self addCAShapeLayer];
    
    self.eye = [[eyes alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 50, 0, 100, 100)];
    [self.eye setupAnimation];
    [scrollView addSubview:self.eye];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.eye animationWith:scrollView.contentOffset.y];
}


- (void)addCAShapeLayer{
    CGSize finalSize = CGSizeMake(CGRectGetWidth(self.view.frame), self.view.frame.size.height);
    CGFloat layerHeight = finalSize.height * 0.2;
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    UIBezierPath *bezier = [[UIBezierPath alloc] init];
    
    [bezier moveToPoint:CGPointMake(0, finalSize.height - layerHeight)];
    [bezier addLineToPoint:CGPointMake(0, finalSize.height - 1)];
    [bezier addLineToPoint:CGPointMake(finalSize.width, finalSize.height - 1)];
    [bezier addLineToPoint:CGPointMake(finalSize.width, finalSize.height - layerHeight)];
    [bezier addQuadCurveToPoint:CGPointMake(0,finalSize.height - layerHeight)
                   controlPoint:CGPointMake(finalSize.width / 2, (finalSize.height - layerHeight) - 40)];
    
    layer.path = bezier.CGPath;
    layer.fillColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:layer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
