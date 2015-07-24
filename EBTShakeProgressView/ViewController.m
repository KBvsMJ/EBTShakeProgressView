//
//  ViewController.m
//  EBTShakeProgressView
//
//  Created by ebaotong on 15/7/22.
//  Copyright (c) 2015年 com.csst. All rights reserved.
//

#import "ViewController.h"
#import "EBTShakeProgressView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet EBTShakeProgressView *progressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
   
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(UIButton *)sender {
    
    _progressView.progress = 0.78;
}

@end
