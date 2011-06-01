// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}

function newCondition(owner_name) {
  var basic = "<%=escape_javascript(render :partial => "common/condition",
                                           :locals => {
                                             :f => ActionView::Helpers::FormBuilder.new(
                                               '__owner__[conditions_attributes][__index__]',
                                               Condition.new, self, {}, proc {})
                                           })%>";
  var index = new Date() * 1 + parseInt(Math.random()*100000);
  while (basic.indexOf("__owner__") != -1) basic = basic.replace("__owner__", owner_name);
  while (basic.indexOf("__index__") != -1) basic = basic.replace("__index__", index);
  return basic;
}

document.on('ajax:before', 'a.add_message_condition', function(evt) {
  $("message_conditions").update($("message_conditions").innerHTML + newCondition("message"));
  evt.stop();
});


