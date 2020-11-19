//
//  ViewController.m
//  colorsOC
//
//  Created by m2sar on 07/10/2020.
//  Copyright © 2020 Sorbonne Universite. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self button] setMaximumValue:4];
}


- (IBAction)action:(UIStepper *)sender {
    if([self button].value == 0){
        [[self cadre] setBackgroundColor:UIColor.redColor];
    }
    if([self button].value == 1){
        [[self cadre] setBackgroundColor:UIColor.brownColor];
    }
    if([self button].value == 2){
        [[self cadre] setBackgroundColor:UIColor.cyanColor];
    }
    if([self button].value == 3){
        [[self cadre] setBackgroundColor:UIColor.yellowColor];
    }
    if([self button].value == 4){
        [[self cadre] setBackgroundColor:UIColor.blueColor];
    }
}
@end
