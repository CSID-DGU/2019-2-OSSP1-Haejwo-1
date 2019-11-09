// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery-ui
//= require activestorage
//= require throttle
//= require_tree ./channels

function numberWithCommas(x) {
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

// 전화번호 바르게 고쳐주는 함수
function phoneNumberFix(target) {
  target.on('keydown', function(e){
  	let transNum = $(this).val().replace(/-/gi,'');
  	let k = e.keyCode;
  	if(transNum.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687 || k===32 || k===229 || (k>=45032 && k<=55203)) )){
  		e.preventDefault();
  	}
  }).on('blur', function(){
  	if($(this).val() === '') return;
  		let transNum = $(this).val().replace(/-/gi,'');

  		if(transNum !== null && transNum != ''){
  			if(transNum.length===11 || transNum.length===10) {
  				let regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
  				if(regExp_ctn.test(transNum)){
  					transNum = transNum.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");
  					$(this).val(transNum);
  				}else {
            app.dialog.alert("유효하지 않은 전화번호 입니다.");
  					$(this).val("");
  					$(this).focus();
  				}
  			}else{
          app.dialog.alert("유효하지 않은 전화번호 입니다.");
  				$(this).val("");
  				$(this).focus();
  			}
  		}
  });
}

function updateThumbnail(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#user-thumbnail').attr('src', e.target.result);
    };
    reader.readAsDataURL(input.files[0]);
    $('#image-update').trigger('click');
  }
}


function readURL(input) {
  if (input.files && input.files[0]) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#user-thumbnail').attr('src', e.target.result);
    };
    reader.readAsDataURL(input.files[0]);
  }
}

function shortNoti(msg) {
  const notificationFull = app.notification.create({
    icon: '<i class="icon far fa-bell"></i>',
    title: '알림',
    titleRightText: '<%= Time.current %>',
    subtitle: msg,
    text: '',
    closeTimeout: 1000,
  });
  notificationFull.open();
}

function longNoti(msg) {
  const notificationFull = app.notification.create({
    icon: '<i class="icon far fa-bell"></i>',
    title: '알림',
    subtitle: msg,
    text: '',
    closeTimeout: 2000,
  });
  notificationFull.open();
}
