
class Record {
  //['RecordID','Amount','Note','Payee','RecordType','Label','Category','PaymentType','RecordDate','AccountID'],
  int _recordID;
  int _acccountID;

  String _category;
  double _amount;
  String _note;
  List<String> _label;
  String _payee;
  DateTime _recordDate;
  String _recordType;
  String _paymentType;

  Record({double amount,String category,String recordType,DateTime recordDate,
    int recordID =-1,int accountID = -1 ,String note="",String payee="",String paymentType="",List<String> label}) {
    this._amount = amount;
    this._category = category;
    this._recordType = recordType;
    this._recordDate = recordDate;
    this._note = note;
    this._recordID =_recordID;
    this._acccountID = accountID;
    this._payee = payee;
    this._paymentType = paymentType;
    if(label == null) {
      this._label = new List<String>(5);
      this._label[0] = null;
    }
    else
      this._label = label;
  }

   factory Record.fromMap(Map<String, dynamic> data) {
    return Record(
      amount: data['Amount'],
      category: data['Category'],
      recordType: data['RecordType'],
      recordDate: DateTime.parse(data['RecordDate']),
      accountID: data['AccountID'],
      note: data['Note'],
      label: data['Label'].split(','),
      payee: data['Payee'],
      paymentType: data['PaymentType'],
      recordID: data['RecordID']
    ); 
  } 

  Map<String, dynamic> toMap() => {
    'Amount': this._amount,
    'Category': this._category,
    'RecordType': this._recordType,
    'RecordDate': this._recordDate.toString(),
    'AccountID': this._acccountID,
    'Note': this._note,
    'Label': (this._label.join(',')).toString(),
    'Payee': this._payee,
    'PaymentType': this._paymentType,
    'RecordID': this._recordID,
  }; 

  void display() {
    print(_acccountID);
    print(_amount);
    print(_category);
    print(_label);
    print(_note);
    print(_payee);
    print(_paymentType);
    print(_recordDate);
    print(_recordID);
    print(_recordType);
  }
  int get getRecordID => _recordID;

  set setRecordID(int recordID) => this._recordID = recordID;

  int get getAcccountID => _acccountID;

  set setAcccountID(int acccountID) => this._acccountID = acccountID;

  String get getCategory => _category;

  set setCategory(String value) => _category = value;

  double get getAmount => _amount;

  set setAmount(double value) => _amount = value;

  String get getNote => _note;

  set setNote(String value) => _note = value;

  List<String> get getLabel => _label;

  set setLabel(List<String> value) => _label = value;

  String getSingleLabel(int index) => index < 5 ? _label[index] : 'Index Out of Range';

  void setSingleLabel(int index,String value) { 
    if(_label == null) {
      _label = new List(5);
    }
    if(_label.indexOf(value) != -1)
      return;
    if(index < 5) {
      if(index >= _label.length) {
        _label.add(value);
      }
      else {
        _label[index] = value;
      }
    }
  }
  void removeLabel(int index) {
    if(index<_label.length)
      _label.removeAt(index);
  }
  String get getPayee => _payee;

  set setPayee(String value) => _payee = value;

  String get getRecordType => _recordType;

  set setRecordType(String value) => _recordType = value;

  DateTime get getRecordDate => _recordDate;

  set setRecordDate(DateTime date) => _recordDate = date;

  String get getPaymentType => _paymentType;

  set setPaymentType(String value) => _paymentType = value;

  void addLabel(String label) {
    if(this._label.length < 5)
      this._label.add(label);
  }

  void setAll(Record newTx) {
    this._acccountID = newTx._acccountID;
    this._recordID = newTx._recordID;
    this._amount = newTx._amount;
    this._category = newTx._category;
    this._label = newTx._label;
    this._payee = newTx._payee;
    this._paymentType = newTx._paymentType;
    this._recordDate = newTx._recordDate;
    this._recordType = newTx._recordType;
    this._note = newTx._note;
  }
}