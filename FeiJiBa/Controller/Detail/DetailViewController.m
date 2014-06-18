//
//  DetailViewController.m
//  FeiJiBa
//
//  Created by MacBook on 14-6-17.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailBottom.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (weak, nonatomic) IBOutlet UITextView *contentLabel;

@property (strong, nonatomic) DetailBottom *bottom;


@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bottom = [DetailBottom getDetailBottom];
    [self.bottom.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom.likeButton addTarget:self action:@selector(like:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom.shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom.nextButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    self.bottom.frame = CGRectMake(0, kScreenHeight-self.bottom.frame.size.height, self.bottom.frame.size.width, self.bottom.frame.size.height);
    [self.view addSubview:self.bottom];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isPro) {
            self.titleLabel.text = self.dataModel.proTitle;
            self.authorLabel.text = self.dataModel.proAuthor;
            self.contentLabel.text = self.dataModel.proContent;
        }else
        {
            self.titleLabel.text = self.dataModel.dsTitle;
            self.authorLabel.text = self.dataModel.dsAuthor;
            self.contentLabel.text = self.dataModel.dsContent;
        }
        
        [self.contentLabel sizeToFit];
        self.mainScrollView.contentSize = CGSizeMake(0, self.contentLabel.frame.origin.y+self.contentLabel.frame.size.height+50);
    });
    
}


- (void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)like:(id)sender
{
    [self.dataModel addLike];
}

- (void)share:(id)sender
{
    
}

- (void)next:(id)sender
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
