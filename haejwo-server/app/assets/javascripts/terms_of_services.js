var checked = false;
$('#agree_all').click(function(){
  if (!checked) {
    document.getElementById("agree_trems").checked = true;
    document.getElementById("agree_private").checked = true;
    document.getElementById("agree_shopping").checked = true;
    document.getElementById("user_accept_sms").checked = true;
    document.getElementById("user_accept_email").checked = true;
    $('#regis-new-button').attr('disabled', false);
    checked = true;
  }
  else {
    document.getElementById("agree_trems").checked = false;
    document.getElementById("agree_private").checked = false;
    document.getElementById("agree_shopping").checked = false;
    document.getElementById("user_accept_sms").checked = false;
    document.getElementById("user_accept_email").checked = false;
    $('#regis-new-button').attr('disabled', true);
    checked = false;
  }
});

$('#agree_trems').click(function(){
  checkIsAllowed();
});
$('#agree_private').click(function(){
  checkIsAllowed();
});
$('#agree_shopping').click(function(){
  checkIsAllowed();
});

function checkIsAllowed() {
  const isAllowed = (document.getElementById("agree_trems").checked) && (document.getElementById("agree_private").checked) && (document.getElementById("agree_shopping").checked);
  if (isAllowed) {
    $('#regis-new-button').attr('disabled', false);
  }
  else {
    $('#regis-new-button').attr('disabled', true);
  }
}
