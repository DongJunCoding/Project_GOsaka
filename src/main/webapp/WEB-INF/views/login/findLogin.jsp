<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://unicons.iconscout.com/release/v2.1.9/css/unicons.css">

<link rel="stylesheet" href="assets/css/login/login.css">

<script type="text/javascript" src="assets/js/jquery-3.7.0.js"></script>

<!-- 회원가입 script -->
<script>

// 정규 표현식 객체, 문자와 숫자로만 구성, 길이는 6 ~ 12 사이
const idRegExp = /^[a-z0-9]{6,12}$/;

// 문자와 숫자, 특수문자로만 구성, 길이는 6 ~ 12 사이
const emailRegExp = /^[a-zA-Z0-9._%+-]{6,12}/;

//아이디에 한글 안들어가게 하기위한 한글 정규식
const koreanRegExp = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; 

//내가 가입창에 입력한 값
let idBox;
let emailBox;




$(document).ready(function() {
	
	// 아이디 비동기 처리 및 안내문구
    $('#findid').keyup(function() {
        let signid = $(this).val();
        $.ajax({
            type:'get',
            url:'/id_check',
            async: true,
            data: {signid: signid},
            success: function(result) { 
                if (result == 0) {  
                    $('#findid_result').text('등록되지 않은 아이디입니다.').css('color', 'orange');
                } else if (result == 1) {
                    $('#findid_result').text('등록된 아이디').css('color', 'green');
                }
            },
            error: function(e) {
                alert('[에러] : ' + e.status);
            }
        });
    });
	
	
 
    // 아이디찾기 이메일 / 이메일 도메인 선택이 변경될 때 실행될 이벤트 핸들러를 추가합니다.
    $('#id_findemail2').change(function() {
        let selectedDomain = $(this).val(); // 선택된 도메인 값을 가져옵니다.
        $('#id_findemail1').trigger('keyup'); // 이메일 주소 입력란 변경 이벤트를 트리거합니다.
    });

    // 이메일 주소 입력란 값 변경이 감지될 때 실행될 이벤트 핸들러를 추가합니다.
    $('#id_findemail1').keyup(function() {
        let femail = $(this).val();
        let semail = $('#id_findemail2').val();
        let email = femail + "@" + semail;   
       
            $.ajax({
                type: 'get',
                url: '/email_check',
                async: true,
                data: { femail: femail,
                		semail: semail},
                success: function(result) { 
                    if (result !== email) {
                        // 문자열이 다름
                        $('#id_findemail_result').text('등록되지 않은 이메일').css('color', 'orange');
                    } else if (result === email) {
                        // 문자열이 같음
                        $('#id_findemail_result').text('등록된 이메일').css('color', 'green');
                    }
                },
                error: function(e) {
                    alert('[에러] : ' + e.status);
                }
            });
   		});
   


    // 비밀번호 찾기 / 이메일 도메인 선택이 변경될 때 실행될 이벤트 핸들러를 추가합니다.
    $('#findemail2').change(function() {
        let selectedDomain = $(this).val(); // 선택된 도메인 값을 가져옵니다.
        $('#findemail1').trigger('keyup'); // 이메일 주소 입력란 변경 이벤트를 트리거합니다.
    });

    // 이메일 주소 입력란 값 변경이 감지될 때 실행될 이벤트 핸들러를 추가합니다.
    $('#findemail1').keyup(function() {
    	
    	let findId = $('#findid').val();
        let femail = $(this).val();
        let semail = $('#findemail2').val();
        let email = femail + "@" + semail;    
       
                $.ajax({
                    type: 'get',
                    url: '/correctInfo',
                    async: true,
                    data: { findId : findId },
                    success: function(result) { 
                        if (result !== email) {
                            // 문자열이 다름
                            $('#findemail_result').text('이메일이 일치하지 않습니다.').css('color', 'orange');
                        } else if (result === email) {
                            // 문자열이 같음
                            $('#findemail_result').text('이메일이 일치합니다.').css('color', 'green');
                        }
                    },
                    error: function(e) {
                        alert('[에러] : ' + e.status);
                    }
                });
    });
   
});



</script>
<!-- 회원가입 script 끝 -->


<!-- 로그인 script 끝 -->
<script>

$(document).ready(function() {
	  let response; // response 변수를 스코프 내에 정의합니다.

	    // 폼 제출 이벤트 핸들러
	    $("#rfrm").submit(function(e) {
	        e.preventDefault(); // 기본 제출 동작을 막습니다.

	        // 폼 데이터를 가져옵니다.
	        let formData = $(this).serialize();

	        // AJAX 요청을 보냅니다.
	        $.ajax({
	            type: "get",
	            url: "/findPw.do", // 폼의 action 속성 값과 동일한 URL을 사용합니다.
	            data: formData,
	            success: function(data) {
	                response = data; // response 값을 설정합니다.
	                checkCode(); // 코드 비교 함수를 호출합니다.
	            },
	        });
	    });

	    // 코드 입력란(keyup 이벤트)에서 텍스트가 변경될 때마다 비교
	    $("#code_number").on("keyup", function() {
	        checkCode(); // 코드 비교 함수를 호출합니다.
	    });

	    // 코드 비교 함수
	    function checkCode() {
	        let codeValue = $("#code_number").val();

	        if (response === codeValue) {
	            $('#code_result').text('인증번호 확인').css('color', 'green');
	        } else {
	            $('#code_result').text('인증번호 입력 / 확인해주세요!').css('color', 'red');
	        }
	    }
	    
	   

});


// 비밀번호 찾기 로직에 대한 alert창
window.onload = function() {
	
	<!-- 비밀번호 찾기 script / 빈칸, 오타 발생 시 경고창 -->
	 document.getElementById('fbtn2').onclick = function() {
		 if(document.rfrm.findid.value.trim() == '') {
			 alert('아이디를 입력해주세요');
		 } 
		 
		 if(document.rfrm.findemail1.value.trim() == '') {
			 alert('이메일을 입력해주세요');
		 }
		
		 if($('#findid_result').text() === '등록되지 않은 아이디입니다.')  {
			 alert('등록된 정보가 일치하지 않습니다.');
			 return false;
		 }
		 
		 if($('#findemail_result').text() === '이메일이 일치하지 않습니다.')  {
			 alert('등록된 정보가 일치하지 않습니다.');
			 return false;
		 }
		 
	 }
	
	// 인증번호 오류에 대한 alert창
	document.getElementById('codebtn').onclick = function() {
	    	
	    	let findidValue = document.getElementById('findid').value;
	    	
	    	document.getElementById('h_findid').value = findidValue;
	    	
	        if (document.rfrm.code_number.value.trim() == '') {
	            alert('인증번호를 입력해주세요');
	            return false;
	        }
	
	        if ($('#code_result').text() === '인증번호 입력 / 확인해주세요!') {
	            alert('인증번호를 확인해주세요');
	            return false;
	        }
	            
	        document.cfrm.submit();
	}
    
	// 아이디 찾기에 대한 alert창
    document.getElementById('lbtn').onclick = function() {

        if (document.lfrm.id_findemail1.value.trim() == '' || document.lfrm.id_findemail2.value.trim() == '') {
            alert('이메일을 입력해주세요.');
            return false;
        }

        if ($('#id_findemail_result').text() === '등록되지 않은 이메일') {
            alert('이메일을 확인해주세요');
            return false;
        }
            
        document.lfrm.submit();
    }
}


</script>

</head>
<body>
	<video class="bg-video" playsinline="playsinline" autoplay="autoplay" muted="muted" loop="loop"><source src="assets/mp4/login.mp4" type="video/mp4" /></video>
	<div class="section">
		<div class="subcontainer">
			<div class="row full-height justify-content-center">
				<div class="col-12 text-center align-self-center py-5">
					<div class="section pb-5 pt-5 pt-sm-2 text-center">
						<a class="navbar-brand mb-3" href="/GOsakas.do"> 
							<img src="assets/images/Gosaka_gold.png" class="logo" alt=""> <!--<img src="assets/images/footer-logo.png" class="logo logo-scrolled" alt="">-->
						</a>
						<h6 class="mb-0 pb-3" style="color:black;">
							<span>Find ID </span><span>Find PASSWORD</span>
						</h6>
						<input class="checkbox" type="checkbox" id="reg-log" name="reg-log" /> 
						<label for="reg-log"></label>
						<div class="card-3d-wrap mx-auto">
							<div class="card-3d-wrapper">
								<!-- 로그인 card -->
								<div class="card-front">
									<form action="/findId.do" method="post" name="lfrm" id="lfrm">
										<div class="center-wrap">
											<div class="section text-center" style="margin-top:100px;">
												<h4 class="mb-4 pb-3">Find ID</h4>
												<p>본인확인 이메일 주소를 입력해주세요.</p>
												<p>등록된 이메일로 아이디가 전송됩니다.</p>
												<div class="form-group mt-2" style="text-align: center;">
												    <input style="width: 46.85%;" type="text" name="id_findemail1" class="form-style" placeholder="Email" id="id_findemail1" autocomplete="off">
												    <i class="input-icon uil uil-at" style="display: inline-block; vertical-align: middle;"></i>
												    <span style="display: inline-block; vertical-align: middle;">@</span>
												    <select style="width: 46.85%; text-align: center;" name="id_findemail2" class="form-style" id="id_findemail2">
												        <option selected disabled>이메일 선택</option>
												        <option value="naver.com">naver.com</option>
												        <option value="gmail.com">gmail.com</option>
												        <option value="daum.net">daum.net</option>
												        <!-- 여기에 더 많은 옵션을 추가할 수 있습니다. -->
												    </select>
												    <span id="id_findemail_result">&nbsp;</span>
												</div>												
												<button type="submit" id="lbtn" class="btn mt-4">이메일 전송</button>
											</div>
										</div>
									</form>
								</div>		
								<!-- 회원가입 card -->
								<div class="card-back">
									<div class="center-wrap">
										<div class="section text-center" style="margin-top:100px;">										
											<form action="/findPw.do" method="post" name="rfrm" id="rfrm"  onsubmit="event.preventDefault();">					
												<h4 class="mb-4 pb-3">Find PASSWORD</h4>
												<p>본인확인 아이디 / 이메일 주소를 입력해주세요.</p>
												<p>등록된 이메일로 인증번호가 전송됩니다.</p>
												<div class="form-group">
													<input type="text" name="findid" class="form-style" placeholder="Id" id="findid" autocomplete="off"> 
													<i class="input-icon uil uil-user"></i>
													<span id="findid_result">&nbsp;</span>
												</div>																																								
												<div class="form-group mt-2" style="text-align: center;">
												    <input style="width: 46.85%;" type="text" name="findemail1" class="form-style" placeholder="Email" id="findemail1" autocomplete="off">
												    <i class="input-icon uil uil-at" style="display: inline-block; vertical-align: middle;"></i>												    
												    <span style="display: inline-block; vertical-align: middle;">@</span>
												    <select style="width: 46.85%; text-align: center;" name="findemail2" class="form-style" id="findemail2">
												        <option selected disabled>이메일 선택</option>
												        <option value="naver.com">naver.com</option>
												        <option value="gmail.com">gmail.com</option>
												        <option value="daum.net">daum.net</option>
												        <!-- 여기에 더 많은 옵션을 추가할 수 있습니다. -->
												    </select>												    
												    <span id="findemail_result">&nbsp;</span>												    
												</div>
												<div class="form-group mt-2">
													<input style="width:55%; float:left; text-align:left;" type="text" name="code_number" class="form-style" placeholder="인증번호 입력" id="code_number" autocomplete="off">
													<button style="width: 42%; float:right;" type="submit" id="fbtn2" class="btn">인증번호 받기</button>
													<div style="clear:both;" id="code_result">&nbsp;</div>
												</div>
											</form>
											<form action="/changePw.do" method="post" name="cfrm">		
											<input type="hidden" name="h_findid" id="h_findid" />								
												<button type="button" id="codebtn" class="btn mt-4">인증번호 확인</button>										
											</form>
										</div>
									</div>															
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>