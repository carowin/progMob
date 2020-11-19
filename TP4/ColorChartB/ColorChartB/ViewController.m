#import "ViewController.h"
#import "MyView.h"


@interface ViewController ()

@end

@implementation ViewController

MyView *v;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIScreen *ecran = [UIScreen mainScreen];
    CGRect rect = [ecran bounds];
    v = [[MyView alloc] initWithFrame:rect];
    [self setView:v];
    [v release];
}


/*---- Premiere partie de l'écran (penultimate/previous/current) ----*/
- (void)actionButton:(UIButton*)sender {
    if([sender tag] == 1) {
        //onclick du penultimate view, current view recupere la couleur de penultimate
        [[v currentView] setBackgroundColor:[v penultimateButton].backgroundColor];
    }else if ([sender tag] == 2) {
        //onclick du previous view, current view recupere la couleur de previous
        [[v currentView] setBackgroundColor:[v previousButton].backgroundColor];
    }else if( [sender tag] == 3){
        //memorise
        [[v penultimateButton] setBackgroundColor:[v previousButton].backgroundColor];
        [[v previousButton] setBackgroundColor:[v currentView].backgroundColor];
    }else if ([sender tag] == 4){
        //reset
        [self resetSlider];
    }
    
}


/*---- Deuxieme partie de l'écran (RVB Slider) ----*/

/*
 Methode qui va etre appelée à chaque fois qu'on modifie la valeur des sliders.
 Update le background color de la vue courante selon les valeurs des slifers.
 */
- (void)updateColor {
    UIColor *color;
    if(![[v switchButton] isOn]){
        color = [UIColor colorWithRed:[v redSlider].value/100.0
                                green:[v greenSlider].value/100.0
                                 blue:[v blueSlider].value/100.0
                                alpha:1];
    }else{
        color = [UIColor colorWithRed:([v redSlider].value * 10)/100.0
                                green:([v greenSlider].value * 10)/100.0
                                 blue:([v blueSlider].value * 10)/100.0
                                alpha:1];
    }
    [[v currentView] setBackgroundColor:color];
    
}

- (void)resetSlider {
    if(![[v switchButton] isOn]){
        [[v redSlider] setValue:50];
        [[v greenSlider] setValue:50];
        [[v blueSlider] setValue:50];
        [v redLabel].text = [NSString stringWithFormat:@"R : %d %%", (int)[v redSlider].value];
        [v greenLabel].text = [NSString stringWithFormat:@"V : %d %%", (int)[v greenSlider].value];
        [v blueLabel].text = [NSString stringWithFormat:@"B : %d %%", (int)[v blueSlider].value];
    }else{
        [[v redSlider] setValue:5];
        [[v greenSlider] setValue:5];
        [[v blueSlider] setValue:5];
        [v redLabel].text = [NSString stringWithFormat:@"R : %d %%", (int)[v redSlider].value*10];
        [v greenLabel].text = [NSString stringWithFormat:@"V : %d %%", (int)[v greenSlider].value*10];
        [v blueLabel].text = [NSString stringWithFormat:@"B : %d %%", (int)[v blueSlider].value*10];
    }
    UIColor *color = [UIColor colorWithRed:50/100.0
                                     green:50/100.0
                                      blue:50/100.0
                                     alpha:1];
    [[v currentView] setBackgroundColor:color];
}

- (void)actionSlider:(UISlider*)sender {
    if ([sender tag] == 1){
        [self updateColor];
        float redValue = [v redSlider].value;
        if(![[v switchButton] isOn]){
            [v redLabel].text = [NSString stringWithFormat:@"R : %d %%", (int)redValue];
        }else{
            [v redLabel].text = [NSString stringWithFormat:@"R : %d %%", (int)redValue* 10];
        }
    }else if ([sender tag] == 2){
        [self updateColor];
        float vertValue = [v greenSlider].value;
        if(![[v switchButton] isOn]){
            [v greenLabel].text = [NSString stringWithFormat:@"V : %d %%", (int)vertValue];
        }else{
            [v greenLabel].text = [NSString stringWithFormat:@"V : %d %%", (int)vertValue * 10];
        }
    }else if ([sender tag] == 3){
        [self updateColor];
        float blueValue = [v blueSlider].value;
        if(![[v switchButton] isOn]){
            [v blueLabel].text = [NSString stringWithFormat:@"B : %d %%", (int)blueValue];
        }else{
            [v blueLabel].text = [NSString stringWithFormat:@"B : %d %%", (int)blueValue * 10];
        }
    }
    
}


/*
 Pour le switch:
 --> si le switch est ON : on avance de 10 en 10 donc maximum value est égal à 10(car il y a que 10 pas à faire avant d'arriver à 100)
 --> si le switch est OFF : on avance de 1 en 1, donc maximum value est égal à 100
 */
- (void)actionWebSwitch:(UISwitch*)sender {
    if(![[v switchButton] isOn]){
        [[v switchButton] setOn:true];
        [v redSlider].maximumValue = 10;
        [v greenSlider].maximumValue = 10;
        [v blueSlider].maximumValue = 10;
    }else{
        [[v switchButton] setOn:false];
        [v redSlider].maximumValue = 100;
        [v greenSlider].maximumValue = 100;
        [v blueSlider].maximumValue = 100;
    }
    [self resetSlider];
    
}

- (void) viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [v drawInFormat:size];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
