import "Memory.dart";
import "Record.dart";

List<Map> _durations = [
  {'startDay' : 1, 'endDay': 31}, //jan1
  {'startDay' : 1, 'endDay': 28}, //feb2
  {'startDay' : 1, 'endDay': 31}, //march3
  {'startDay' : 1, 'endDay': 30}, //april4
  {'startDay' : 1, 'endDay': 31}, //may5
  {'startDay' : 1, 'endDay': 30}, //june6
  {'startDay' : 1, 'endDay': 31}, //july7
  {'startDay' : 1, 'endDay': 31}, //august8
  {'startDay' : 1, 'endDay': 30}, //sept9
  {'startDay' : 1, 'endDay': 31}, //oct10
  {'startDay' : 1, 'endDay': 30}, //nov11
  {'startDay' : 1, 'endDay': 31}, //dec12
];

List getRecords(int accountIndex,{String property = ""}) {
  Set matches = {};
  int index = 0;
  
  if(accounts[accountIndex].containsKey('Transactions') && accounts[accountIndex]['Transactions'] != null)
    (accounts[accountIndex]['Transactions'] as List<Record>).forEach( (record) {
      if(property != "") {
        if(record.getPayee.contains(property))
          matches.add(index);
        else if(record.getCategory.contains(property))
          matches.add(index);
        else if(record.getPaymentType.contains(property))
          matches.add(index);
        else if(record.getRecordType.contains(property))
          matches.add(index);
        else if(record.getNote.contains(property)) 
          matches.add(index);
        record.getLabel.forEach( (label) {
          if(label.contains(property))
          matches.add(index);
        });
      }
      else 
        matches.add(index);
      index++;
    });
  return matches.toList();
}

List<Map<String,Object>> getWeekRecords(List results,int accountIndex,{int returnType}) {
  
  List<Map<String,Object>> finalResults = [];
  DateTime duration;
  List tempIndices;
  double tempIncome,tempExpense;
  List<double> returnType3 = [0.0,0.0];
  List<double> income = [];
  List<double> expense = [];
  List<int> indices = [];
  int incomeCount = 0,expenseCount = 0;
  double total = 0;
  if(results != null && results.length > 0) {
    for(int day = 0; day< 7; day++) {
      duration = DateTime.now().subtract( Duration(days: day));
      tempIndices = [];
      tempIncome = 0;
      tempExpense = 0;
      for(int index = 0; index < results.length; index++) {
        if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.year == duration.year && 
        (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.month == duration.month && 
        (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.day == duration.day) { 
          tempIndices.add(results[index]);
          indices.add(results[index]);
  
          if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordType == 'income')
            tempIncome += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
          else
            tempExpense += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
        }
      }
      finalResults.add({
        'Indices': tempIndices,
        'Sum': tempIncome - tempExpense,
        'Income': tempIncome,
        'Expense': tempExpense
      });
      total += tempIncome - tempExpense;
      returnType3[0] += tempIncome; returnType3[1] += tempExpense;
      income.add(tempIncome);
      expense.add(tempExpense);
      if(tempIncome > 0) incomeCount++;
      if(tempExpense > 0) expenseCount++;
    }
  }
  if(returnType == 2){
    return [{
    'incExp': returnType3,
    'income': income,
    'expense': expense,
    'Sum' : total,
    'incomeCount': incomeCount,
    'expenseCount': expenseCount,
    'searchResults': indices,
    }];
  }
  else
    return finalResults;
}

List<Map<String,Object>> getMonthRecord2(List results,int accountIndex,{int month = 0,int returnType}) {
  List tempIndices;
  double tempIncome,tempExpense;
  List returnType3 = [0.0,0.0];
  List<double> income = [];
  List<double> expense = [];
  List<int> indices = [];
  int incomeCount = 0,expenseCount = 0;
  List<Map<String,Object>> finalResults = [];
  double total = 0;
  for(int index = 0; index < results.length; index++) {
    tempIndices = [];
    tempIncome = 0;
    tempExpense = 0;
    if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.month ==  month) {
      tempIndices.add(results[index]);
      indices.add(results[index]);
      if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordType == 'income')
        tempIncome += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
      else
        tempExpense += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
    }
    finalResults.add({
      'Indices': tempIndices,
      'Sum': tempIncome - tempExpense,
      
    });
    total += tempIncome - tempExpense;
    returnType3[0] += tempIncome; returnType3[1] += tempExpense;
    income.add(tempIncome);
    expense.add(tempExpense);
    if(tempIncome > 0) incomeCount++;
    if(tempExpense > 0) expenseCount++;
  }
  if(returnType == 2){
    return [{
    'incExp': returnType3,
    'income': income,
    'expense': expense,
    'incomeCount': incomeCount,
    'Sum' : total,
    'expenseCount': expenseCount,
    'searchResults': indices,
    }];
  }
  else
    return finalResults;
}

List<Map<String,Object>> getMonthRecords(List results,int accountIndex,{int month = 0,int returnType}) {
  List<Map<String,Object>> finalResults = [];
  DateTime duration;
  int day = 7;
  DateTime time = DateTime.now();
  List tempIndices;
  double total = 0;
  double tempIncome,tempExpense;
  List<double> income = [];
  List<double> expense = [];
  List<int> indices = [];
  int incomeCount = 0,expenseCount = 0;
  List returnType3 = [0.0,0.0];
  if(month != 0)
    time.subtract(Duration(days: DateTime.now().month - ((DateTime.now().month - month) * 30)));
  for(int week = 0; week < 5 ; week++) {
    duration = time.subtract( Duration(days: day));
    tempIndices = [];
    tempIncome = 0;
    tempExpense = 0;

    for(int index = 0; index < results.length; index++) {

      if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.isAfter(duration) &&
      (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.isBefore(time) && 
      (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.month == time.month)  {

        tempIndices.add(results[index]);
        indices.add(results[index]);

        if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordType == 'income')
          tempIncome += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
        else
          tempExpense += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
      }
    }
    finalResults.add({
      'Indices': tempIndices,
      'Sum': tempIncome - tempExpense,
      
    });
    total += tempIncome - tempExpense;
    returnType3[0] += tempIncome; returnType3[1] += tempExpense;
    income.add(tempIncome);
    expense.add(tempExpense);
    if(tempIncome > 0) incomeCount++;
    if(tempExpense > 0) expenseCount++;
    time = duration;
  }
  if(returnType == 2){
    return [{
      'incExp': returnType3,
      'income': income,
      'expense': expense,
      'Sum' : total,
      'incomeCount': incomeCount,
      'expenseCount': expenseCount,
      'searchResults': indices,
      }];
  }
  else
    return finalResults;
}

List<Map<String,Object>> getDayRecord(List results,int accountIndex,{int day = 0,int returnType}) {
  List tempIndices;
  double tempIncome,tempExpense;
  List returnType3 = [0.0,0.0];
  List<double> income = [];
  List<double> expense = [];
  List<int> indices = [];
  int incomeCount = 0,expenseCount = 0;
  List<Map<String,Object>> finalResults = [];
  double total = 0;
  for(int index = 0; index < results.length; index++) {
    tempIndices = [];
    tempIncome = 0;
    tempExpense = 0;
    if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.weekday ==  day) {
      tempIndices.add(results[index]);
      indices.add(results[index]);
      if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordType == 'income')
        tempIncome += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
      else
        tempExpense += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
    }
    finalResults.add({
      'Indices': tempIndices,
      'Sum': tempIncome - tempExpense,
      
    });
    total += tempIncome - tempExpense;
    returnType3[0] += tempIncome; returnType3[1] += tempExpense;
    income.add(tempIncome);
    expense.add(tempExpense);
    if(tempIncome > 0) incomeCount++;
    if(tempExpense > 0) expenseCount++;
  }
  if(returnType == 2){
    return [{
    'incExp': returnType3,
    'income': income,
    'expense': expense,
    'incomeCount': incomeCount,
    'Sum' : total,
    'expenseCount': expenseCount,
    'searchResults': indices,
    }];
  }
  else
    return finalResults;
}



List<Map<String,Object>> getRecordsinRange(DateTime start, DateTime end,List results,int accountIndex,{int returnType}) {
  List tempIndices;
  double tempIncome,tempExpense;
  List returnType3 = [0.0,0.0];
  List<double> income = [];
  List<double> expense = [];
  List<int> indices = [];
  int incomeCount = 0,expenseCount = 0;
  List<Map<String,Object>> finalResults = [];
  double total = 0;
  for(int index = 0; index < results.length; index++) {
    tempIndices = [];
    tempIncome = 0;
    tempExpense = 0;
    if(((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.year == start.year && 
    (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.month == start.month && 
    (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.day == start.day) || 
    (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.isBefore(end) ) {

      tempIndices.add(results[index]);
      indices.add(results[index]);
      if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordType == 'income')
        tempIncome += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
      else
        tempExpense += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
    }
    finalResults.add({
      'Indices': tempIndices,
      'Sum': tempIncome - tempExpense,
      
    }); 
    total += tempIncome - tempExpense;
    returnType3[0] += tempIncome; returnType3[1] += tempExpense;
    income.add(tempIncome);
    expense.add(tempExpense);
    if(tempIncome > 0) incomeCount++;
    if(tempExpense > 0) expenseCount++;
  }
  if(returnType == 2){
    return [{
    'Sum' : total,
    'incExp': returnType3,
    'income': income,
    'expense': expense,
    'incomeCount': incomeCount,
    'expenseCount': expenseCount,
    'searchResults': indices,
    }];
  }
  else
    return finalResults;
}

DateTime oldestRecord(List<Record> records) {
  DateTime tempOld = DateTime.now();
  for(int i = 0; i < records.length; i++) {
    if ( records[i].getRecordDate.isBefore(tempOld)) {
      tempOld = records[i].getRecordDate;
    }
  }
  return tempOld;
}

List<Map<String,Object>> get6MonthsRecords(List results,int accountIndex,{int returnType}) {
  List<Map<String,Object>> finalResults = [];
  List tempIndices;
  double tempIncome,tempExpense;
  List returnType3 = [0.0,0.0];
  List<double> income = [];
  List<double> expense = [];
  List<int> indices = [];
  int incomeCount = 0,expenseCount = 0;
  DateTime duration,time = DateTime.now();
  int tempMonth;
  double total = 0;
  for(int month = 0; month < 6 ; month++) {
    tempMonth = _durations[time.month -1]['endDay']; 
    if(DateTime.now().year % 4 == 0 && time.month == 2) 
      tempMonth += 1;
    time = new DateTime(time.year, time.month, tempMonth,);
    duration = new DateTime(time.year, time.month, _durations[time.month -1]['startDay'],);
    tempIndices = [];
    tempIncome = 0;
    tempExpense = 0;

    for(int index = 0; index < results.length; index++) {
      if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.isAfter(duration) &&
      (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.isBefore(time) && 
      (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.month == time.month) {
        
        tempIndices.add(results[index]);
        indices.add(results[index]);

        if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordType == 'income')
          tempIncome += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
        else
          tempExpense += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
      }
    }
    time = duration.subtract(Duration(days: 1));
    finalResults.add({
      'Indices': tempIndices,
      'Sum': tempIncome - tempExpense,
      
    });
    total += tempIncome - tempExpense;
    returnType3[0] += tempIncome; returnType3[1] += tempExpense;
    income.add(tempIncome);
    expense.add(tempExpense);
    if(tempIncome > 0) incomeCount++;
    if(tempExpense > 0) expenseCount++;
  }
  if(returnType == 2){
    return [{
    'incExp': returnType3,
    'income': income,
    'Sum' : total,
    'expense': expense,
    'incomeCount': incomeCount,
    'expenseCount': expenseCount,
    'searchResults': indices,
    }];
  }
  else
    return finalResults;
}


List<Map<String,Object>> get12MonthsRecords(List results,int accountIndex,{int returnType}) {
  List<Map<String,Object>> finalResults = [];
  List tempIndices;
  double tempIncome,tempExpense;
  List returnType3 = [0.0,0.0];
  List<double> income = [];
  List<double> expense = [];
  List<int> indices = [];
  int incomeCount = 0,expenseCount = 0;
  DateTime duration,time = DateTime.now();
  int tempMonth;
  double total = 0;
  for(int month = 0; month < 12 ; month++) {
    tempMonth = _durations[time.month -1]['endDay']; 
    if(DateTime.now().year % 4 == 0 && time.month == 2) 
      tempMonth += 1;
    time = new DateTime(time.year, time.month, tempMonth,);
    duration = new DateTime(time.year, time.month, _durations[time.month -1]['startDay'],);
    tempIndices = [];
    tempIncome = 0;
    tempExpense = 0;

    for(int index = 0; index < results.length; index++) {
      if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.isAfter(duration) &&
      (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.isBefore(time) && 
      (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.month == time.month) {
        
        tempIndices.add(results[index]);
        indices.add(results[index]);

        if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordType == 'income')
          tempIncome += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
        else
          tempExpense += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
      }
    }
    time = duration.subtract(Duration(days: 1));
    finalResults.add({
      'Indices': tempIndices,
      'Sum': tempIncome - tempExpense,
      
    });
    total += tempIncome - tempExpense;
    returnType3[0] += tempIncome; returnType3[1] += tempExpense;
    income.add(tempIncome);
    expense.add(tempExpense);
    if(tempIncome > 0) incomeCount++;
    if(tempExpense > 0) expenseCount++;
  }
  if(returnType == 2){
    return [{
    'incExp': returnType3,
    'Sum' : total,
    'income': income,
    'expense': expense,
    'incomeCount': incomeCount,
    'expenseCount': expenseCount,
    'searchResults': indices,
    }];
  }
  else
    return finalResults;
}

List<Map<String,Object>> getYearRecords(List results,int accountIndex,{int returnType}) {
  List<Map<String,Object>> finalResults = [];
  List tempIndices;
  double tempIncome,tempExpense;
  List returnType3 = [0.0,0.0];
  List<double> income = [];
  List<double> expense = [];
  List<int> indices = [];
  int incomeCount = 0,expenseCount = 0;
  double total = 0;
  DateTime time = DateTime.now();
  int limit = DateTime.now().year - oldestRecord(accounts[accountIndex]['Transactions']).year;
  for(int year = 0; year < limit + 1 ; year++) {
    tempIndices = [];
    tempIncome = 0;
    tempExpense = 0;
    time = new DateTime( (DateTime.now().year - year), 12 , 31);
    for(int index = 0; index < results.length; index++) {
      if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordDate.year == time.year) {
        tempIndices.add(results[index]);
        indices.add(results[index]);

        if((accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getRecordType == 'income')
          tempIncome += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
        else
          tempExpense += (accounts[accountIndex]['Transactions'] as List<Record>)[results[index]].getAmount;
      }
    }
    finalResults.add({
      'Indices': tempIndices,
      'Sum': tempIncome - tempExpense,
      
    }); 
    total += tempIncome - tempExpense;
    returnType3[0] += tempIncome; returnType3[1] += tempExpense;
    income.add(tempIncome);
    expense.add(tempExpense);
    if(tempIncome > 0) incomeCount++;
    if(tempExpense > 0) expenseCount++;
  }
  if(returnType == 2){
    return [{
    'incExp': returnType3,
    'Sum' : total,
    'income': income,
    'expense': expense,
    'incomeCount': incomeCount,
    'expenseCount': expenseCount,
    'searchResults': indices,
    }];
  }
  else
    return finalResults;
}