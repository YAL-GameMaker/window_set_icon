#include "gml_ext.h"
extern bool window_set_icon_init_raw(double isRGBA);
dllx double window_set_icon_init_raw_raw(void* _in_ptr, double _in_ptr_size) {
	gml_istream _in(_in_ptr);
	double _arg_isRGBA;
	_arg_isRGBA = _in.read<double>();
	return window_set_icon_init_raw(_arg_isRGBA);
}

