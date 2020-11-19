#import "MyView.h"
#import "ViewController.h"

@implementation MyView

UIDevice *myDevice;

//les labels
UILabel *penultimateLabel, *previousLabel, *currentLabel;

//les boutons
UIButton *memoriseButton, *resetButton;

-(id) initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        [self setBackgroundColor:[UIColor whiteColor]];
        myDevice = [UIDevice currentDevice];

/*--- LABELS ---*/
        //alloc init et set les labels au centre
        penultimateLabel= [[UILabel alloc] init];
        [penultimateLabel setText:@"Penultimate"];
        [penultimateLabel setTextAlignment:NSTextAlignmentCenter];
        
        previousLabel= [[UILabel alloc] init];
        [previousLabel setText:@"Previous"];
        [previousLabel setTextAlignment:NSTextAlignmentCenter];
        
        currentLabel= [[UILabel alloc] init];
        [currentLabel setText:@"Current"];
        [currentLabel setTextAlignment:NSTextAlignmentCenter];
        
        //alloc init et set les labels vers la gauche
        _redLabel= [[UILabel alloc] init];
        [_redLabel setText:@"R : 50%"];
        [_redLabel setTextAlignment:NSTextAlignmentLeft];
        
        _greenLabel= [[UILabel alloc] init];
        [_greenLabel setText:@"V : 50%"];
        [_greenLabel setTextAlignment:NSTextAlignmentLeft];
        
        _blueLabel= [[UILabel alloc] init];
        [_blueLabel setText:@"B : 50%"];
        [_blueLabel setTextAlignment:NSTextAlignmentLeft];
        
        //faire les addSubview et release
        [self addSubview:penultimateLabel];
        [self addSubview:previousLabel];
        [self addSubview:currentLabel];
        
        [self addSubview:_redLabel];
        [self addSubview:_greenLabel];
        [self addSubview:_blueLabel];
        
        [penultimateLabel release];
        [previousLabel release];
        [currentLabel release];
        
        [_redLabel release];
        [_greenLabel release];
        [_blueLabel release];
        
        
/*--- ZONE DE COULEURS ---*/
        _penultimateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _previousButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _currentView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
        
       //colorier les trois rectangles
        [_penultimateButton setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1]];
        [_previousButton setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1]];
        [_currentView setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1]];
        //_currentView.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
        
        
        //leur associer une action
        [_penultimateButton setTag:1];
        [_previousButton setTag:2];
        
        [_penultimateButton addTarget:self.superview action:@selector(actionButton:) forControlEvents:UIControlEventTouchDown];
        [_previousButton addTarget:self.superview action:@selector(actionButton:) forControlEvents:UIControlEventTouchDown];
        
        //faire les addSubview
        [self addSubview:_penultimateButton];
        [self addSubview:_previousButton];
        [self addSubview:_currentView];
        /*
        [_penultimateButton release];
        [_previousButton release];
        [_currentView release];
        */
        
/*--- SLIDERS ---*/
        //alloc init
        _redSlider = [[UISlider alloc] init];
        _greenSlider = [[UISlider alloc] init];
        _blueSlider = [[UISlider alloc] init];
        
        
        //set min, max et value
        [_redSlider setMinimumValue:0];
        [_greenSlider setMinimumValue:0];
        [_blueSlider setMinimumValue:0];
        
        [_redSlider setMaximumValue:100];
        [_greenSlider setMaximumValue:100];
        [_blueSlider setMaximumValue:100];
        
        [_redSlider setValue:50];
        [_greenSlider setValue:50];
        [_blueSlider setValue:50];
        
        //associer à une action
        [_redSlider setTag:1];
        [_greenSlider setTag:2];
        [_blueSlider setTag:3];
        
        [_redSlider addTarget:self.superview action:@selector(actionSlider:) forControlEvents:UIControlEventValueChanged];
        [_greenSlider addTarget:self.superview action:@selector(actionSlider:) forControlEvents:UIControlEventValueChanged];
        [_blueSlider addTarget:self.superview action:@selector(actionSlider:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:_redSlider];
        [self addSubview:_greenSlider];
        [self addSubview:_blueSlider];
        
        [_redSlider release];
        [_greenSlider release];
        [_blueSlider release];


/*--- BOUTONS ---*/
        
        memoriseButton = [UIButton buttonWithType:UIButtonTypeSystem];
        resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [memoriseButton setTitle:@"Memorise" forState:UIControlStateNormal];
        [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
        
        [memoriseButton setTag:3];
        [resetButton setTag:4];
        
        [memoriseButton addTarget:self.superview action:@selector(actionButton:) forControlEvents:UIControlEventTouchDown];
        [resetButton addTarget:self.superview action:@selector(actionButton:) forControlEvents:UIControlEventTouchDown];
        
        //faire les addSubview et release
        [self addSubview:memoriseButton];
        [self addSubview:resetButton];
        
        [memoriseButton release];
        [resetButton release];
        
/*--- SWITCH ---*/
        //alloc et set
        _switchButton = [[UISwitch alloc] init];
        [_switchButton addTarget:self.superview action:@selector(actionWebSwitch:) forControlEvents:UIControlEventValueChanged];
        
        _webLabel = [[UILabel alloc] init];
        [_webLabel setText:@"Web"];
        
                
        //faire les addSubview et release
        [self addSubview:_switchButton];
        [self addSubview:_webLabel];
        
        [_switchButton release];
        [_webLabel release];
     
        [self drawInFormat:[UIScreen mainScreen].bounds.size];

    }
 
    return self;
}

-(void) drawInFormat:(CGSize)format{
    CGFloat h = format.height;
    CGFloat w = format.width;
    UIScreen *screen = [UIScreen mainScreen];

    //CGRectMake(x, y, width, height)
    
    if((([myDevice userInterfaceIdiom] == UIUserInterfaceIdiomPhone) && ([screen scale] == 3.0) && (h>w)) || ([myDevice userInterfaceIdiom] == UIUserInterfaceIdiomPad)) {
        [penultimateLabel setFrame:CGRectMake(w/9, h/25, w*0.8, 30)];
        [_penultimateButton setFrame:CGRectMake(w/9, h*2/25, w*0.8, 30)];
        [previousLabel setFrame:CGRectMake(w/9, h*3/25, w*0.8, 30)];
        [_previousButton setFrame:CGRectMake(w/9, h*4/25, w*0.8, 30)];
        [currentLabel setFrame:CGRectMake(w/9, h*5/25, w*0.8, 30)];
        [_currentView setFrame:CGRectMake(w/9, h*6/25, w*0.8, h*0.3)];
        
        [_redLabel setFrame:CGRectMake(w/9, h*15/25, w*0.8, 30)];
        [_redSlider setFrame:CGRectMake(w/9, h*16/25, w*0.8, 30)];
        [_greenLabel setFrame:CGRectMake(w/9, h*17/25, w*0.8, 30)];
        [_greenSlider setFrame:CGRectMake(w/9, h*18/25, w*0.8, 30)];
        [_blueLabel setFrame:CGRectMake(w/9, h*19/25, w*0.8, 30)];
        [_blueSlider setFrame:CGRectMake(w/9, h*20/25, w*0.8, 30)];
        
        [memoriseButton setFrame:CGRectMake(w/9, h*21/25, w*0.8, 30)];
        [resetButton setFrame:CGRectMake(w/9, h*22/25, w*0.8, 30)];
        
        [_switchButton setFrame:CGRectMake(w/20, h*23.5/25, w*0.8, 30)];
        [_webLabel setFrame:CGRectMake((w/20)+60, h*23.5/25, w*0.8, 30)];
        // Pour les petits iphone ipod en portrait
    } else if (h>w) {
        [penultimateLabel setFrame:CGRectMake(w/9, h/17, w*0.8, 30)];
        [_penultimateButton setFrame:CGRectMake(w/9, h*2/17, w*0.8, 30)];
        [previousLabel setFrame:CGRectMake(w/9, h*3/17, w*0.8, 30)];
        [_previousButton setFrame:CGRectMake(w/9, h*4/17, w*0.8, 30)];
        [currentLabel setFrame:CGRectMake(w/9, h*5/17, w*0.8, 30)];
        [_currentView setFrame:CGRectMake(w/9, h*6/17, w*0.8, 30)];
        
        [_redLabel setFrame:CGRectMake(w/9, h*7/17, w*0.8, 30)];
        [_redSlider setFrame:CGRectMake(w/9, h*8/17, w*0.8, 30)];
        [_greenLabel setFrame:CGRectMake(w/9, h*9/17, w*0.8, 30)];
        [_greenSlider setFrame:CGRectMake(w/9, h*10/17, w*0.8, 30)];
        [_blueLabel setFrame:CGRectMake(w/9, h*11/17, w*0.8, 30)];
        [_blueSlider setFrame:CGRectMake(w/9, h*12/17, w*0.8, 30)];
        
        [memoriseButton setFrame:CGRectMake(w/9, h*13/17, w*0.8, 30)];
        [resetButton setFrame:CGRectMake(w/9, h*14/17, w*0.8, 30)];
        
        [_switchButton setFrame:CGRectMake(w/20, h*16/17, w*0.8, 30)];
        [_webLabel setFrame:CGRectMake((w/20)+60, h*16/17, w*0.8, 30)];
        // Si dans le landscape
    }else if(w>h){
        [penultimateLabel setFrame:CGRectMake(w/25, h/11, w*0.45, 30)];
        [_penultimateButton setFrame:CGRectMake(w/25,  h*2/11, w*0.45, 30)];
        [previousLabel setFrame:CGRectMake(w/25, h*3/11, w*0.45, 30)];
        [_previousButton setFrame:CGRectMake(w/25, h*4/11, w*0.45, 30)];
        [currentLabel setFrame:CGRectMake(w/25, h*5/11, w*0.45, 30)];
        [_currentView setFrame:CGRectMake(w/25, h*6/11, w*0.45, 30)];
        
        [_redLabel setFrame:CGRectMake(w/2, h/11, w*0.45, 30)];
        [_redSlider setFrame:CGRectMake(w/2, h*2/11, w*0.45, 30)];
        [_greenLabel setFrame:CGRectMake(w/2, h*3/11, w*0.45, 30)];
        [_greenSlider setFrame:CGRectMake(w/2, h*4/11, w*0.45, 30)];
        [_blueLabel setFrame:CGRectMake(w/2, h*5/11, w*0.45, 30)];
        [_blueSlider setFrame:CGRectMake(w/2, h*6/11, w*0.45, 30)];
        
        [memoriseButton setFrame:CGRectMake(w/25, h*8/11, w*0.45, 30)];
        [resetButton setFrame:CGRectMake(w/2, h*8/11, w*0.45, 30)];
        
        [_switchButton setFrame:CGRectMake(w/25, h*10/11, w*0.5, 30)];
        [_webLabel setFrame:CGRectMake((w/25)+60, h*10/11, w*0.5, 30)];
    }
}

@end
