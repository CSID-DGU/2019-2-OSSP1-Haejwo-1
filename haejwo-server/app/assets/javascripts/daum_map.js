$("#zipcode-btn").click(function(){
  new daum.Postcode({
    oncomplete: function(data) {
      $("#user_zipcode").val(data.zonecode);
      $("#user_address1").val(data.address);
    },
    onclose: function(state){
      if(state === 'FORCE_CLOSE'){
        //사용자가 브라우저 닫기 버튼을 통해 팝업창을 닫았을 경우, 실행될 코드를 작성하는 부분입니다.
      } else if(state === 'COMPLETE_CLOSE'){
          //사용자가 검색결과를 선택하여 팝업창이 닫혔을 경우, 실행될 코드를 작성하는 부분입니다.
          //oncomplete 콜백 함수가 실행 완료된 후에 실행됩니다.
      }
    }
  }).open();
})
