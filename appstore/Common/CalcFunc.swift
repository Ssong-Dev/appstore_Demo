//
//  CalcFunc.swift
//  appstore
//
//  Created by jh_song on 2022/03/21.
//

import Foundation


func CalcNumToString(input:Int) -> String
{
    if input / 100000000 > 0
    {
        let returnNum = Double(input) * 0.00000001
        return "\(lroundl(returnNum))억"
    }
    else if input / 10000 > 0
    {
        let returnNum = Double(input) * 0.0001
        return "\(lroundl(returnNum))만"
    }
    else if input / 1000 > 0
    {
        let returnNum = Double(input) * 0.001
        return "\(lroundl(returnNum))천"
    }
    else if input / 100 > 0
    {
        let returnNum = Double(input) * 0.01
        return "\(lroundl(returnNum))백"
    }
    return String(input)
}

func CalcFloatRound(input:Float)->Float
{
    let result = round(input * 10) * 0.1
    return result
}

func CalcDateFromCurrentTime(input:String)->String
{
    let dateFormatter = DateFormatter()
    //2020-05-11T07:00:00Z
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let temp = dateFormatter.date(from: input)
    let currentCalender = Calendar.current
    
    let dateGap = currentCalender.dateComponents([.year,.month,.day,.hour,.minute], from: temp ?? Date(), to: Date())
    
    if case let (year?, month?, day?, hour?, min? ) = (dateGap.year, dateGap.month, dateGap.day, dateGap.hour, dateGap.minute)
    {
        if year != 0
        {
            return "\(year)년 전"
        }
        if month != 0
        {
            return "\(month)달 전"
        }
        if day != 0
        {
            if day > 7
            {
                return "\(day/7)주 전"
            }
            else
            {
                return "\(day)일 전"
            }
        }
        if hour != 0
        {
            return "\(hour)시간 전"
        }
        if min != 0
        {
            return "\(min)분 전"
        }
    }
    return input
    
}
