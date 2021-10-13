document.addEventListener('DOMContentLoaded', function () {
    "use strict";

    var hide_after_closing = true,
        set_position       = document.querySelectorAll(".set-position"),
        set_color          = document.querySelectorAll(".set-color"),
        cookie_notice      = document.querySelectorAll(".simple-cookies"),
        cookie_notice_id      = document.querySelector("#simple-cookies"),
        clear_cookie       = document.querySelector(".clear-cookie");

    function setCookie(name, value, days) {
        var expires = "";
        if (days) {
            var date = new Date();
            date.setTime(date.getTime() + (days*24*60*60*1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + (value || "")  + expires + "; path=/";
    }

    function getCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for(var i=0;i < ca.length;i++) {
            var c = ca[i];
            while (c.charAt(0)===' ') c = c.substring(1,c.length);
            if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length,c.length);
        }
        return null;
    }

    function eraseCookie(name) {
        document.cookie = name +'=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
    }

    var cookie_closer = document.querySelectorAll(".js-close");

    if (!Element.prototype.matches) {
        Element.prototype.matches =
            Element.prototype.matchesSelector ||
            Element.prototype.mozMatchesSelector ||
            Element.prototype.msMatchesSelector ||
            Element.prototype.oMatchesSelector ||
            Element.prototype.webkitMatchesSelector ||
            function(s) {
                var matches = (this.document || this.ownerDocument).querySelectorAll(s),
                    i = matches.length;
                while (--i >= 0 && matches.item(i) !== this) {}
                return i > -1;
            };
    }

    function getParent(el, sel) {
        if (typeof el.closest === 'function') {
            return el.closest(sel) || null;
        }
        while (el) {
            if (el.matches(sel)) {
                return el;
            }
            el = el.parentElement;
        }
        return null;
    }

    if(cookie_closer){
        if( cookie_closer ){
            for (var c=0; c<cookie_closer.length; c++){
               var closer = cookie_closer[c];

                if( closer ){
                    closer.onclick = function (e) {
                        var href = e.target.getAttribute("href");
                        if( href ){
                            if( href === "#" ){
                                e.preventDefault();
                            }
                        }

                        if(hide_after_closing) {
                            setCookie("simple-cookie", "closed", 30);
                        }

                        cookie_notice_id.classList.add("hidden");
                    };
                }
            }
        }
    }

    if( clear_cookie ){
        clear_cookie.onclick = function (e) {
            eraseCookie("simple-cookie");
        };
    }

    if( set_position ){
        for (var s=0; s<set_position.length; s++){
            var pos = set_position[s];

            if(pos){
                pos.onclick = function (e) {
                    e.preventDefault();

                    eraseCookie("simple-cookie");

                    var position_btn = e.target,
                        parent = getParent(position_btn, ".flex-buttons"),
                        all_buttons = parent.querySelectorAll(".flex-btn"),
                        position_attr = position_btn.getAttribute("data-position");

                    if( all_buttons ){
                        for(var b=0; b<all_buttons.length; b++){
                            all_buttons[b].classList.remove("active");
                        }
                    }

                    position_btn.classList.add("active");

                    const remove_positions = ['top', 'bottom', 'left', 'right', 'hidden'];

                    if( position_btn && position_attr && cookie_notice){
                        for (var r=0; r<remove_positions.length; r++ ){
                            cookie_notice_id.classList.remove(remove_positions[r]);
                        }

                        cookie_notice_id.classList.add(position_attr);
                    }
                };
            }
        }
    }

    if( set_color ){
        for (var j=0; j<set_color.length; j++){
            var color = set_color[j];

            if(color){
                color.onclick = function (e) {
                    e.preventDefault();

                    eraseCookie("simple-cookie");

                    var color_btn = e.target,
                        parent = getParent(color_btn, ".flex-buttons"),
                        all_buttons = parent.querySelectorAll(".flex-btn"),
                        color_attr = color_btn.getAttribute("data-color");

                    if( all_buttons ){
                        for(var b=0; b<all_buttons.length; b++){
                            all_buttons[b].classList.remove("active");
                        }
                    }

                    color_btn.classList.add("active");

                    const remove_classes = ['default', 'light', 'dark', 'hidden'];

                    for (var r=0; r<remove_classes.length; r++ ){
                        cookie_notice_id.classList.remove(remove_classes[r]);
                    }

                    cookie_notice_id.classList.add(color_attr);
                };
            }
        }
    }


    if( !hide_after_closing && getCookie("simple-cookie") ){
        eraseCookie("simple-cookie");
    }

    if( !getCookie("simple-cookie") ){
        if( cookie_notice){
            for (var g=0; g<cookie_notice.length; g++){
                var notice = cookie_notice[g];
                notice.classList.add("active");
            }
        }
    }

});