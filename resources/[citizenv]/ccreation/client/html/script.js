var documentWidth = document.documentElement.clientWidth;
var documentHeight = document.documentElement.clientHeight;

var cursor = document.getElementById("cursor");
var cursorX = documentWidth / 2;
var cursorY = documentHeight / 2;

function UpdateCursorPos() {
    cursor.style.left = cursorX;
    cursor.style.top = cursorY;
}

function Click(x, y) {
    var element = $(document.elementFromPoint(x, y));
    element.focus().click();
    return true;
}

$(function() {
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type == "enableui") {
            cursor.style.display = item.enable ? "block" : "none";
            document.body.style.display = item.enable ? "block" : "none";
        }
        if (item.type == "click") {
            // Avoid clicking the cursor itself, click 1px to the top/left;
            Click(cursorX - 1, cursorY - 1);
        }
    });

    $(document).mousemove(function(event) {
        cursorX = event.pageX;
        cursorY = event.pageY;
        UpdateCursorPos();
    });

    document.onkeyup = function (data) {
        // if (data.which == 27) { // Escape key
        //     $.post('http://ccreation/escape', JSON.stringify({}));
        // }
    };

    $(".dialog-selectorf").fadeOut(10);
    $("input[name=gender][value='0']").prop("checked", true);
    $("input[name=outfit][value='1']").prop("checked", true);
    $("input[name=hair]").val(0);
    $("input[name=color]").val(0);
    $("input[name=face]").val(0);


    var sickvar = true;
    $(document).ready(function() {
      $("input[name=gender]").on('change', function(){
      if (sickvar){
        $(".dialog-selector").fadeOut(10);
        $(".dialog-selectorf").fadeIn(10);
        sickvar = !sickvar;
      }else{
        $(".dialog-selectorf").fadeOut(10);
        $(".dialog-selector").fadeIn(10);
        sickvar = !sickvar;
      }
      });
    });


    $('input[name=gender]').on('click change', function(){
        $.post('http://ccreation/updateGender', JSON.stringify({
            gender: $('input[name=gender]:checked', '#login-form').val()
        }));
    });

    $('input[name=face]').bind('click keyup', function(){
        $.post('http://ccreation/updateFace', JSON.stringify({
            face: $('input[name=face]', '#login-form').val()
        }));
    });

    $('input[name=hair]').bind('click keyup', function(){
        $.post('http://ccreation/updateHair', JSON.stringify({
            hairy: $('input[name=hair]', '#login-form').val(),
            hairysec: $('input[name=hairsec]', '#login-form').val(),
            hairycolor: $('input[name=haircolor]', '#login-form').val(),
            hairycolorsec: $('input[name=haircolorsec]', '#login-form').val()
        }));
    });

    $('input[name=hairsec]').bind('click keyup', function(){
        $.post('http://ccreation/updateHair', JSON.stringify({
            hairy: $('input[name=hair]', '#login-form').val(),
            hairysec: $('input[name=hairsec]', '#login-form').val(),
            hairycolor: $('input[name=haircolor]', '#login-form').val(),
            hairycolorsec: $('input[name=haircolorsec]', '#login-form').val()
        }));
    });

    $('input[name=haircolor]').bind('click keyup', function(){
        $.post('http://ccreation/updateHair', JSON.stringify({
            hairy: $('input[name=hair]', '#login-form').val(),
            hairysec: $('input[name=hairsec]', '#login-form').val(),
            hairycolor: $('input[name=haircolor]', '#login-form').val(),
            hairycolorsec: $('input[name=haircolorsec]', '#login-form').val()
        }));
    });

    $('input[name=haircolorsec]').bind('click keyup', function(){
        $.post('http://ccreation/updateHair', JSON.stringify({
            hairy: $('input[name=hair]', '#login-form').val(),
            hairysec: $('input[name=hairsec]', '#login-form').val(),
            hairycolor: $('input[name=haircolor]', '#login-form').val(),
            hairycolorsec: $('input[name=haircolorsec]', '#login-form').val()
        }));
    });

    $("#login-form").submit(function(e) {
        e.preventDefault(); // Prevent form from submitting

        $.post('http://ccreation/login', JSON.stringify({
            username: $("#username").val().trim(),
            password: $("#password").val().trim(),
            outfit: $('input[name=outfit]:checked', '#login-form').val(),
            gender: $('input[name=gender]:checked', '#login-form').val(),
            hair: $('input[name=hair]', '#login-form').val(),
            hairsec: $('input[name=hairsec]', '#login-form').val(),
            haircolor: $('input[name=haircolor]', '#login-form').val(),
            haircolorsec: $('input[name=haircolorsec]', '#login-form').val(),
            face: $('input[name=face]', '#login-form').val()
        }));
    });
});
