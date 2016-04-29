
function parseJSONtoMap(data){
    //"{"arr":[{"key":"fs_temperature_323397","value":{"tid":"fs_temperature_323397","width":240,"height":200,"upperLimit":100,"lowerLimit":0,"numberSuffix":"℃","bgcolor":"#f3f5f7","gaugeFillColor":"#ffc420"}}]}"
    var map = new Map();
    if(data && data.arr.length > 0){
      for(var i=0;i<data.arr.length;i++){
        map.put(data.arr[i].key,data.arr[i].value);
      }
    }
    return map;
}


<!--Map工具类-->
function Map() {
  var struct = function(key, value) {
    this.key = key;
    this.value = value;
  }

  var put = function(key, value) {
    for (var i = 0; i < this.arr.length; i++) {
      if (this.arr[i].key === key) {
        this.arr[i].value = value;
        return;
      }
    }
    this.arr[this.arr.length] = new struct(key, value);
  }

  var get = function(key) {
    for (var i = 0; i < this.arr.length; i++) {
      if (this.arr[i].key === key) {
        return this.arr[i].value;
      }
    }
    return null;
  }

  var remove = function(key) {
    var v;
    for (var i = 0; i < this.arr.length; i++) {
      v = this.arr.pop();
      if (v.key === key) {
        continue;
      }
      this.arr.unshift(v);
    }
  }

  var size = function() {
    return this.arr.length;
  }

  var isEmpty = function() {
    return this.arr.length <= 0;
  }
  this.arr = new Array();
  this.get = get;
  this.put = put;
  this.remove = remove;
  this.size = size;
  this.isEmpty = isEmpty;
}