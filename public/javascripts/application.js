// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function verifyVariationsQuantity()
{
    var inputs = $$("div.variations input[type=\"text\"]");
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].value > 0)
            return true
    }
    $("variations-quantity-notice").show(); // .highlight();
    return false;
}
