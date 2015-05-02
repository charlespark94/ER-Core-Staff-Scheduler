function expandSidebar() {
	$('#sidebar-wrapper').css('width', '250px')
	$('#wrapper').css('padding-left', '250px')
	$('#expander').css('display', 'none')
}

function shrinkSidebar() {
	$('#sidebar-wrapper').css('width', '0px')
	$('#wrapper').css('padding-left', '0px')
	$('#expander').css('display', 'block')
}

function expandOrShrink() {
	if ($('#wrapper').css('padding-left') == '0px') {
		$('#sidebar-wrapper').css('width', '250px')
		$('#wrapper').css('padding-left', '250px')
		$('#sidebar-show').html('<<')
	} else {
		$('#sidebar-wrapper').css('width', '0px')
		$('#wrapper').css('padding-left', '0px')
		$('#sidebar-show').html('>>')
	}
}