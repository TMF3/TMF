__EXEC(\
	_fnc_sizeEx = {\
		_pixelScale = 20 * pixelScale;\
		_size = _this select 0;\
		_size = _size * _pixelScale;\
		_coef = _this select 1;\
		_sizes = _this select 2;\
		_sizeEx = _sizes select 0;\
		{\
			_xSize = _x * _coef;\
			_cond = _xSize < _size;\
			if _cond then {_sizeEx = _xSize;};\
		} foreach _sizes;\
		_sizeEx = _sizeEx / _pixelScale;\
		_bracketL = tostring [40];\
		_bracketR = tostring [41];\
		_pixelH = _bracketL + "1 / " + _bracketL + "getResolution select 3" + _bracketR + _bracketR;\
		str _sizeEx + " * " + _pixelH + " * pixelGrid * " + str pixelScale\
	};\
	_fnc_colorRGBAtoHEX = {\
		_colorRGB = _this;\
		_colorHEX = "";\
		_colorCount = count _colorRGB - 1;\
		for "_i" from 0 to _colorCount do {\
			_color = _colorRGB select _i;\
			_color = _color * 255;\
			_color = round _color;\
			_color2 = _color % 16;\
			_color1 = _color - _color2;\
			_color1 = _color1 / 16;\
			_colorHEX1 = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"] select _color1;\
			_colorHEX2 = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"] select _color2;\
			_colorHEX + _colorHEX1 + _colorHEX2;\
			_colorHEX = switch _i do {\
				case 3: {_colorHEX1 + _colorHEX2 + _colorHEX;};\
				default {_colorHEX + _colorHEX1 + _colorHEX2;};\
			};\
		};\
		_colorHEX = "#" + _colorHEX;\
		_colorHEX;\
	};\
	_fnc_colorHEXtoRGBA = {\
		_colorHEX = _this select 0;\
		_index = _this select 1;\
		_index2 = _index + 1;\
		_colorRGBA = [];\
		_colorHEXarray = toarray _colorHEX;\
		_color = "0x" + tostring [_colorHEXarray select _index,_colorHEXarray select _index2];\
		_color = call compile _color;\
		_color * 0.00392157\
	};\
	_fnc_colorHEXtoRGBA_0 = {[_this,0] call _fnc_colorHEXtoRGBA};\
	_fnc_colorHEXtoRGBA_2 = {[_this,2] call _fnc_colorHEXtoRGBA};\
	_fnc_colorHEXtoRGBA_4 = {[_this,4] call _fnc_colorHEXtoRGBA};\
	_fnc_colorHEXtoRGBA_6 = {[_this,6] call _fnc_colorHEXtoRGBA};\
)