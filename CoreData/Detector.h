//
//  Detector.h
//  DetectMe
//
//  Created by Josep Marc Mingot Hidalgo on 18/12/13.
//  Copyright (c) 2013 Josep Marc Mingot Hidalgo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AnnotatedImage, MultipleDetector, Rating, User;

@interface Detector : NSManagedObject

@property (nonatomic, retain) NSNumber * averageRating;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * detectionThreshold;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * isPublic;
@property (nonatomic, retain) NSNumber * isSent;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * parentID;
@property (nonatomic, retain) NSNumber * precisionRecall;
@property (nonatomic, retain) NSNumber * serverDatabaseID;
@property (nonatomic, retain) NSString * sizes;
@property (nonatomic, retain) NSData * supportVectors;
@property (nonatomic, retain) NSString * targetClass;
@property (nonatomic, retain) NSNumber * timeLearning;
@property (nonatomic, retain) NSString * trainingLog;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSString * weights;
@property (nonatomic, retain) NSNumber * numberRatings;
@property (nonatomic, retain) NSSet *annotatedImages;
@property (nonatomic, retain) NSSet *multipleDetectors;
@property (nonatomic, retain) NSSet *ratings;
@property (nonatomic, retain) User *user;
@end

@interface Detector (CoreDataGeneratedAccessors)

- (void)addAnnotatedImagesObject:(AnnotatedImage *)value;
- (void)removeAnnotatedImagesObject:(AnnotatedImage *)value;
- (void)addAnnotatedImages:(NSSet *)values;
- (void)removeAnnotatedImages:(NSSet *)values;

- (void)addMultipleDetectorsObject:(MultipleDetector *)value;
- (void)removeMultipleDetectorsObject:(MultipleDetector *)value;
- (void)addMultipleDetectors:(NSSet *)values;
- (void)removeMultipleDetectors:(NSSet *)values;

- (void)addRatingsObject:(Rating *)value;
- (void)removeRatingsObject:(Rating *)value;
- (void)addRatings:(NSSet *)values;
- (void)removeRatings:(NSSet *)values;

@end
