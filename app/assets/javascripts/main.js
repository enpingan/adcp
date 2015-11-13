$.extend({
  password: function (length, special) {
    var iteration = 0;
    var password = "";
    var randomNumber;
    if(special == undefined){
        var special = false;
    }
    while(iteration < length){
        randomNumber = (Math.floor((Math.random() * 100)) % 94) + 33;
        if(!special){
            if ((randomNumber >=33) && (randomNumber <=47)) { continue; }
            if ((randomNumber >=58) && (randomNumber <=64)) { continue; }
            if ((randomNumber >=91) && (randomNumber <=96)) { continue; }
            // if ((randomNumber >=123) && (randomNumber <=126)) { continue; }
        }
        iteration++;
        password += String.fromCharCode(randomNumber);
    }
    return password;
  }
});

function trimLeadZero(s) {
  return s.replace(/^0+/, "");
}

function _fix() {
  //Get window height and the wrapper height
  var height = $(window).height() - $("body > .header").height();
  $(".wrapper").css("min-height", height + "px");
  var content = $(".wrapper").height();

  // var tmp = $('.left-side.sidebar-offcanvas').height() + $('.left-side').offset().length > 0 ? $('.left-side').offset().top : 0;
  var tmp_pad = $('.left-side').length > 0 ? $('.left-side').offset().top : 0;
  var tmp = $('.left-side.sidebar-offcanvas').height() + tmp_pad;
  var tmp2 = $('.left-side.sidebar-offcanvas').height();
  var tmp3 = content + 50;
  var tmp4 = height + 50;

  // console.log(tmp3, tmp);
  
  //If the wrapper height is greater than the window
  if (content > height) {
    //then set sidebar height to the wrapper
    if ( $(window).height() < 500 ) {
      if ( $(document).height() < 507 ) {
        $('.left-side').css('min-height', tmp3 - 50 );
        $('.right-side').css('min-height', tmp + 'px');
      } else {
        $(".left-side").css("min-height", content + "px");
        $('.right-side').css('min-height', $('.left-side').height() + 50 );
        
        if ( window.location.href.indexOf('new') > 0 || window.location.href.indexOf('edit') > 0 ) {
          // $('.right-side').css('min-height', tmp3);  
          $('.right-side').css('min-height', $('.box.box-info').length >= 2 ? $('.box.box-info').eq($('.box.box-info').length-1).offset().top + 25+ $('.box.box-info').eq($('.box.box-info').length-1).outerHeight() : tmp3 );
        } else {
          if ( $('.listing').length > 0 && window.location.href.indexOf('search') == -1 ) {
            $('.left-side').css('min-height', $('.listing').offset().top + $('.listing').outerHeight() );
            $('.right-side').css('min-height', $('.left-side').height() + 50 );

            if ( $('#qmail_notice').length > 0 ) {
              $('.left-side').css('min-height', content );
            }
          } else {
            if ( window.location.href.indexOf('search') > 0 ) {
              $('.left-side').css('min-height', $('.listing').eq($('.listing').length - 1).offset().top + $('.listing').eq($('.listing').length - 1).outerHeight() + 50 );
              $('.right-side').css('min-height', $('.left-side').height() + 50 );
            } else {
              if ( $('.btn.btn-default').length > 0 ) {
                $('.left-side').css('min-height', $('.btn.btn-default.btn-td').offset().top + $('.btn.btn-default.btn-td').outerHeight() + 50 );
                $('.right-side').css('min-height', $('.left-side').height() + 50 );
              } else {
                 $('.right-side').css('min-height', $('.comment_listbox').eq($('.comment_listbox').length - 1).offset().top + $('.comment_listbox').eq($('.comment_listbox').length - 1).outerHeight() > $('#div_addcomment').offset().top + $('#div_addcomment').outerHeight() ? $('.comment_listbox').eq($('.comment_listbox').length - 1).offset().top + $('.comment_listbox').eq($('.comment_listbox').length - 1).outerHeight() + 50 : $('#div_addcomment').offset().top + $('#div_addcomment').outerHeight() + 50 );
              }
            }
          }
        }          
      }
    } else {
      $(".left-side").css("min-height", content + "px");
      
      if ( window.location.href.indexOf('new') > 0 || window.location.href.indexOf('edit') > 0 ) {
        $('.right-side').css('min-height', $('.box.box-info').length >= 2 ? $('.box.box-info').eq($('.box.box-info').length-1).offset().top + 25+ $('.box.box-info').eq($('.box.box-info').length-1).outerHeight() : tmp3 );
      } else {
        if ( $('.listing').length > 0 ) {

        // } else if ( window.location.href.indexOf('tickets/') > 0 || window.location.href.indexOf('scustomers/') > 0) {
        } else if ( window.location.href.indexOf('tickets/') > 0 ) {

        } else {
          $('.left-side').css('min-height', $('.btn.btn-default.btn-td').offset().top + $('.btn.btn-default.btn-td').outerHeight() + 50 );
          $('.right-side').css('min-height', $('.left-side').height() + 50 );
        }
      }
    }
  } else {
    //Otherwise, set the sidebar to the height of the window
    $(".left-side").css("min-height", height + "px");

    if ( $(window).height() < 500 ) {

      if ( $(document).height() < 507 ) {
        $('.left-side').css('min-height', tmp2 + 'px');
        $('.right-side').css('min-height', tmp + 'px');
      } else {
        $(".left-side").css("min-height", height + "px");
        $('.right-side').css('min-height', $('.left-side').height() + 50 );
        
        if ( window.location.href.indexOf('new') > 0 || window.location.href.indexOf('edit') > 0 ) {
          $('.right-side').css('min-height', $('.box.box-info').length >= 2 ? $('.box.box-info').eq($('.box.box-info').length-1).offset().top + 25+ $('.box.box-info').eq($('.box.box-info').length-1).outerHeight() : tmp3 );
        } else if ( window.location.href.indexOf('tickets/') > 0 ) {

        } else {
          $('.left-side').css('min-height', $('.listing').offset().top + $('.listing').outerHeight() );
          $('.right-side').css('min-height', $('.left-side').height() + 50 );
        }
      }
    } else {
      $(".left-side").css("min-height", height + "px");
      
      if ( window.location.href.indexOf('new') > 0 || window.location.href.indexOf('edit') > 0 ) {
        $('.right-side').css('min-height', $('.box.box-info').length >= 2 ? $('.box.box-info').eq($('.box.box-info').length-1).offset().top + 25+ $('.box.box-info').eq($('.box.box-info').length-1).outerHeight() : tmp3 );
      } else {

      }
    }
  }
}

function isValidEmailAddress(emailAddress) {
  var pattern = new RegExp(/^[+A-Za-z0-9._-]+@[A-Za-z0-9-]+\.[a-zA-Z]{2,4}$/i);
  return pattern.test(emailAddress);
}

var getRandomWord = function () {
  return words[Math.floor(Math.random() * words.length)];
};

function gen_frontid()
{
  var text = "";
  var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  for( var i=0; i < 4; i++ )
    text += possible.charAt(Math.floor(Math.random() * possible.length));

  return text;
}

function gen_endid()
{
  var text = "";
  var possible = "1234567890";

  for( var i=0; i < 6; i++ )
    text += possible.charAt(Math.floor(Math.random() * possible.length));

  return text;
}

function show_loading() {
  $('.wrapper.row-offcanvas.row-offcanvas-left').css('opacity', '0.2');
  // $('#loading_canvas').css('left', )
  $('#loading_canvas').css('display', 'block');
}

function hide_loading() {
  $('#loading_canvas').css('display', 'none');
  $('.wrapper.row-offcanvas.row-offcanvas-left').css('opacity', '1');
}

function setCookie(c_name, value, exdays) {
  var exdate = new Date();
  exdate.setDate(exdate.getDate() + exdays);
  var c_value = escape(value) + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
  document.cookie = c_name + "=" + c_value;
}

function getCookie(c_name) {
  var i, x, y, ARRcookies = document.cookie.split(";");
  for (i = 0; i < ARRcookies.length; i++) {
    x = ARRcookies[i].substr(0, ARRcookies[i].indexOf("="));
    y = ARRcookies[i].substr(ARRcookies[i].indexOf("=") + 1);
    x = x.replace(/^\s+|\s+$/g, "");
    if (x == c_name) {
        return unescape(y);
    }
  }
}

function DeleteCookie(name) {
  document.cookie = name + '=; expires=Thu, 01-Jan-70 00:00:01 GMT;';
}


jQuery(document).ready(function($) {
  // show_loading();

  $(window).load(function () {
   //if IsRefresh cookie exists
   var IsRefresh = getCookie("IsRefresh");
   if (IsRefresh != null && IsRefresh != "") {
      // refreshing page
      // show_loading();
      DeleteCookie("IsRefresh");
   }
   else {
      // show_loading();
      setCookie("IsRefresh", "true", 1);
   }
  });

  var b_clicked = false;

  $('#res_menu2').dropdown();
  $('#res_menu2').dropdown({on: 'hover'});

  // combo box init
  $('#select_ticket_rows').dropdown();
  $('#select_account_rows').dropdown();
  $('#select_device_rows').dropdown();

  // detect enter key event
  $('#form_login').keypress(function (e) {
    var key = e.which;

    if(key == 13)  // the enter key code
    {
      show_loading();
      $('#form_login').submit();
    }
  });

  $(document).on('click', '#btn_device_submit', function() {
    tmp = '___.___.___.___';
    if (tmp == $('#device_public_ip').val() && tmp == $('#device_public_ip').val() ) {
      return false;
    }
  });
  
  // submit rows {
  $(document).on('click', '#select_ticket_rows .menu > .item', function() {
    $('#ticket_rows').val($(this).text());
    $.get('/tickets.js',
      {
        'ticket_rows' : $('#ticket_rows').val()
      });
    // $('#form_ticket_setrows').submit();
  });

  $(document).on('click', '#select_account_rows .menu > .item', function() {
    $('#account_rows').val($(this).text());
    // $('#form_account_setrows').submit();
    $.get('/accounts.js',
      {
        'account_rows' : $('#account_rows').val()
      });
  });

  $(document).on('click', '#select_configure_rows .menu > .item', function() {
    $('#configure_rows').val($(this).text());
    $.post('/devices/configure.js',
      {
        'configure_rows' : $('#configure_rows').val()
      });
  });

  $(document).on('click', '#select_device_rows .menu > .item', function() {
    $('#device_rows').val($(this).text());
    // $('#form_device_setrows').submit();
    $.get('/devices.js',
      {
        'device_rows' : $('#device_rows').val()
      });
  });

  $(document).on('click', '#select_verified_rows .menu > .item', function() {
    $('#verified_rows').val($(this).text());
    // $('#form_verified_setrows').submit();
    $.get('/verifieds.js',
      {
        'verified_rows' : $('#verified_rows').val()
      });
  });

  $(document).on('click', '#select_customer_rows .menu > .item', function() {
    $('#customer_rows').val($(this).text());
    // $('#form_customer_setrows').submit();
    $.get('/customers.js',
      {
        'customer_rows' : $('#customer_rows').val()
      });
  });

  $(document).on('click', '#select_pcustomer_rows .menu > .item', function() {
    $('#pcustomer_rows').val($(this).text());
    // $('#form_pcustomer_setrows').submit();
    $.get('/pcustomers.js',
      {
        'pcustomer_rows' : $('#pcustomer_rows').val()
      });
  });

  $(document).on('click', '#select_scustomer_rows .menu > .item', function() {
    $('#scustomer_rows').val($(this).text());
    // $('#form_scustomer_setrows').submit();
    $.get('/scustomers.js',
      {
        'scustomer_rows' : $('#scustomer_rows').val()
      });
  });

  $(document).on('click', '#select_sadmin_rows .menu > .item', function() {
    $('#sadmin_rows').val($(this).text());
    // $('#form_scustomer_setrows').submit();
    $.get('/sadmins.js',
      {
        'sadmin_rows' : $('#sadmin_rows').val()
      });
  });
  // submit rows }

  // check boxes {
  $(document).on('click', '#chk_showpwd', function() {
    if ( $('#account_hs_pwd').get(0).type == "password" )
      $('#account_hs_pwd').get(0).type = "text"
    else 
      $('#account_hs_pwd').get(0).type = "password"
  });

  $(document).on('click', '#chk_showtoken', function() {
    if ( $('#new_pwd').get(0).type == "password" )
      $('#new_pwd').get(0).type = "text"
    else 
      $('#new_pwd').get(0).type = "password"

    if ( $('#account_hs_pwd').get(0).type == "password" )
      $('#account_hs_pwd').get(0).type = "text"
    else 
      $('#account_hs_pwd').get(0).type = "password"
  });

  $(document).on('click', '#chk_showpwd2', function() {
    if ( $('#verified_password').get(0).type == "password" )
      $('#verified_password').get(0).type = "text"
    else 
      $('#verified_password').get(0).type = "password"

    if ( $('#ver_new_pwd').get(0).type == "password" )
      $('#ver_new_pwd').get(0).type = "text"
    else 
      $('#ver_new_pwd').get(0).type = "password"
  });

  $(document).on('click', '#chk_showpwd3', function() {
    if ( $('#sadmin_password').get(0).type == "password" )
      $('#sadmin_password').get(0).type = "text"
    else 
      $('#sadmin_password').get(0).type = "password"

    if ( $('#sad_new_pwd').get(0).type == "password" )
      $('#sad_new_pwd').get(0).type = "text"
    else 
      $('#sad_new_pwd').get(0).type = "password"
  });
  // pcustomer
  $(document).on('click', '#cus_chk_showpwd1', function() {
    if ( $('#pcustomer_password').get(0).type == "password" )
      $('#pcustomer_password').get(0).type = "text"
    else 
      $('#pcustomer_password').get(0).type = "password"

    if ( $('#pus_new_pwd').get(0).type == "password" )
      $('#pus_new_pwd').get(0).type = "text"
    else 
      $('#pus_new_pwd').get(0).type = "password"
  });
  // customer
  $(document).on('click', '#cus_chk_showpwd2', function() {
    if ( $('#customer_password').get(0).type == "password" )
      $('#customer_password').get(0).type = "text"
    else 
      $('#customer_password').get(0).type = "password"

    if ( $('#cus_new_pwd').get(0).type == "password" )
      $('#cus_new_pwd').get(0).type = "text"
    else 
      $('#cus_new_pwd').get(0).type = "password"
  });

  $(document).on('click', '#cus_chk_showpwd3', function() {
    if ( $('#scustomer_password').get(0).type == "password" )
      $('#scustomer_password').get(0).type = "text"
    else 
      $('#scustomer_password').get(0).type = "password"

    if ( $('#sus_new_pwd').get(0).type == "password" )
      $('#sus_new_pwd').get(0).type = "text"
    else 
      $('#sus_new_pwd').get(0).type = "password"
  });

  $(document).on('click', '#submit_filter_account', function() {
    show_loading();
    $('#form_filter_accounts').submit();
  });

  $(document).on('click', '#All_Permissions', function() {
    if ( $('#All_Permissions').is(':checked') )
      $('.acheck').prop('checked', true);
    else 
      $('.acheck').prop('checked', false);
  });
  // check boxes }

  // device list filter item {
  $(document).on('click', '#filter_post .menu > .item', function() {
    $('#filter_item').val($.trim($(this).attr('data-value')));

    $.get('/devices.js',
      {
        'search' : $('#search').val(), 
        'filter_item' : $('#filter_item').val()
      });
  });
  
  // device list filter item }
  function encryptor(pwd) {
    // Create Base64 Object
    var Base64={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3}}return t}}

    // Encode the String
    var encodedString = Base64.encode(pwd);
    return encodedString;
  }

  $(document).on('click', '.a_loading', function() {
    show_loading();
  });

  // account form {
  $(document).on('click', '#btn_generator', function() {
    s_name = "AD" + gen_endid();

    $('#account_ssl_name').val(s_name);
    tmp = $('#account_ssl_name').val();
    $('#account_ssl_name').val(tmp);

    // txt = "cyberadvance." + tmp + ".com";
    tmp = gen_frontid().toLowerCase();
    password = tmp + $.password(20,true);
    // $('#account_hs_pwd').val(password);

    // $('#account_pwd').val(encryptor(password));

    return false;
  });

  $(document).on('click', '#btn_generator_pwd', function() {
    if ( $('#account_pwd').length > 0 )  {
      if ( $('#account_pwd').attr('data') == encryptor($('#cur_pwd').val()) || ( $('#account_pwd').attr('data') == null && $('#btn_generator_pwd').attr('disabled') == null ) ) {
        tmp = gen_frontid().toLowerCase();
        password = tmp + $.password(20,true);

        $('#new_pwd').val(password);
        $('#account_hs_pwd').val(password);
        $('#account_pwd').val(encryptor(password));

        confirm_same('#new_pwd', '#account_hs_pwd');
      }
    }    
  });

  $(document).on('input', '#cur_pwd', function() {

    if ( $('#account_pwd').length > 0 ) {
      if ( $('#account_pwd').attr('data') == encryptor($(this).val()) ) {
        $('#btn_generator_pwd').css('pointerEvents', 'auto');
        $('#btn_generator_pwd').removeAttr('disabled');

        $('#new_pwd').removeAttr('disabled');
        $('#account_hs_pwd').removeAttr('disabled');
        $('#text_check1').css('display', 'block');
        $(this).css('padding-right', '50px');
      } else {
        $('#btn_generator_pwd').css('pointerEvents', 'none');
        $('#btn_generator_pwd').attr('disabled', 'disabled');

        $('#new_pwd').attr('disabled', 'disabled');
        $('#account_hs_pwd').attr('disabled', 'disabled');
        $('#text_check1').css('display', 'none');
        $(this).css('padding-right', '10px');
      }
      // console.log( $('#account_pwd').attr('data') , encryptor($(this).val()) );
      // $('#account_pwd').val(encryptor($(this).val()));
    }
  });

  function confirm_same(text_one, text_two) {
    if ( $(text_one).length > 0 && $(text_two).length > 0 ) {
      if ( $(text_one).val() == $(text_two).val() ) {
        $('#label_same').html('<i class="fa fa-fw fa-check"></i>&nbsp;Same');
        return true;
      } else {
        $('#label_same').html('<i class="fa fa-fw fa-times-circle"></i>&nbsp;Not same');
        return false;
      }
    } else {
      return false;
    }
  }

  $(document).on('input', '#new_pwd', function() {
    confirm_same('#new_pwd', '#account_hs_pwd');
  });

  $(document).on('input', '#account_hs_pwd', function() {
    $('#account_pwd').val(encryptor($(this).val()));
    confirm_same('#new_pwd', '#account_hs_pwd');
  });

  // account form }

  // verified form {
  $(document).on('click', '#btn_generator2', function() {
    s_name = "AD" + gen_endid();

    $('#verified_username').val(s_name);
    tmp = $('#verified_username').val();
    $('#verified_username').val(tmp);

    // tmp = gen_frontid().toLowerCase();
    // password = tmp + $.password(20,true);
    // $('#verified_password').val(password);

    return false;
  });

  $(document).on('input', '#ver_cur_pwd', function() {

    if ( $('#ver_pwd').length > 0 ) {
      if ( $('#ver_pwd').attr('data') == encryptor($(this).val()) ) {

        $('#btn_generator_pwd2').css('pointerEvents', 'auto');
        $('#btn_generator_pwd2').removeAttr('disabled');

        $('#ver_new_pwd').removeAttr('disabled');
        $('#verified_password').removeAttr('disabled');
        $('#text_check1').css('display', 'block');
        $(this).css('padding-right', '50px');
      } else {
        
        $('#btn_generator_pwd2').css('pointerEvents', 'none');
        $('#btn_generator_pwd2').attr('disabled', 'disabled');

        $('#ver_new_pwd').attr('disabled', 'disabled');
        $('#verified_password').attr('disabled', 'disabled');
        $('#text_check1').css('display', 'none');
        $(this).css('padding-right', '10px');
      }
      // $('#ver_pwd').val(encryptor($(this).val()));
    }
  });

  $(document).on('click', '#btn_generator_pwd2', function() {
    if ( $('#cgodp').length > 0 ) {
      tmp = gen_frontid().toLowerCase();
      password = tmp + $.password(20,true);

      $('#ver_new_pwd').val(password);
      $('#verified_password').val(password);
      $('#ver_pwd').val(encryptor(password));

      confirm_same('#ver_new_pwd', '#verified_password');
    }

    if ( $('#ver_pwd').length > 0 )  {
      if ( $('#ver_pwd').attr('data') == encryptor($('#ver_cur_pwd').val()) || ( $('#ver_pwd').attr('data') == null && $('#btn_generator_pwd2').attr('disabled') == null ) ) {
        tmp = gen_frontid().toLowerCase();
        password = tmp + $.password(20,true);

        $('#ver_new_pwd').val(password);
        $('#verified_password').val(password);
        $('#ver_pwd').val(encryptor(password));

        confirm_same('#ver_new_pwd', '#verified_password');
      }
    }    
  });

  $(document).on('input', '#ver_new_pwd', function() {
    confirm_same('#ver_new_pwd', '#verified_password');
  });

  $(document).on('input', '#verified_password', function() {
    $('#account_pwd').val(encryptor($(this).val()));
    confirm_same('#ver_new_pwd', '#verified_password');
  });


  // verified form }

  // sadmin form {

  $(document).on('click', '#btn_sgenerator', function() {
    s_name = "AD" + gen_endid();

    $('#sadmin_username').val(s_name);
    tmp = $('#sadmin_username').val();

    $('#sadmin_username').val(tmp);

    // tmp = gen_frontid().toLowerCase();
    // password = tmp + $.password(20,true);
    // $('#sadmin_password').val(password);

    return false;
  });

  $(document).on('input', '#sad_cur_pwd', function() {

    if ( $('#sad_pwd').length > 0 ) {
      if ( $('#sad_pwd').attr('data') == encryptor($(this).val()) ) {

        $('#btn_generator_pwd3').css('pointerEvents', 'auto');
        $('#btn_generator_pwd3').removeAttr('disabled');

        $('#sad_new_pwd').removeAttr('disabled');

        $('#sadmin_password').removeAttr('disabled');
        $('#text_check1').css('display', 'block');
        $(this).css('padding-right', '50px');
      } else {
        
        $('#btn_generator_pwd3').css('pointerEvents', 'none');
        $('#btn_generator_pwd3').attr('disabled', 'disabled');

        $('#sad_new_pwd').attr('disabled', 'disabled');
        $('#sadmin_password').attr('disabled', 'disabled');
        $('#text_check1').css('display', 'none');
        $(this).css('padding-right', '10px');
      }
      // $('#sad_pwd').val(encryptor($(this).val()));
    }
  });

  $(document).on('click', '#btn_generator_pwd3', function() {
    if ( $('#sad_pwd').length > 0 )  {
      if ( $('#sad_pwd').attr('data') == encryptor($('#sad_cur_pwd').val()) || ( $('#sad_pwd').attr('data') == null && $('#btn_generator_pwd3').attr('disabled') == null ) ) {
        tmp = gen_frontid().toLowerCase();
        password = tmp + $.password(20,true);

        $('#sad_new_pwd').val(password);
        $('#sadmin_password').val(password);
        $('#sad_pwd').val(encryptor(password));

        confirm_same('#sad_new_pwd', '#sadmin_password');
      }
    }    
  });

  $(document).on('input', '#sad_new_pwd', function() {
    confirm_same('#sad_new_pwd', '#sadmin_password');
  });

  $(document).on('input', '#sadmin_password', function() {
    $('#account_pwd').val(encryptor($(this).val()));
    confirm_same('#sad_new_pwd', '#sadmin_password');
  });

  // sadmin form }

  // customer form {

  $(document).on('click', '#btn_cus_generator', function() {
    if ( window.location.href.indexOf('/new') > 0 || $('#device_count').length > 0 ) {
      s_name = "CA" + gen_endid();
      $('#customer_username').val(s_name);
    }
    // tmp = $('#customer_username').val();
    // $('#customer_username').val(tmp);
    $('#div_chwarning').fadeIn(150);
    $('#changing_order').attr('required', true);

    _fix();
    
    return false;
  });

  $(document).on('click', '.btn_chwarning', function() {
    
    var option = $(this).attr('data');
    var s_name = "CA" + gen_endid();

    switch (option) {
      case "change":
        $('#customer_username').attr('changed') == null ? $('#customer_username').val(s_name) : $('#customer_username').val($('#customer_username').val());
        $('#changing_order').val('change');
        break;
      case "keep":
        $('#customer_username').attr('changed') == null ? $('#customer_username').val(s_name) : $('#customer_username').val($('#customer_username').val());
        $('#changing_order').val('keep');
        break;
      case "cancel":
        $('#changing_order').removeAttr('required');  
        $('#customer_username').val($('#cus_username').attr('data'));
        break;
    }

    $('#div_chwarning').fadeOut(150);
    $('#customer_username').removeAttr('changed');

    return false;
  });

  $(document).on('blur', '#customer_username', function() {

    if ( $(this).val() != $('#cus_username').attr('data') ) {
      $('#customer_username').attr('changed', 'changed');
      $('#changing_order').attr('required', true);
      $('#div_chwarning').fadeIn(150);

      _fix();

    }
  });
  

  $(document).on('input', '#cus_cur_pwd', function() {

    if ( $('#cus_pwd').length > 0 ) {
      if ( $('#cus_pwd').attr('data') == encryptor($(this).val()) ) {

        $('#btn_generator_pwd4').css('pointerEvents', 'auto');
        $('#btn_generator_pwd4').removeAttr('disabled');

        $('#cus_new_pwd').removeAttr('disabled');

        $('#customer_password').removeAttr('disabled');
        $('#text_check1').css('display', 'block');
        $(this).css('padding-right', '50px');
      } else {
        
        $('#btn_generator_pwd4').css('pointerEvents', 'none');
        $('#btn_generator_pwd4').attr('disabled', 'disabled');

        $('#cus_new_pwd').attr('disabled', 'disabled');
        $('#customer_password').attr('disabled', 'disabled');
        $('#text_check1').css('display', 'none');
        $(this).css('padding-right', '10px');
      }
      // $('#cus_pwd').val(encryptor($(this).val()));
    }
  });

  $(document).on('click', '#btn_generator_pwd4', function() {

    if ( $('#cgodp').length > 0 ) {
        tmp = gen_frontid().toLowerCase();
        password = tmp + $.password(20,true);

        $('#cus_new_pwd').val(password);
        $('#customer_password').val(password);
        $('#cus_pwd').val(encryptor(password));

        confirm_same('#cus_new_pwd', '#customer_password');
    }

    if ( $('#cus_pwd').length > 0 )  {
      if ( $('#cus_pwd').attr('data') == encryptor($('#cus_cur_pwd').val() ) ) {

        tmp = gen_frontid().toLowerCase();
        password = tmp + $.password(20,true);

        $('#cus_new_pwd').val(password);
        $('#customer_password').val(password);
        $('#cus_pwd').val(encryptor(password));

        confirm_same('#cus_new_pwd', '#customer_password');
      }
    }

    if ( $('#cus_pwd').attr('data') == null && $('#btn_generator_pwd4').attr('disabled') == null )  {
        tmp = gen_frontid().toLowerCase();
        password = tmp + $.password(20,true);

        $('#cus_new_pwd').val(password);
        $('#customer_password').val(password);
        $('#cus_pwd').val(encryptor(password));

        confirm_same('#cus_new_pwd', '#customer_password');
    }
  });

  $(document).on('input', '#cus_new_pwd', function() {
    confirm_same('#cus_new_pwd', '#customer_password');
  });

  $(document).on('input', '#customer_password', function() {
    $('#account_pwd').val(encryptor($(this).val()));
    confirm_same('#cus_new_pwd', '#customer_password');
  });

  // customer form }

  // scustomer form {

  $(document).on('click', '#btn_scus_generator', function() {
    s_name = "CA" + gen_endid();

    $('#scustomer_username').val(s_name);
    tmp = $('#scustomer_username').val();
    // tmp = tmp.toLowerCase();
    $('#scustomer_username').val(tmp);

    // txt = "cyberadvance." + tmp + ".com";
    // tmp = gen_frontid().toLowerCase();
    // password = tmp + $.password(20,true);
    // $('#scustomer_password').val(password);

    return false;
  }); 

  $(document).on('input', '#sus_cur_pwd', function() {

    if ( $('#sus_pwd').length > 0 ) {
      if ( $('#sus_pwd').attr('data') == encryptor($(this).val()) ) {

        $('#btn_generator_pwd6').css('pointerEvents', 'auto');
        $('#btn_generator_pwd6').removeAttr('disabled');

        $('#sus_new_pwd').removeAttr('disabled');

        $('#scustomer_password').removeAttr('disabled');
        $('#text_check1').css('display', 'block');
        $(this).css('padding-right', '50px');
      } else {
        
        $('#btn_generator_pwd6').css('pointerEvents', 'none');
        $('#btn_generator_pwd6').attr('disabled', 'disabled');

        $('#sus_new_pwd').attr('disabled', 'disabled');
        $('#scustomer_password').attr('disabled', 'disabled');
        $('#text_check1').css('display', 'none');
        $(this).css('padding-right', '10px');
      }
      // $('#sus_pwd').val(encryptor($(this).val()));
    }
  });

  $(document).on('click', '#btn_generator_pwd6', function() {
    
    if ( $('#cgodp').length > 0 ) {
      tmp = gen_frontid().toLowerCase();
      password = tmp + $.password(20,true);

      $('#sus_new_pwd').val(password);
      $('#scustomer_password').val(password);
      $('#sus_pwd').val(encryptor(password));

      confirm_same('#sus_new_pwd', '#scustomer_password');
    }

    if ( $('#sus_pwd').length > 0 )  {
      if ( $('#sus_pwd').attr('data') == encryptor($('#sus_cur_pwd').val()) || ( $('#sus_pwd').attr('data') == null && $('#btn_generator_pwd6').attr('disabled') == null ) ) {
        tmp = gen_frontid().toLowerCase();
        password = tmp + $.password(20,true);

        $('#sus_new_pwd').val(password);
        $('#scustomer_password').val(password);
        $('#sus_pwd').val(encryptor(password));

        confirm_same('#sus_new_pwd', '#scustomer_password');
      }
    }    
  });

  $(document).on('input', '#sus_new_pwd', function() {
    confirm_same('#sus_new_pwd', '#scustomer_password');
  });

  $(document).on('input', '#scustomer_password', function() {
    $('#account_pwd').val(encryptor($(this).val()));
    confirm_same('#sus_new_pwd', '#scustomer_password');
  });

  // scustomer form }

  // pcustomer form {
  $(document).on('click', '#btn_pcus_generator', function() {
    s_name = "CA" + gen_endid();

    $('#pcustomer_username').val(s_name);
    tmp = $('#pcustomer_username').val();
    // tmp = tmp.toLowerCase();
    $('#pcustomer_username').val(tmp);

    // txt = "cyberadvance." + tmp + ".com";
    // tmp = gen_frontid().toLowerCase();
    // password = tmp + $.password(20,true);
    // $('#pcustomer_password').val(password);

    return false;
  });

  $(document).on('input', '#pus_cur_pwd', function() {

    if ( $('#pus_pwd').length > 0 ) {
      if ( $('#pus_pwd').attr('data') == encryptor($(this).val()) ) {

        $('#btn_generator_pwd5').css('pointerEvents', 'auto');
        $('#btn_generator_pwd5').removeAttr('disabled');

        $('#pus_new_pwd').removeAttr('disabled');

        $('#pcustomer_password').removeAttr('disabled');
        $('#text_check1').css('display', 'block');
        $(this).css('padding-right', '50px');
      } else {
        
        $('#btn_generator_pwd5').css('pointerEvents', 'none');
        $('#btn_generator_pwd5').attr('disabled', 'disabled');

        $('#pus_new_pwd').attr('disabled', 'disabled');
        $('#pcustomer_password').attr('disabled', 'disabled');
        $('#text_check1').css('display', 'none');
        $(this).css('padding-right', '10px');
      }
      // $('#pus_pwd').val(encryptor($(this).val()));
    }
  });

  $(document).on('click', '#btn_generator_pwd5', function() {
    if ( $('#pus_pwd').length > 0 )  {
      if ( $('#pus_pwd').attr('data') == encryptor($('#pus_cur_pwd').val()) || ( $('#pus_pwd').attr('data') == null && $('#btn_generator_pwd5').attr('disabled') == null ) ) {
        tmp = gen_frontid().toLowerCase();
        password = tmp + $.password(20,true);

        $('#pus_new_pwd').val(password);
        $('#pcustomer_password').val(password);
        $('#pus_pwd').val(encryptor(password));

        confirm_same('#pus_new_pwd', '#pcustomer_password');
      }
    }    
  });

  $(document).on('input', '#pus_new_pwd', function() {
    confirm_same('#pus_new_pwd', '#pcustomer_password');
  });

  $(document).on('input', '#pcustomer_password', function() {
    $('#account_pwd').val(encryptor($(this).val()));
    confirm_same('#pus_new_pwd', '#pcustomer_password');
  });


  // pcustomer form }

  // combo-box working 
  $(document).on('click', '#select_ticket_subject .menu > .item', function() {
    $('#ticket_subject').val($.trim($(this).text()));
  });
  
  $(document).on('click', '#select_ticket_owner .menu > .item', function() {
    $('#ticket_owner').val($.trim($(this).text()));
    $('#ticket_user_id').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_ticket_name .menu > .item', function() {
    $('#ticket_device').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_device_mailaddr .menu > .item', function() {
    var tmp = $.trim($(this).text()), dc;
    tmp = $(this).attr('data-value');
    $('#device_owner').val(tmp);

    tmp = $(this).attr('data-value').toLowerCase();

    if ( $(this).parent().parent().find('div').find('span').length > 0 ) {
      dc = $(this).parent().parent().find('div').find('span').text();

      if ( dc.length > 0 ) {
        dc = dc.substring(0, dc.length / 2);  
      } else {
        dc = '0';
      }
    } else {
      dc = '0';
    }

    if ( dc == '' )
      dc = '0';

    $('#edit_device_name').val(tmp + "_device_" + dc);
  });

  $(document).on('click', '#select_device_osname .menu > .item', function() {
    $('#device_osname').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_device_osram .menu > .item', function() {
    $('#device_osram').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_device_oscore .menu > .item', function() {
    $('#device_osprocessor').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_device_type .menu > .item', function() {
    $('#device_device_type').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_device_location .menu > .item', function() {
    $('#device_location').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_device_gstatus .menu > .item', function() {
    $('#device_general_status').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_device_greload .menu > .item', function() {
    $('#device_general_reloaded').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_account_country .menu > .item', function() {
    $('#account_country').val($.trim($(this).text()));

  });

  $(document).on('click', '#select_customer_country .menu > .item', function() {
    $('#customer_country').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_verified_country .menu > .item', function() {
    $('#verified_country').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_account_type .menu > .item', function() {
    $('#account_account_type').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_vaccount_type .menu > .item', function() {
    $('#verified_account_type').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_sadmin_type .menu > .item', function() {
    $('#sadmin_account_type').val($.trim($(this).text()));
  });

  $(document).on('click', '#select_adsearch .menu > .item', function() {
    $('#text_sdefault').html('<i class="fa fa-search" style="color:palegoldenrod;"></i>');
    $('#skey').val($.trim($(this).text()));

    show_loading();
    $('#form_global_search').submit();
  });

  
  // table row working
  $(document).on('click', '#table_account .td-clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(2).text();
    var tr_id = "#servers_" + tmp;   
      
    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      con.html('<i class="fa fa-fw fa-angle-down" style="font-size:18px;"></i>');
      $(tr_id).fadeIn(300);
    } else {   
      con.html('<i class="fa fa-fw fa-angle-right" style="font-size:18px;"></i>');
      $(tr_id).fadeOut(300);
    }

    _fix();
  });

  $(document).on('click', '#table_sadmin .td-clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(2).text();
    var tr_id = "#sservers_" + tmp;   
      
    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      con.html('<i class="fa fa-fw fa-angle-down" style="font-size:18px;"></i>');
      $(tr_id).fadeIn(300);
    } else {   
      con.html('<i class="fa fa-fw fa-angle-right" style="font-size:18px;"></i>');
      $(tr_id).fadeOut(300);
    }

    _fix();
  });

  $(document).on('click', '#table_verified .td-clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(2).text();
    var tr_id = "#servers_" + tmp;   
      
    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      con.html('<i class="fa fa-fw fa-angle-down" style="font-size:18px;"></i>');
      $(tr_id).fadeIn(300);
    } else {   

      con.html('<i class="fa fa-fw fa-angle-right" style="font-size:18px;"></i>');
      $(tr_id).fadeOut(300);
    }

    _fix();
  });

  $(document).on('click', '#table_customer .td-clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(2).text();
    var tr_id = "#trcus_" + tmp;   
      
    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      con.html('<i class="fa fa-fw fa-angle-down" style="font-size:18px;"></i>');
      $(tr_id).fadeIn(300);
    } else {   
      con.html('<i class="fa fa-fw fa-angle-right" style="font-size:18px;"></i>');
      $(tr_id).fadeOut(300);
    }

    _fix();
  });

  $(document).on('click', '#table_scustomer .td-clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(2).text();
    var tr_id = "#trscus_" + tmp;   
    
    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      con.html('<i class="fa fa-fw fa-angle-down" style="font-size:18px;"></i>');
      $(tr_id).fadeIn(300);
    } else {   
      con.html('<i class="fa fa-fw fa-angle-right" style="font-size:18px;"></i>');
      $(tr_id).fadeOut(300);
    }

    _fix();
  });

  $(document).on('click', '#table_pcustomer .td-clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(2).text();
    var tr_id = "#trpcus_" + tmp;   
    
    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      con.html('<i class="fa fa-fw fa-angle-down" style="font-size:18px;"></i>');
      $(tr_id).fadeIn(300);
    } else {   
      con.html('<i class="fa fa-fw fa-angle-right" style="font-size:18px;"></i>');
      $(tr_id).fadeOut(300);
    }

    _fix();
  });

  $(document).on('click', '#table_devices .td-clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(1).text();
    var tr_id = "#dlist_" + tmp;   
      
    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      $(tr_id).fadeIn(300);
    } else {   
      $(tr_id).fadeOut(300);
    }

    _fix();
  });

  $(document).on('click', '#table_configured .td-clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(1).text();
    var tr_id = "#cdlist_" + tmp;   
      
    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      $(tr_id).fadeIn(300);
    } else {   
      $(tr_id).fadeOut(300);
    }

    _fix();
  });

  $(document).on('click', '#table_userinfo .td-clickable', function(e) { 
    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(0).attr('data');
    var tr_id = "#userinfo_" + tmp;
    
    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      con.html('<i class="fa fa-fw fa-angle-down" style="font-size:18px;color:white;"></i>');
      $(tr_id).fadeIn(300);
    } else {   
      con.html('<i class="fa fa-fw fa-angle-right" style="font-size:18px;color:white;"></i>');
      $(tr_id).fadeOut(300);
    }

    _fix();
  });

  $(document).on('click', '#table_ticket .td-clickable', function(e) {
    // var tmp = $(this).parent().find('td').eq(1).text();
    // tmp = $.trim(tmp);

    // tmp = '#show_ticket_' + tmp;
    // $(tmp).submit();
    var tmp = $(this).parent().find('td').eq(1).text();
    tmp = $.trim(tmp);

    tr_id = '#ticket_' + tmp;
    tmp = $(tr_id).css('display');
    if ( tmp == "none" ) {
      $(tr_id).fadeIn(300);
    } else {   
      $(tr_id).fadeOut(300);
    }
  });

  $(document).on('click', '#table_ticket .td-clickable2', function(e) { 

    var con = $(this).parent().find('td').eq(0);
    var tmp = $(this).parent().find('td').eq(1).text();
    var tr_id = "#ticket_" + $.trim(tmp);   
      
    tmp = $(tr_id).css("display");
    if ( tmp == "none" ) {
      $(tr_id).fadeIn(300);
    } else {   
      $(tr_id).fadeOut(300);
    }

  });

  $(document).on('click', '#btn_reply_show_ticket', function(e) { 
    // $('.simple_form.show').submit();
  });

  $(document).on('click', '.treeview', function(e) { 
    tmp = $(this).attr('class');

    if ( tmp != "treeview active" ) {
      $(this).find('ul').fadeIn(350);
      $(this).attr('class', 'treeview active');
    } else {
      $(this).find('ul').fadeOut(350);
      $(this).attr('class', 'treeview');
    }

    _fix();
  });

  $(document).on('click', '.treeview-menu a', function(e) {
    
  });

  $(document).on('click', '.span_readmore', function(e) { 
    tmp = $(this).parent().parent().find('td').eq(0).attr('data-id');

    tid = '#form_go_userinfo_' + tmp;

    tmp2 = $(this).attr('class');
    // console.log(tmp, tid, tmp2);
    show_loading();
    if ( tmp != 1 && tmp2 != 'clickable' ) {
      $(tid).submit();
    }

    return false;
  });

  $(document).on('click', '.span-close', function(e) { 
    $('.div-notice').css("display", "none");
    $('.div-device-title').css("margin-top","34px");
  });

  $(document).on('click', '.btn-ticlose', function(e) { 
    tmp = $(this).attr('id');
    // btn_ticlose_
    tmp = tmp.substring(12, tmp.length);
    tid = '#ticket_' + tmp;
    $(tid).fadeOut(300);

  });

  $(document).on('click', '.btn-tdclosedev', function(e) { 
    tmp = $(this).attr('id');
    // btn_tdclosedev_
    tmp = tmp.substring(15, tmp.length);
    tid = '#dlist_' + tmp;
    $(tid).fadeOut(300);

    var con = $(this).parent().attr('id');
    fid = '#'+con;

    if ( con ) {
      con = con.substring(13, con.length);
    }

    tid = '#request_order_' + con;
    $(tid).val($.trim($(this).text()));
    
    // form_saction_2

  });

  $(document).on('click', '.btn-tdclosecus', function(e) { 
    tmp = $(this).attr('id');
    // btn_tdclosedev_
    tmp = tmp.substring(15, tmp.length);
    tid = '#trcus_' + tmp;
    $(tid).fadeOut(300);
  });

  // {ssc-sadmin
  $(document).on('click', '.btn-ssc-sadmin', function(e) { 
    tmp = $(this).attr('id');
    // btn_tdclosedev_
    tmp = tmp.substring(8, tmp.length);
    tid = '#cd_sadmin_' + tmp;
    $(tid).fadeIn(300);

  });

  $(document).on('click', '.btn-tdclosea', function() {
    tmp = $(this).attr('id');
    // btn_tdclosea_
    tmp = tmp.substring(13, tmp.length);
    tid = '#cd_sadmin_' + tmp;
    $(tid).fadeOut(150);
  });

  $(document).on('click', '.btn-tdclosesa', function() {
    tmp = $(this).attr('id');
    // btn_tdclosesa_
    tmp = tmp.substring(14, tmp.length);
    tid = '#sservers_' + tmp;
    $(tid).fadeOut(150);
  });  
  // }

  // Delete admin users {

  $(document).on('click', '.btn-sc-verified', function() {
    tmp = $(this).attr('id');
    // btn_sc_
    tmp = tmp.substring(7, tmp.length);
    tid = '#cd_verified_' + tmp;
    $(tid).fadeIn(150);
  });

  $(document).on('click', '.btn-tdclosev', function(e) { 
    tmp = $(this).attr('id');
    // btn_tdclose_
    tmp = tmp.substring(12, tmp.length);
    tid = '#cd_verified_' + tmp;
    $(tid).fadeOut(150);

  });

  $(document).on('click', '.btn-tdcloseve', function(e) { 
    tmp = $(this).attr('id');
    // btn_tdcloseve_
    tmp = tmp.substring(14, tmp.length);
    tid = '#servers_' + tmp;
    $(tid).fadeOut(150);
  });

  // }

  // Delete Ticket {
  $(document).on('click', '.btn-stt', function() {
    tmp = $(this).attr('id');
    // btn_sct_
    tmp = tmp.substring(8, tmp.length);
    tid = '#ticket_' + tmp;
    if ($(tid).css('display') == 'none') {
      $(tid).fadeIn(150);
    } else {
      $(tid).fadeOut(150);
    }
  });

  $(document).on('click', '.btn-sc-ticket', function() {
    tmp = $(this).attr('id');
    // btn_sct_
    tmp = tmp.substring(8, tmp.length);
    tid = '#cd_ticket_' + tmp;
    $(tid).fadeIn(150);
  });

  $(document).on('click', '.btn-tit-close', function() {
    tmp = $(this).attr('id');
    // btn_titclose_743001
    tmp = tmp.substring(13, tmp.length);
    tid = '#cd_ticket_' + tmp;
    $(tid).fadeOut(150);
  });  
  // }

  // Delete Device {
  $(document).on('click', '.btn-sc-device', function() {
    tmp = $(this).attr('id');
    // btn_sct_
    tmp = tmp.substring(8, tmp.length);
    tid = '#cd_device_' + tmp;
    $(tid).fadeIn(150);
  });

  $(document).on('click', '.btn-tdc-close', function() {
    tmp = $(this).attr('id');
    // btn_tdc_close_1
    tmp = tmp.substring(14, tmp.length);
    tid = '#cd_device_' + tmp;
    $(tid).fadeOut(150);
  });
  // }

  // Delete Customer {
  $(document).on('click', '.btn-scc', function() {
    tmp = $(this).attr('id');
    // btn_scc_
    tmp = tmp.substring(8, tmp.length);
    tid = '#cd_customer_' + tmp;
    $(tid).fadeIn(150);
  });

  $(document).on('click', '.btn-tcc-close', function() {
    tmp = $(this).attr('id');
    // btn_tdc_close_1
    tmp = tmp.substring(14, tmp.length);
    tid = '#cd_customer_' + tmp;
    $(tid).fadeOut(150);
  });
  // }

  // Delete Account {
  $(document).on('click', '.btn-sca', function() {
    tmp = $(this).attr('id');
    // btn_scc_
    tmp = tmp.substring(8, tmp.length);
    tid = '#cd_account_' + tmp;
    $(tid).fadeIn(150);
  });

  $(document).on('click', '.btn-tca-close', function() {
    tmp = $(this).attr('id');
    // btn_tdc_close_1
    tmp = tmp.substring(14, tmp.length);
    tid = '#cd_account_' + tmp;
    $(tid).fadeOut(150);
  });

  $(document).on('click', '.btn-tdclosepa', function() {
    tmp = $(this).attr('id');
    // btn_tdclosepa_
    tmp = tmp.substring(14, tmp.length);
    tid = '#servers_' + tmp;
    $(tid).fadeOut(150);
  });

  // }

  // Delete Pending Customer {
  $(document).on('click', '.btn-scp', function() {
    tmp = $(this).attr('id');
    // btn_scc_
    tmp = tmp.substring(8, tmp.length);
    tid = '#cd_pcustomer_' + tmp;
    $(tid).fadeIn(150);
  });

  $(document).on('click', '.btn-tcpclose', function() {
    tmp = $(this).attr('id');
    // btn_tcpclose_
    tmp = tmp.substring(13, tmp.length);
    tid = '#cd_pcustomer_' + tmp;
    $(tid).fadeOut(150);
  });

  $(document).on('click', '.btn-tpcclose', function() {
    tmp = $(this).attr('id');
    // btn_tcpclose_
    tmp = tmp.substring(14, tmp.length);
    tid = '#trpcus_' + tmp;
    $(tid).fadeOut(150);
  });
  // }

  // Delete Suspended Customer {
  $(document).on('click', '.btn-closescu', function() {
    tmp = $(this).attr('id');
    // btn_scu_
    tmp = tmp.substring(8, tmp.length);
    tid = '#cd_scustomer_' + tmp;
    $(tid).fadeIn(150);
  });

  $(document).on('click', '.btn-scu-close', function() {
    tmp = $(this).attr('id');
    // btn_scu_close_
    tmp = tmp.substring(14, tmp.length);
    tid = '#cd_scustomer_' + tmp;
    $(tid).fadeOut(150);
  });

  $(document).on('click', '.btn-tdclosesc', function(e) { 
    tmp = $(this).attr('id');
    // btn_tdclosesc_
    tmp = tmp.substring(14, tmp.length);
    tid = '#trscus_' + tmp;
    $(tid).fadeOut(300);
  });
  // }

  $(document).on('click', '#clabel_uid_verified', function(e) { 
    $('#div_cadmin').fadeIn(150);
    return false;
  });

  $(document).on('click', '#cbtn_uid_verified', function(e) { 
    $('#cform_uid_verified').submit();
    // return false;
  }); 

  $(document).on('click', '#clabel_uid_account', function(e) { 
    if ( confirm_same('#new_pwd', '#account_hs_pwd') ) {
      $('#div_caccount').fadeIn(150);  
    }
    
    return false;
  });

  $(document).on('click', '#clabel_uid_customer', function(e) { 
    $('#div_ccustomer').fadeIn(150);
    return false;
  });

  $(document).on('click', '#clabel_uid_sadmin', function(e) { 
    $('#div_sadmin').fadeIn(150);
    return false;
  }); 

  // top nav bar working 
  $(document).on('click', '#span_top_admin', function(e) { 
    window.location.href = "/accounts";
  }); 

  $(document).on('click', '#span_top_device', function(e) { 
    window.location.href = "/devices/configure";
  }); 

  $(document).on('click', '#span_top_ticket', function(e) { 
    window.location.href = "/tickets";
  }); 

  $(document).on('click', '#span_top_customer', function(e) { 
    window.location.href = "/pcustomers";
  }); 

  // $('.i_copy').zclip({
  //   path:'/ZeroClipboard.swf',
  //   copy: function() {
  //     return $.trim($(this).parent().text());
  //   }
  // });

  $(document).on('click', '.label_rmlog', function(e) { 
    var tmp = $(this).attr('id');

    tmp = tmp.substring(12, tmp.length);
    did = '#ddnote_' + tmp;
    $(did).css('display', 'none');

    fid = '#form_rmlog_' + tmp;
    // $.post('/devices/delete_log',
    //   {
    //     'dnote_id': tmp
    //   });
  });
  
  // make sort tablee
  $(document).on('click', '#table_devices th', function(e) { 
    var tmp = $(this).text()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim(tmp)
        , direction = "";

    if ( tmp != "  " && tmp != "Actions" && window.location.pathname.indexOf('dashboard') < 1 ) {
      if (s_end == "▽") {
        s_end = "&nbsp;&#9651";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        direction = "asc";
        $(this).html(tmp);

      } else if (s_end == "△") {
        s_end = "&nbsp;&#9661";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        
        direction = "desc";
        $(this).html(tmp);
      } else {
        $(this).html($(this).text()+"&nbsp;&#9651");
        direction = "asc";
      }

      $.get('/devices.js',
      {
        'sort_item' : sort_item,
        'direction' : direction,
        'device_rows' : $('#select_device_rows .text').text()
      });
    }

    
  });

  $(document).on('click', '#table_configured th', function(e) { 
    var tmp = $(this).text()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim(tmp)
        , direction = "";

    if ( tmp != "" && tmp != "Actions") {
      if (s_end == "▽") {
        s_end = "&nbsp;&#9651";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        direction = "asc";
        $(this).html(tmp);

      } else if (s_end == "△") {
        s_end = "&nbsp;&#9661";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        
        direction = "desc";
        $(this).html(tmp);
      } else {
        $(this).html($(this).text()+"&nbsp;&#9651");
        direction = "asc";
      }
    }

    $.get('/devices/configure.js',
    {
      'sort_item' : sort_item,
      'direction' : direction,
      'configure_rows' : $('#select_configure_rows .text').text()
    });
  });

  $(document).on('click', '#table_scustomer th', function(e) { 
    var tmp = $(this).text()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim(tmp)
        , direction = "";

    if ( tmp.indexOf("ID") >= 0 || tmp.indexOf("Username") >= 0 ) {
      if (s_end == "▽") {
        s_end = "&nbsp;&#9651";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        direction = "asc";
        $(this).html(tmp);

      } else if (s_end == "△") {
        s_end = "&nbsp;&#9661";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        
        direction = "desc";
        $(this).html(tmp);
      } else {
        $(this).html($(this).text()+"&nbsp;&#9651");
        direction = "asc";
      }
    }

    $.get('/scustomers.js',
    {
      'sort_item' : sort_item,
      'direction' : direction,
      'scustomer_rows' : $('#select_scustomer_rows .text').text()
    });
  });

  $(document).on('click', '#table_pcustomer th', function(e) { 
    var tmp = $(this).text()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim(tmp)
        , direction = "";

    if ( tmp.indexOf("ID") >= 0 || tmp.indexOf("Username") >= 0 ) {
      if (s_end == "▽") {
        s_end = "&nbsp;&#9651";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        direction = "asc";
        $(this).html(tmp);

      } else if (s_end == "△") {
        s_end = "&nbsp;&#9661";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        
        direction = "desc";
        $(this).html(tmp);
      } else {
        $(this).html($(this).text()+"&nbsp;&#9651");
        direction = "asc";
      }
    }

    $.get('/pcustomers.js',
    {
      'sort_item' : sort_item,
      'direction' : direction,
      'pcustomer_rows' : $('#select_pcustomer_rows .text').text()
    });
  });

  $(document).on('click', '#table_customer th', function(e) { 
    var tmp = $(this).text()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim(tmp)
        , direction = "";

    if ( tmp.indexOf("ID") >= 0 || tmp.indexOf("Username") >= 0  && window.location.pathname.indexOf('dashboard') < 1 ) {
      if (s_end == "▽") {
        s_end = "&nbsp;&#9651";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        direction = "asc";
        $(this).html(tmp);

      } else if (s_end == "△") {
        s_end = "&nbsp;&#9661";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        
        direction = "desc";
        $(this).html(tmp);
      } else {
        $(this).html($(this).text()+"&nbsp;&#9651");
        direction = "asc";
      }

      $.get('/customers.js',
      {
        'sort_item' : sort_item,
        'direction' : direction,
        'customer_rows' : $('#select_customer_rows .text').text()
      });
    }

  });
  
  $(document).on('click', '#table_sadmin th', function(e) { 
    var tmp = $(this).text()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim(tmp)
        , direction = "";

    if ( tmp.indexOf("ID") >= 0 || tmp.indexOf("Username") >= 0 ) {
      if (s_end == "▽") {
        s_end = "&nbsp;&#9651";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        direction = "asc";
        $(this).html(tmp);

      } else if (s_end == "△") {
        s_end = "&nbsp;&#9661";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        
        direction = "desc";
        $(this).html(tmp);
      } else {
        $(this).html($(this).text()+"&nbsp;&#9651");
        direction = "asc";
      }
    }

    $.get('/sadmins.js',
    {
      'sort_item' : sort_item,
      'direction' : direction,
      'sadmin_rows' : $('#select_sadmin_rows .text').text()
    });
  });

  $(document).on('click', '#table_account th', function(e) { 
    var tmp = $(this).text()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim(tmp)
        , direction = "";

    if ( tmp.indexOf("ID") >= 0 || tmp.indexOf("Username") >= 0 ) {
      if (s_end == "▽") {
        s_end = "&nbsp;&#9651";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        direction = "asc";
        $(this).html(tmp);

      } else if (s_end == "△") {
        s_end = "&nbsp;&#9661";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        
        direction = "desc";
        $(this).html(tmp);
      } else {
        $(this).html($(this).text()+"&nbsp;&#9651");
        direction = "asc";
      }
    }

    $.get('/accounts.js',
    {
      'sort_item' : sort_item,
      'direction' : direction,
      'account_rows' : $('#select_account_rows .text').text()
    });
  });

  $(document).on('click', '#table_verified th', function(e) { 
    var tmp = $(this).text()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim(tmp)
        , direction = "";

    if ( tmp.indexOf("ID") >= 0 || tmp.indexOf("Username") >= 0  && window.location.pathname.indexOf('dashboard') < 1 ) {
      if (s_end == "▽") {
        s_end = "&nbsp;&#9651";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        direction = "asc";
        $(this).html(tmp);

      } else if (s_end == "△") {
        s_end = "&nbsp;&#9661";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
         
        direction = "desc";
        $(this).html(tmp);
      } else {
        $(this).html($(this).text()+"&nbsp;&#9651");
        direction = "asc";
      }

      $.get('/verifieds.js',
      {
        'sort_item' : sort_item,
        'direction' : direction,
        'verified_rows' : $('#select_verified_rows .text').text()
      });
    }
  });

  $(document).on('click', '#table_ticket th', function(e) { 
    var tmp = $(this).text()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim(tmp)
        , direction = "";

    if ( tmp != "" && tmp != "Action" ) {
      if (s_end == "▽") {
        s_end = "&nbsp;&#9651";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        direction = "asc";
        $(this).html(tmp);

      } else if (s_end == "△") {
        s_end = "&nbsp;&#9661";
        tmp = $(this).text();
        tmp = tmp.substring(0,tmp.length-1);

        sort_item = $.trim(tmp);
        tmp = $.trim(tmp) + s_end;
        
        direction = "desc";
        $(this).html(tmp);
      } else {
        $(this).html($(this).text()+"&nbsp;&#9651");
        direction = "asc";
      }
    }

    $.get('/tickets.js',
    {
      'sort_item' : sort_item,
      'direction' : direction,
      'ticket_rows' : $('#select_ticket_rows .text').text()
    });
  });

  $(document).on('click', '#visiting_list th', function(e) { 
    var tmp = $(this).html()
        , s_end = tmp.substring(tmp.length-1, tmp.length)
        , sort_item = $.trim($(this).text())
        , direction = "";


    if ( tmp.indexOf('Location') == -1 && tmp != "" ) {
      if (s_end == "▽") {
        s_end = "&#9651";
        tmp = $(this).html();
        tmp = tmp.substring(0,tmp.length-1);

        tmp = tmp + s_end;
        direction = "asc";
        $(this).html(tmp);

        tmp = $.trim($(this).text());
        tmp = tmp.substring(0,tmp.length-2);
        sort_item = $.trim(tmp);
      } else if (s_end == "△") {
        s_end = "&#9661";
        tmp = $(this).html();
        tmp = tmp.substring(0,tmp.length-1);

        tmp = tmp + s_end;
        direction = "desc";
        $(this).html(tmp);

        tmp = $.trim($(this).text());
        tmp = tmp.substring(0,tmp.length-2);
        sort_item = $.trim(tmp);
      } else {
        $(this).html($(this).html()+"&#9651");
        direction = "asc";
      }
    }

    $.get('/dashboard.js',
    {
      'sort_item' : sort_item,
      'direction' : direction
    });
  });

  $(document).on('click', '#visiting_list tr td', function(e) { 
    tmp = $(this).parent().find('td').eq(0).attr('data-id');

    tid = '#form_show_userinfo_' + tmp;
    tmp2 = $(this).attr('class');

    if ( tmp != 1 && tmp2 == 'clickable' ) {
      // show_loading();
      $(tid).submit();
    }
    
    // $.post($(this).find('td').eq(0).attr('data-id'));
    // $.post('/dashboard/show_userinfo',
    //   {
    //     'id' : $(this).find('td').eq(0).attr('data-id')
    //   });
  });

  $(document).on('click', '#userinfo tr td', function(e) { 
    tmp = $(this).parent().find('td').eq(0).attr('data');

    tid = '#form_userinfo_' + tmp;

    if ( tid != '' && tmp != 1 ) {
      // show_loading();
      $(tid).submit();
    }
    
    // $.post($(this).find('td').eq(0).attr('data-id'));
    // $.post('/dashboard/show_userinfo',
    //   {
    //     'id' : $(this).find('td').eq(0).attr('data-id')
    //   });
  });

  $(document).on('click', '#send_qmail', function(e) {
    if (isValidEmailAddress($('#quick_mail_emailto').val())) {
      $('#qmail_notice').html('<i class="fa fa-fw fa-check-circle"></i>&nbsp;Emergency mail was sent successfully');
      
      return true;
    } else {
      $('#quick_mail_emailto').focus();
      $('#qmail_notice').html('<i class="fa fa-fw fa-exclamation-circle"></i>&nbsp;Invalid Email Address');

      return false;
    }
  });

  $(document).on('input', '#quick_mail_emailto', function(e) {
    $('#qmail_notice').html('');
  });

  $(document).on('input', '#label_sgo i', function(e) {
    $('#form_global_search').submit();
  });

  $(document).on('click', '#span_expand', function(e) {
    $('#res_menu.menu').css('display', 'block');
    $('#res_menu2').css('overflow', 'visible');
  });

  $(document).on('click', '.a_gouserinfo', function(e) {
    var tmp = $(this).attr('id');
    tmp = tmp.substring(13 , tmp.length)
    
    $('#gokey').val(tmp);
    show_loading();
    $('#form_gouserinfo').submit();
    return false;
  });

  $(document).on('blur', '#device_public_ip', function(e) {
    // tmp = $(this).val();
    // tmp = tmp.split('.');

    // tmp = trimLeadZero(tmp[0]) + '.' + trimLeadZero(tmp[1]) + '.' + trimLeadZero(tmp[2]) + '.' + trimLeadZero(tmp[3])
    // $('#device_public_ip').val(tmp);
  });

  $(document).on('blur', '#device_private_ip', function(e) {
    // tmp = $(this).val();
    // tmp = tmp.split('.');

    // tmp = trimLeadZero(tmp[0]) + '.' + trimLeadZero(tmp[1]) + '.' + trimLeadZero(tmp[2]) + '.' + trimLeadZero(tmp[3])
    // $('#device_private_ip').val(tmp);
  });

  $(document).on('keyup', '#device_public_ip', function(e) {
    // this.value = this.value.replace(/[^0-9\.]/g,'');
  });

  $(document).on('keyup', '#device_private_ip', function(e) {
    // this.value = this.value.replace(/[^0-9\.]/g,'');
  });
  
  hide_loading();
});

$('#res_menu2').dropdown();
$('#res_menu2').dropdown({on: 'hover'});