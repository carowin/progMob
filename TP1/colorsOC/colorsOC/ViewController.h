//
//  ViewController.h
//  colorsOC
//
//  Created by m2sar on 07/10/2020.
//  Copyright © 2020 Sorbonne Universite. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *cadre;
@property (weak, nonatomic) IBOutlet UIStepper *button;
- (IBAction)action:(UIStepper *)sender;
@end

