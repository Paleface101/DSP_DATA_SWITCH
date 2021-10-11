# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  ipgui::add_page $IPINST -name "Page 0"

  ipgui::add_param $IPINST -name "DATA_WIDTH_IN_BYTES"

}

proc update_PARAM_VALUE.DATA_WIDTH_IN_BYTES { PARAM_VALUE.DATA_WIDTH_IN_BYTES } {
	# Procedure called to update DATA_WIDTH_IN_BYTES when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH_IN_BYTES { PARAM_VALUE.DATA_WIDTH_IN_BYTES } {
	# Procedure called to validate DATA_WIDTH_IN_BYTES
	return true
}


proc update_MODELPARAM_VALUE.DATA_WIDTH_IN_BYTES { MODELPARAM_VALUE.DATA_WIDTH_IN_BYTES PARAM_VALUE.DATA_WIDTH_IN_BYTES } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH_IN_BYTES}] ${MODELPARAM_VALUE.DATA_WIDTH_IN_BYTES}
}

