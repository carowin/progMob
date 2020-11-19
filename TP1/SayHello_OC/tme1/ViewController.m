//
//  ViewController.m
//  tme1
//
//  Created by m2sar on 05/10/2020.
//  Copyright © 2020 Sorbonne Université. All rights reserved.
//

#import "ViewController.h"
int b=0;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self l] setText:@""];
    [[self button] setTitle:@"SayHello" forState:UIControlStateNormal];
}


- (IBAction)action:(id)sender {
    if (b==0){
        [[self l] setText:@"Hello"];
        [[self button] setTitle:@"SayBye" forState:UIControlStateNormal];
        b=1;
    }else{
        [[self l] setText:@"Bye Bye"];
        [[self button] setTitle:@"SayHello" forState:UIControlStateNormal];
        b=0;
    }
}
@end
