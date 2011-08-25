// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function verifyVariationsQuantity()
{
    var inputs = $$("div.variations input[type=\"text\"]");
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].highlight();
        if (inputs[i].value > 0)
            return true
    }
    $("variations-quantity-notice").show(); // .highlight();
    return false;
}

function bindStars() {
    var stars = $$("ul.star-rating a");
    stars.each(function(a) {
        Event.observe(a, 'click', function(e) {
            var score = a.className.split("-").last();
            $("comment_score").value = score;
            $$("li.current-rating").last().setStyle({
                width: score * 20 + "%"
            });
        });
    });
}

function bindAddsRemoves() {
    $$("span.add,span.remove").each(function(ele) {
        Event.observe(ele, 'click', function(e) {
            var input = ele.up().select("input[type=\"text\"]").first();
            var v = Number(input.value);
            if (v <= 0 && ele.className == "remove")
                return false;
            input.value = v + (ele.className == "add" ? 1 : -1);
        });
    });
}