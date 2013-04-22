//
//  AddRecipeViewController.m
//  Recipe_iOS
//
//  Created by Rafael on 4/19/13.
//  Copyright (c) 2013 Rafael. All rights reserved.
//

#import "AddRecipeViewController.h"
#import "AFJSONRequestOperation.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"


@interface AddRecipeViewController ()

@end

@implementation AddRecipeViewController

@synthesize nameRecipe;
@synthesize ingredientsRecipe;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Add Recipe";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 80, 25)];
    nameLabel.text = @"Nome:";
    nameLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:nameLabel];
    
    nameRecipe = [[UITextField alloc] initWithFrame:CGRectMake(120, 30, 190, 25)];
    nameRecipe.borderStyle = UITextBorderStyleRoundedRect;
    nameRecipe.textColor = [UIColor blackColor];
    nameRecipe.font = [UIFont systemFontOfSize:17.0];
    nameRecipe.backgroundColor = [UIColor whiteColor];
    nameRecipe.autocorrectionType = UITextAutocorrectionTypeNo;
    nameRecipe.keyboardType = UIKeyboardTypeDefault;
    //nameRecipe.returnKeyType = UIReturnKeyDone;  // typing return key
    nameRecipe.clearButtonMode = UITextFieldViewModeWhileEditing; // has a clear ‘x’ button to the right
    [self.view addSubview:nameRecipe];
    
    UILabel *ingredientsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 150, 25)];
    ingredientsLabel.text = @"Ingredientes:";
    ingredientsLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:ingredientsLabel];
    
    ingredientsRecipe = [[UITextField alloc] initWithFrame:CGRectMake(120, 60, 190, 25)];
    ingredientsRecipe.borderStyle = UITextBorderStyleRoundedRect;
    ingredientsRecipe.textColor = [UIColor blackColor];
    ingredientsRecipe.font = [UIFont systemFontOfSize:17.0];
    ingredientsRecipe.backgroundColor = [UIColor whiteColor];
    ingredientsRecipe.autocorrectionType = UITextAutocorrectionTypeNo;
    ingredientsRecipe.keyboardType = UIKeyboardTypeDefault;
    //ingredientsRecipe.returnKeyType = UIReturnKeyDone;
    ingredientsRecipe.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:ingredientsRecipe];
    
    UIButton *addRecipeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addRecipeButton.frame = CGRectMake(110, 100, 100, 44);
    [addRecipeButton setTitle:@"Add Recipe" forState:UIControlStateNormal];
    [self.view addSubview:addRecipeButton];
    [addRecipeButton addTarget:self action:@selector(postRecipe:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) postRecipe:(UIButton *) sender {
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:nameRecipe.text, @"name", ingredientsRecipe.text, @"ingredients", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:&error];
    
    //NSURL * url =[[NSURL alloc] initWithString: @"http://192.168.1.101:3000/prescriptions.json"]; //casa
    NSURL *url =[[NSURL alloc] initWithString: @"http://192.168.0.25:3000/prescriptions.json"]; //RubyThree
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/prescriptions" parameters:parameters];
    //[request setHTTPBody:request];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [jsonData length]] forHTTPHeaderField:@"Content-Length"];
    //[request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSLog(@"Request Successful");
        UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"Recipe iOS" message:@"Your recipe has been saved!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [successAlert show];
        //[successAlert release];
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        NSLog(@"[Error]: (%@ %@) %@", [request HTTPMethod], [[request URL] relativePath], error);
    }];
    
    [operation start];
    
    nameRecipe.text = @"";
    ingredientsRecipe.text = @"";
    
    /*
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request setPostValue:name forKey:@"name"];
    [request setPostValue:ingredients forKey:@"ingredients"];
    [request startAsynchronous];
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
