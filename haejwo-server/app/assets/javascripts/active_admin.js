//= require active_admin/base
//= require activeadmin_addons/all
//= require tinymce
//= require imageviewer
//= require activeadmin_reorderable

TinyMCERails.configuration.default = {
  selector: "textarea.tinymce",
  height: 500,
  branding: false,
  toolbar: ["styleselect fontselect fontsizeselect | bold italic | undo redo media","link | uploadimage | codesample | alignleft aligncenter alignright | charmap"],
  plugins: "link,uploadimage,codesample,charmap,media",
  icons: "material"
};
TinyMCERails.initialize('default', {
  relative_urls : false,             /// 어드민 페이지에서 가끔 발생하는
  remove_script_host : false,        /// 상대 url을 해결해주는
  convert_urls : true,               /// 코드입니다
});

$(function () {
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });

  let viewer = ImageViewer();
  $('img').click(function () {
      let imgSrc = this.src
      viewer.show(imgSrc);
  });
});
