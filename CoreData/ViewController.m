//
//  ViewController.m
//  CoreTextExample
//
//  Created by Tvo001 on 3/9/16.
//  Copyright © 2016 Tvo001. All rights reserved.
//

#import "ViewController.h"
#import "CTView.h"
#import "MarkupParser.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height


@interface ViewController ()
@property (strong, nonatomic)  CTView *coreTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coreTextView = [[CTView alloc] initWithFrame:CGRectMake(0, 20, ScreenWidth, ScreenHeight)];
    self.coreTextView.backgroundColor = [UIColor clearColor];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Text" ofType:@"txt"];
    NSString* text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    MarkupParser* p = [[MarkupParser alloc] init] ;
    NSAttributedString* attString = [p attrStringFromMarkup: text];
    
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:text];
    
    
    [self.coreTextView setAttString:attString];
    
    [self.coreTextView buildFrames];
    
 //   [self.view addSubview:self.coreTextView];

    
    UIButton *button =[[UIButton alloc]  initWithFrame:CGRectMake(10, 30, 120, 25)];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"Change Font" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(changeFont) forControlEvents:UIControlEventTouchUpInside];
    button.layer.borderColor = [UIColor purpleColor].CGColor;
    button.layer.borderWidth = 2;
    button.layer.cornerRadius = 5;
    
 //   [self.view addSubview:button];
    
    
}


-(void) changeFont
{
    // Do any additional setup after loading the view, typically from a nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Text" ofType:@"txt"];
    NSString* text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    MarkupParser* p = [[MarkupParser alloc] init] ;
    
    p.realFont = [UIFont systemFontOfSize:30];
    p.color = [UIColor redColor];
    p.strokeColor = [UIColor blueColor];
    
    NSAttributedString* attString = [p attrStringFromMarkup: text];

    
    [self.coreTextView setAttString:attString];
    
    [self.coreTextView buildFrames];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
