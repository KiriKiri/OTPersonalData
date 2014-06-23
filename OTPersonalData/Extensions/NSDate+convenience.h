//
//  NSDate+convenience.h
//
//  Created by in 't Veen Tjeerd on 4/23/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Convenience)

- (NSDate *)setDay:(NSUInteger)aDayNumber;
- (NSDate *)monthBeginning;
- (NSDate *)offsetMonth:(int)numMonths;
- (NSDate *)offsetDay:(int)numDays;
- (NSDate *)offsetHours:(int)hours;
- (int)numDaysInMonth;
- (int)firstWeekDayInMonth;
- (int)year;
- (int)month;
- (int)day;
- (int)hours;
- (int)minutes;
- (int)seconds;
- (NSString *)timeStringFromDate;
- (NSString *)shortDateStringFromDate;

+ (NSDate *)dateStartOfDay:(NSDate *)date;
+ (NSDate *)dateStartOfWeek;
+ (NSDate *)dateEndOfWeek;

@end
