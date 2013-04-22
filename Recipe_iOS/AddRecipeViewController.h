//
//  AddRecipeViewController.h
//  Recipe_iOS
//
//  Created by Rafael on 4/19/13.
//  Copyright (c) 2013 Rafael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRecipeViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameRecipe;
@property (strong, nonatomic) IBOutlet UITextField *ingredientsRecipe;

@end
