
class AddNew {
  String name="";
  String price="";
  String numberPhone="";
  String description="";

  AddNew(String _name, String _price, String _numberPhone, String _description){
    name= _name;
    price=_price;
    numberPhone= _numberPhone;
    description= _description;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "name": name,
      "price": price,
      "numberphone": numberPhone,
      "description": description,
    };
    return map;
  }
}
