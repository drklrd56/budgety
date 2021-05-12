import 'dart:math';
import './Record.dart';
import './Memory.dart';
import 'package:fl_chart/fl_chart.dart';
import './Search.dart';
import 'package:flutter/material.dart';

Map<String,Object> getCategriesData(int _selectedAccount,int _selectedDuration) {
    double _total = 0;
    List<Map<String,Object>> cashBook = [];
    List _indicators = [];
    List _sections = [] ;
    List _colors = [];
    int colorIndex = 0;
    double sum = 0;
    double cashBook_total = 0.0;
    List results = [];
    List records = [];
    for(int i = 0; i < categories.length; i++) {
      if(accounts.length > 0 && _selectedAccount < accounts.length) {
        results = getRecords(_selectedAccount,property: categories[i]);
        sum = 0;
        if(_selectedDuration == 0)
          records.add(getWeekRecords(results, _selectedAccount,returnType: 2));
        else if(_selectedDuration == 1)
          records.add(getMonthRecords(results, _selectedAccount,returnType: 2));
        else if(_selectedDuration == 2)
          records.add(get6MonthsRecords(results, _selectedAccount,returnType: 2));
        else if(_selectedDuration == 3)
          records.add(get12MonthsRecords(results, _selectedAccount,returnType: 2));
        cashBook.add({
          'Income': ((records[i] as List<Map<String,Object>>)[0]['incExp'] as List)[0],
          'Expense': ((records[i] as List<Map<String,Object>>)[0]['incExp'] as List)[1],
        });
        cashBook_total += (records[i] as List<Map<String,Object>>)[0]['Sum'] != null
        ? (records[i] as List<Map<String,Object>>)[0]['Sum']
        : 0;
        
        sum = ((records[i] as List<Map<String,Object>>)[0]['incExp'] as List)[1];
        if (sum != 0) {
          _sections.add(sum);
          _total += sum;
          _indicators.add(categories[i]);
          _colors.add(Colors.primaries[colorIndex]);
          colorIndex+=2;
          if(colorIndex == Colors.primaries.length)
            colorIndex = 0;
        }
      }
    }
    List categoriesData = [];
    categoriesData.add(_total);
    categoriesData.add(_sections);
    categoriesData.add(_indicators);
    categoriesData.add(_colors);

    Map<String,Object> returnVal = {
      '1':categoriesData,
      '2':cashBook,
      '3':cashBook_total
    };
    return returnVal;
  }

  List getLabelsData(int _selectedAccount,int _selectedDuration) {
    double _total = 0;
    List _indicators = [];
    List _sections = [] ;
    List _colors = [];
    int colorIndex = 0;
    double sum = 0;
    List results = [];
    for(int i = 0; i < labels.length; i++) {
      if(accounts.length > 0 && _selectedAccount < accounts.length) {
        results = getRecords(_selectedAccount,property: labels[i]['Label']);
        sum = 0;
        if(results.length > 0) {
          if(_selectedDuration == 0)
            sum = (getWeekRecords(results, _selectedAccount,returnType: 2)[0]['incExp'] as List)[1];
          else if(_selectedDuration == 1)
            sum = (getMonthRecords(results, _selectedAccount,returnType: 2)[0]['incExp'] as List)[1];
          else if(_selectedDuration == 2)
            sum = (get6MonthsRecords(results, _selectedAccount,returnType: 2)[0]['incExp'] as List)[1];
          else if(_selectedDuration == 3)
            sum = (getYearRecords(results, _selectedAccount,returnType: 2)[0]['incExp'] as List)[1];
          if (sum != 0) {
            _sections.add(sum);
            _total += sum;
            _indicators.add(labels[i]['Label']);
            _colors.add(Colors.primaries[colorIndex]);
            colorIndex+=2;
            if(colorIndex == Colors.primaries.length)
              colorIndex = 0;
          }
        }
      }
    }
    List labelsData = [];
    labelsData.add(_total);
    labelsData.add(_sections);
    labelsData.add(_indicators);
    labelsData.add(_colors);
    return labelsData;
  }

  Map<String,Object> getLabelData(int _selectedAccount,int _selectedDuration) {
    Map<String,Object> reportData;
    List xLabels = [];
    List<double> yLabels = [];
    List<BarChartGroupData> rawBarGroups = [];
    final weekDays = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    final List<String> months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    String durationText = "";
    double total, savings, totalIncome, totalExpense;
    int durationPeriod = 0 , incomeCount = 0 , expenseCount = 0, temp;
    List results = [];
    List incExp = [0.0,0.0];
    DateTime currTime = DateTime.now();
    List<Map<String,Object>> data = [];
    List<Record> expenses = [];
    if( accounts!= null && _selectedAccount >= 0 && _selectedAccount < accounts.length) {
      if(accounts[_selectedAccount].containsKey('Transactions')) {
        results = getRecords(_selectedAccount);
        
        if(_selectedDuration == 0) {
          durationPeriod = 7;
          durationText = 'Last 7 Days';
          data = getWeekRecords(results, _selectedAccount,returnType: 2);
          xLabels = List.generate(7, (index) {
            if(index == 0)
              return 'Today';
            temp = (currTime.weekday - 1) - index;
            if(temp < 0)
              temp = temp + 7;
            return weekDays[temp];
          });
        }
        else if(_selectedDuration == 1) {
          durationPeriod = 30;
          durationText = 'Last 30 Days';
          data = getMonthRecords(results, _selectedAccount,returnType: 2);
          temp = 4;
          xLabels = List.generate(5, (index) {
            if(index == 0)
              return 'This Week';
            return  'Week' + ((temp -(temp - index)) + 1).toString();
          });
        }
        else if(_selectedDuration == 2) {
          int month = currTime.month - 6;
          if(month <= 0) 
            month += 12;
          month = currTime.difference(new DateTime(currTime.year,month,currTime.day)).inDays;
          durationPeriod = 6 * month;
          durationText = 'Last 6 Months';

          data = get6MonthsRecords(results, _selectedAccount,returnType: 2);
          temp = 5;
          xLabels = List.generate(6, (index) {
            temp = (currTime.month - 1) - index;
            if(temp < 0)
              temp = temp + 12;
            return months[temp].toString();
          });

        }
        else if(_selectedDuration == 3) {
          durationPeriod = currTime.year % 4 == 0 ? 366 : 365;
          durationText = 'Last 1 Year';
          data = get12MonthsRecords(results, _selectedAccount,returnType: 2);
          temp = 11;
          xLabels = List.generate(12, (index) {
            temp = (currTime.month - 1) - index;
            if(temp < 0)
              temp = temp + 12;
            return months[temp].toString();
          });
        }
        incExp = data[0]['incExp'];
        
        yLabels.add(max( incExp[0], incExp[1]));
        for(int i = 1 ; i < 5 ; i ++) {
          yLabels.add((yLabels[i - 1]/2));
        }

        int length =  (data[0]['income'] as List<double>).length;
        double x,y,tempX,tempY;
        rawBarGroups = [];
        for(int index = 0 ; index < length ; index++) {
          tempX = tempY = 0; 
          x = (data[0]['income'] as List<double>)[index];
          y = (data[0]['expense'] as List<double>)[index];
          for(int i = 0 ; i < yLabels.length - 1; i++) {
            if(yLabels[i] == x) {
              tempX = (yLabels.length - 1) - i.toDouble();
            }else if(x < yLabels[i] && x > yLabels[i+1])
              tempX = (yLabels.length - 1) - (i - (yLabels[i] - x).abs()/yLabels[i]).abs();
            
            if(yLabels[i] == y) {
              tempY = (yLabels.length - 1) - i.toDouble();
            } else if(y < yLabels[i] && y > yLabels[i+1]) {
                tempY = (yLabels.length - 1) - (i - (yLabels[i] - y).abs()/yLabels[i]).abs();
            }
          }
          rawBarGroups.add(makeGroupData(index, tempX, tempY));
        }
      }
      if( data.length > 0) {
        incomeCount = data[0]['incomeCount'];
        expenseCount = data[0]['expenseCount'];
        List temp = (data[0]['searchResults'] as List<int>);
        Record record;
        for(int index = 0; index < temp.length; index++) {
          record = (accounts[_selectedAccount]['Transactions'] as List<Record>)[temp[index]];
          if( record.getRecordType == 'expense')
            expenses.add(record);
        }
      }

    }
    totalIncome = incExp[0];
    totalExpense = incExp[1];
    total = max(incExp[0],incExp[1]);
    total = max(total,1);
    savings = totalIncome - totalExpense;
    reportData =  {
      'total': total,
      'savings': savings,
      'expenses': expenses,
      'income': data.length > 0 ? data[0]['income']: [],
      'expense': data.length > 0 ? data[0]['expense'] : [], 
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'durationText': durationText,
      'durationPeriod': durationPeriod,
      'incomeCount': incomeCount,
      'expenseCount': expenseCount,
    };
    return {
      '1': xLabels,
      '2': yLabels,
      '3': reportData,
      '4': rawBarGroups,
    };
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    final Color leftBarColor = const Color(0xff53fdd7);
    final Color rightBarColor = const Color(0xffff5182);
    final double width = 7;
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: leftBarColor,
        width: width,
      ),
      BarChartRodData(
        y: y2,
        color: rightBarColor,
        width: width,
      ),
    ]);
  }