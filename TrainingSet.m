//
//  TrainingSet.m
//  LabelMe
//
//  Created by Josep Marc Mingot Hidalgo on 05/04/13.
//  Copyright (c) 2013 CSAIL. All rights reserved.
//

#import "TrainingSet.h"
#import "UIImage+HOG.h"
#import "UIImage+Resize.h"
#import "BoundingBox.h"
#import "Box.h"


#define MAX_NUMBER_EXAMPLES 20000
#define MAX_NUMBER_FEATURES 2000


@implementation TrainingSet


#pragma mark
#pragma mark - Initialization


- (id) initWithBoxes:(NSArray *)boxes forImages:(NSArray *)images
{
    if(self = [super init]){
        
        self.images = [[NSMutableArray alloc] init];
        self.groundTruthBoundingBoxes = [[NSMutableArray alloc] init];
        
        for(int i=0; i<boxes.count; i++){

            // add box
            Box *box = [boxes objectAtIndex:i];
            BoundingBox *cp = [[BoundingBox alloc] init];
            cp.xmin = box.upperLeft.x;///box.imageSize.width;
            cp.ymin = box.upperLeft.y;///box.imageSize.height;
            cp.xmax = box.lowerRight.x;///box.imageSize.width;
            cp.ymax = box.lowerRight.y;///box.imageSize.height;
            
            if(cp.xmin>cp.xmax){
                cp.xmax = box.upperLeft.x; ///box.imageSize.width;
                cp.xmin = box.lowerRight.x;///box.imageSize.width;
            }
            
            if(cp.ymin>cp.ymax){
                cp.ymax = box.upperLeft.y;///box.imageSize.height;
                cp.ymin = box.lowerRight.y;///box.imageSize.height;
            }
            
            cp.imageIndex = self.images.count;
            cp.label = 1;
            [self.groundTruthBoundingBoxes addObject:cp];
            
            //add image
            UIImage *image = [images objectAtIndex:i];
            [self.images addObject:image];
        }
        
        //Add abstract pictures to the training set to generate false positives when the bb is very big.
        //guess the relationship with the artists...
        //[self.images addObject:[UIImage imageNamed:@"picaso.jpg"]];
        //[self.images addObject:[UIImage imageNamed:@"dali.jpg"]];
        //[self.images addObject:[UIImage imageNamed:@"miro.jpg"]];
    }
    return self;
}


#pragma mark -
#pragma mark Public Methods

- (void) unifyGroundTruthBoundingBoxes
{
    //get max width and max height of the gt bb
    float maxWidth=0, maxHeight=0;
    for(BoundingBox *groundTruthBB in self.groundTruthBoundingBoxes){
        float width = groundTruthBB.xmax - groundTruthBB.xmin;
        float height = groundTruthBB.ymax - groundTruthBB.ymin;
        maxWidth = maxWidth > width ? maxWidth : width;
        maxHeight = maxHeight > height ? maxHeight : height;
    }
    
    //modify the actual bb
    for(BoundingBox *groundTruthBB in self.groundTruthBoundingBoxes){
        float xMidPoint = (groundTruthBB.xmax + groundTruthBB.xmin)/2;
        float yMidPoint = (groundTruthBB.ymax + groundTruthBB.ymin)/2;
        groundTruthBB.xmin = xMidPoint - maxWidth/2;
        groundTruthBB.xmax = xMidPoint + maxWidth/2;
        groundTruthBB.ymin = yMidPoint - maxHeight/2;
        groundTruthBB.ymax = yMidPoint + maxHeight/2;
    }
}

- (float) getAverageGroundTruthAspectRatio
{
    CGSize averageSize;
    averageSize.height = 0;
    averageSize.width = 0;
    
    for(BoundingBox* groundTruthBB in self.groundTruthBoundingBoxes){
        averageSize.height += groundTruthBB.ymax - groundTruthBB.ymin;
        averageSize.width += groundTruthBB.xmax - groundTruthBB.xmin;
    }
    return averageSize.width/averageSize.height;
}


- (NSArray *) getImagesOfBoundingBoxes
{
    NSMutableArray *listOfImages = [[NSMutableArray alloc] initWithCapacity:self.groundTruthBoundingBoxes.count];
    for(BoundingBox *cp in self.groundTruthBoundingBoxes){
        UIImage *wholeImage = [self.images objectAtIndex:cp.imageIndex];
        UIImage *croppedImage = [wholeImage croppedImage:[[cp increaseSizeByFactor:0.2] rectangleForImage:wholeImage]];
        [listOfImages addObject:croppedImage];
    }
    
    return [NSArray arrayWithArray:listOfImages];
}


@end
