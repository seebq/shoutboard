// this is way too specific...
// TODO: make this not blow
function toggle_textarea_and_input_field(dom_id) {
	current_text = $('message_body').getValue();
	type = $('message_message_type').getValue();
	if (type == 'says') {
		$('shout_body_input').replace('<div id="shout_body_input"><%= text_field_tag "message[body]", '', :id => "message_body", :size => "60", :class => "says" %></div>');
	} else {
		$('shout_body_input').replace('<div id="shout_body_input"><%= text_area_tag "message[body]", '', :id => "message_body", :class => "codes"%></div>');
	}
	$('message_body').setValue(current_text);
}


function focus_on_shout() {
	$$("#message_body").focus();
}