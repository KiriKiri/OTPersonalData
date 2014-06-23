////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//  NSDate+convenience.m
//
//  Created by in 't Veen Tjeerd on 4/23/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Imports

#import "NSDate+convenience.h"

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Constants

unsigned const kOTDateComponents = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;

@implementation NSDate (Convenience)

- (NSDate *)monthBeginning
{
    NSCalendar *gregorianCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorianCalendar components:kOTDateComponents fromDate:self];

    [components setDay:1];
    return [gregorianCalendar dateFromComponents:components];
}

- (NSDate *)setDay:(NSUInteger)aDayNumber
{
    NSCalendar *gregorianCalendar = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorianCalendar components:kOTDateComponents fromDate:self];
    
    [components setDay:aDayNumber];
    return [gregorianCalendar dateFromComponents:components];
}

- (int)year
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:self];
    return [components year];
}

- (int)month
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorian components:NSMonthCalendarUnit fromDate:self];
    return [components month];
}

- (int)day
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit fromDate:self];
    return [components day];
}

- (int)hours
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                              initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorian components:NSHourCalendarUnit fromDate:self];
    return [components hour];
}

- (int)minutes
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                              initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorian components:NSMinuteCalendarUnit fromDate:self];
    return [components minute];
}

- (int)seconds
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                              initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDateComponents *components = [gregorian components:NSSecondCalendarUnit fromDate:self];
    return [components second];
}

- (int)firstWeekDayInMonth
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    //Set date to first of month
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self];
    [comps setDay:1];
    NSDate *newDate = [gregorian dateFromComponents:comps];

    return [gregorian ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:newDate];
}

- (NSDate *)offsetMonth:(int)numMonths
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[[NSDateComponents alloc] init] autorelease];
    [offsetComponents setMonth:numMonths];

    return [gregorian dateByAddingComponents:offsetComponents
                                                   toDate:self options:0];
}

- (NSDate *)offsetHours:(int)hours
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[[NSDateComponents alloc] init] autorelease];
    [offsetComponents setHour:hours];
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (NSDate *)offsetDay:(int)numDays
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *offsetComponents = [[[NSDateComponents alloc] init] autorelease];
    [offsetComponents setDay:numDays];

    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:self options:0];
}

- (int)numDaysInMonth
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange rng = [cal rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    NSUInteger numberOfDaysInMonth = rng.length;
    return numberOfDaysInMonth;
}

- (NSString *)timeStringFromDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSString *dateAsString = [dateFormatter stringFromDate:self];
    [dateFormatter release];
    
    return dateAsString;
}

- (NSString *)shortDateStringFromDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    NSString *dateAsString = [dateFormatter stringFromDate:self];
    [dateFormatter release];
    
    return dateAsString;
}

+ (NSDate *)dateStartOfDay:(NSDate *)date
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: date];
    return [gregorian dateFromComponents:components];
}

+ (NSDate *)dateStartOfWeek
{
    NSCalendar *gregorian = [[[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    [gregorian setFirstWeekday:2]; //monday is first day
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];

    NSDateComponents *componentsToSubtract = [[[NSDateComponents alloc] init] autorelease];
    [componentsToSubtract setDay: - ((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7)];
    NSDate *beginningOfWeek = [gregorian dateByAddingComponents:componentsToSubtract toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                fromDate: beginningOfWeek];
    
    //gestript
    beginningOfWeek = [gregorian dateFromComponents: componentsStripped];
    
    return beginningOfWeek;
}

+ (NSDate *)dateEndOfWeek
{
    NSCalendar *gregorian =[[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    
    
    NSDateComponents *componentsToAdd = [[[NSDateComponents alloc] init] autorelease];
    [componentsToAdd setDay: + (((([components weekday] - [gregorian firstWeekday])
                                      + 7 ) % 7))+6];
    NSDate *endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
    
    NSDateComponents *componentsStripped = [gregorian components: (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                                       fromDate: endOfWeek];
    
    //gestript
    endOfWeek = [gregorian dateFromComponents: componentsStripped];
    return endOfWeek;
}

@end
