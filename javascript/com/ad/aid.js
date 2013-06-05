/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * 
 * PROTOTYPES
 * 
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
if(!typeOf(Function.prototype.bind)){
	Function.prototype.bind = function(){ 
		var method = this;
		var params = Array.prototype.slice.call(arguments), object = params.shift();
		return function(){
			return method.apply(object, params.concat(Array.prototype.slice.call(arguments)));
		};
	};
}

if(!typeOf(String.prototype.relay)){
	String.prototype.relay = function(){
		var params = Array.prototype.slice.call(arguments);
		var pattern = new RegExp('%([1-' + params.length + '])', 'g');
		return this.replace(pattern, function(match, index){
			return params[index-1];
		});
	};
}

if(!typeOf(String.prototype.repeat)){
	String.prototype.repeat = function(times){
		return new Array(uint(times) + 2).join(this);
	};
}

if(!typeOf(String.prototype.trim)) {
	String.prototype.trim = function () {
		return this.replace(/^\s+|\s+$/g,'');
	};
}

if(!typeOf(String.prototype.leftPad)){
	String.prototype.leftPad = function(padChar, times){
		var source = String(this);
		var padding = '';
		times = num(times);
		if (source.length < times) {
			while (padding.length + source.length < times) {
				padding += padChar;
			}
			return padding + source;
		}
		return source;
	};
}

if(!typeOf(String.prototype.rightPad)){
	String.prototype.rightPad = function(padChar, times){
		var source = String(this);
		times = num(times);
		while (source.length < times) {
			source += padChar;
		}
		return source;
	};
}

if(!typeOf(Array.prototype.shuffle)){
	Array.prototype.shuffle = function(){
		var total = this.length;
		var index, temp;
		for (var id = total-1; id >= 0; id--){
			index = Math.floor(Math.random() * total);
			temp = this[id];
			this[id] = this[index];
			this[index] = temp;
		}
		return this;
	}
}

if(!typeOf(Array.prototype.indexOf)){
	Array.prototype.indexOf = function(value){
		for(var id = 0; id < this.length; id++){
			if(this[id] == value){
				return id;
			}
		}
		return -1;
	};
}

if(!typeOf(Array.prototype.sortOn)){
	Array.prototype.sortOn = function(key){
		this.sort(function(a, b){
			return (a[key] > b[key]) - (a[key] < b[key]);
		});
	};
}

if(!typeOf(Array.prototype.contains)){
	Array.prototype.contains = function(value){
		return this.indexOf(value) != -1;
	};
}

if(!typeOf(Array.prototype.remove)){
	Array.prototype.remove = function(value){
		if(this.indexOf(value) != -1){
			this.splice(this.indexOf(value), 1);
		}
		return this;
	};
}

if(!typeOf(Array.prototype.count)){
	Array.prototype.count = function(value) {
		var total = 0;
		var index = this.length;
		var total = index - 1;
		while(index-- && this.indexOf(value) != -1){
			if (index != total) {
				total++;
			}
		}
		return total;
	}
}

if(!typeOf(Number.prototype.toRadians)){
	Number.prototype.toRadians = function(){
		return this * Math.PI / 180;
	}
}

if(!typeOf(Number.prototype.toDegrees)){
	Number.prototype.toDegrees = function(){
		return this * 180 / Math.PI;
	}
}

if(!Math.sinE0){
	Math.sinE0 = function(value){
		value = num(value);
		return Math.sin(value === 0 ? 0.000001 : value);
	};
}

if(!Math.cosE0){
	Math.cosE0 = function(value){
		value = num(value);
		return Math.cos(value === 0 ? 0.000001 : value);
	};
}

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * 
 * FIX NATIVE VARIABLES
 * 
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
window.navigator.getUserMedia = window.navigator.getUserMedia||window.navigator.webkitGetUserMedia||window.navigator.mozGetUserMedia||window.navigator.msGetUserMedia;
window.URL = window.URL||window.webkitURL;

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * 
 * FIX NATIVE METHODS
 * 
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
(function(){
	'use strict';
	var lastTime = 0;
	var vendors = ['ms', 'moz', 'webkit', 'o'];
	var currTime, timeToCall, id;
	for(var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x){
		window.requestAnimationFrame = window[vendors[x]+'RequestAnimationFrame'];
		window.cancelAnimationFrame = window[vendors[x]+'CancelAnimationFrame']||window[vendors[x]+'CancelRequestAnimationFrame'];
	}
	if(!window.requestAnimationFrame){
		window.requestAnimationFrame = function(callback, element){
			currTime = new Date().getTime();
			timeToCall = Math.max(0, 16 - (currTime - lastTime));
			id = window.setTimeout(function(){
				callback(currTime + timeToCall);
			}, timeToCall);
			lastTime = currTime + timeToCall;
			return id;
		};
	}
	if(!window.cancelAnimationFrame){
		window.cancelAnimationFrame = function(id){
			window.clearTimeout(id);
		};
	}
}());

(function(){
	'use strict';
	var method;
	var noop = function noop(){/*N/A*/};
	var methods = [
		'assert', 'clear', 'count', 'debug', 'dir', 'dirxml', 'error',
		'exception', 'group', 'groupCollapsed', 'groupEnd', 'info', 'log',
		'markTimeline', 'profile', 'profileEnd', 'table', 'time', 'timeEnd',
		'timeStamp', 'trace', 'warn'
	];
	var length = methods.length;
	var console = window.console = (window.console||{});
	while(length--){
		method = methods[length];
		if(!console[method]){
			console[method] = noop;
		}
	}
	window.trace = console.log.bind(console);
}());

/*------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 * 
 * UTILS METHODS
 * 
 ------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
function foreach(haystack, callback, dontIgnoreFunctions){
	for(var key in haystack){
		if(typeOf(haystack[key]) != 'function' || dontIgnoreFunctions){
			callback(key, haystack[key]);
		}
	}
}

function getDefinitionByName(name, params, scope){
	params = params||[];
	if(typeOf(name) === 'object'){
		return name;
	}
	scope = getValueByName(name, scope);
	if(typeOf(scope) === 'function'){
		params = JSON.stringify(params);
		params = params.replace(/^\[|\]$/g, '');
		return eval('new '+scope+'('+params+');');
	}else if (typeOf(scope) !== 'object'){
		return null;
	}
	return scope;
}

function getValueByName(name, scope){
	scope = scope||window;
	name = name||'';
	var keys = name.split('.');
	var matches = [];
	var id = -1;
	while(++id < keys.length){
		if(scope[keys[id]]){
			scope = scope[keys[id]];
			matches.push(scope);
		}
	}
	return matches.length == keys.length ? scope : null;
}

function getDefinitionName(value, strict){
	// Object.prototype.toString.apply(value);
	if(value === false) return 'Boolean';
	if(value === '') return 'String';
	if(value === 0) return 'Number';
	if(value && value['constructor']){
		var name = value.constructor.toString()
		.replace(/^.*function([^\s]*|[^\(]*)\([^\x00]+$/, '$1')
		.replace(/\s+/, '');
		if(strict !== true)
		if(!/^(Boolean|RegExp|Number|String|Array|Date)$/.test(name)){
			return 'Object';
		}
		return name;
	}
	return value;
}

function typeOf(value, strict){
	var type = typeof value;
	if(value === false) return 'boolean';
	if(value === '') return 'string';
	if(value && type === 'object'){
		type = getDefinitionName(value, strict);
		type = String(type).toLowerCase();
	}
	if(type === 'number' && !isNaN(value) && isFinite(value)){
		if(strict == true && parseFloat(value) == parseInt(value, 10)){
			return value < 0 ? 'int' : 'uint';
		}
		return 'number';
	}
	return value ? type : value;
}

function equals(){
	var xValue, yValue, xType, yType;
	for(var x = 0; x < arguments.length; x++){
		for(var y = 0; y < arguments.length; y++){
			xValue = arguments[x];
			xType = typeOf(xValue, true);
			yValue = arguments[y];
			yType = typeOf(yValue, true);
			if(xType === yType){
				switch(xType){
					case 'regexp':
						xValue = String(xValue);
						yValue = String(yValue);
						break;
					case 'object':
					case 'array':
						xValue = JSON.stringify(xValue);
						yValue = JSON.stringify(yValue);
						break;
				}
				if(xValue !== yValue){
					return false;
				}
			}
			if(!xType || !yType){
				xValue = String(xValue);
				yValue = String(yValue);
			}
			if(xValue !== yValue){
				return false;
			}
		}
	}
	return true;
}

function test(type, value){
	var regex, types, indexNumber;
	if(typeOf(type) !== 'string'){
		return false;
	}
	types = type.split('|');
	indexNumber = types.indexOf('number');
	if(indexNumber > -1){
		types[indexNumber] = '('+ types[indexNumber] + '|uint|int)';
		type = types.join('|');
	}
	regex = new RegExp('^('+ type +')$', 'g');
	return regex.test(typeOf(value, arguments[2]));
}

function randomRange(min, max, floor){
	min = num(min) || value;
	max = num(max) || value;
	if (floor === true) return Math.floor(Math.random() * (max - min + 1)) + min;
	return (Math.random() * (max - min + 1)) + min;
}

function interpolate(value, min, max) {
	value = num(value);
	min = num(min) || value;
	max = num(max) || value;
	return min + (max - min) * value;
}

function normalize(value, min, max) {
	value = num(value);
	min = num(min) || value;
	max = num(max) || value;
	return (value - min) / (max - min);
}

function map(value, min1, max1, min2, max2) {
	return interpolate(normalize(value, min1, max1), min2, max2);
}

function mod(index, min, max) {
	min = num(min);
	max = num(max);
	index = num(index) % max;
	return((index < min) ? (index + max) : index);
}

function clamp(value, min, max){
	value = num(value);
	min = num(min) || value;
	max = num(max) || value;
	return((value > max) ? max : (value < min ? min : value));
}

function bool(value){
	if(typeOf(value) === 'string'){
		return /^(true|(^[1-9][0-9]*$)$|yes|y|sim|s|on)$/gi.test(value);
	}
	return !!value;
}

function num(value, ceiling){
	value = String(value).replace(/(px|pt|pc|mm|cm|in|ex|em|%)$/gi, '');
	value = Number(value);
	value = ((isNaN(value) || !isFinite(value)) ? 0 : value);
	if (ceiling === true) {
		value = parseInt(value * 10000) / 10000;
	}
	return value;
}

function uint(value){
	value = int(value);
	return value < 0 ? 0 : value;
}

function int(value){
	return Math.round(num(value));
}

function clone(value){
	return JSON.parse(JSON.stringify(value));
}