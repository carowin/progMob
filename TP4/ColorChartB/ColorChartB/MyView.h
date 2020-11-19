#import <UIKit/UIKit.h>

@interface MyView : UIView

/*---- Premiere partie de l'écran (penultimate/previous/current) ----*/
@property (weak, nonatomic) IBOutlet UIButton *penultimateButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIView *currentView;


/*---- Deuxieme partie de l'écran (RVB Slider) ----*/
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;

@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;

@property (weak, nonatomic) IBOutlet UILabel *blueLabel;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;


/*---- Troisieme partie de l'écran (memorise/reset/web)----*/
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (weak, nonatomic) IBOutlet UILabel *webLabel;

- (void) drawInFormat: (CGSize) format;


@end
