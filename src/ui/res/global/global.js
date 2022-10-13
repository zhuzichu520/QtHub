String.prototype.bool = function() {
    return (/^true$/i).test(this);
};

function toString(exp){
    if(isString(exp)){
        return exp
    }
    return ""
}

//在对象的拷贝方法中比较困扰的就是深层拷贝，此方法为深层拷贝；
function deepCopy (data) {
  return JSON.parse(JSON.stringify(data));
}

//判断是否为对象（仅为对象，不是数组也不是null）
function isObject(exp) {
    return Object.prototype.toString.call(exp) === '[object Object]'
}

//判断是否为数组（仅为数组，不是对象也不是null）
function isArray(exp) {
    return Object.prototype.toString.call(exp) === '[object Array]'
}

//判断是否为字符串
function isString(exp) {
    return Object.prototype.toString.call(exp) === '[object String]'
}

//判断是否为数字（包括整数和实数）
function isNumber(exp) {
    return Object.prototype.toString.call(exp) === '[object Number]'
}

//判断是否为null
function isNull(exp) {
    return Object.prototype.toString.call(exp) === '[object Null]'
}

//判断是否为undefined
function isUndefined(exp) {
    return Object.prototype.toString.call(exp) === '[object Undefined]'
}

//判断是否无值
function noValue(exp) {
    if (isUndefined(exp) || isNull(exp)) {
        return true
    }
    return false
}
