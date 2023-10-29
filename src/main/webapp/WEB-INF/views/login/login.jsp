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

// 영문 숫자 특수기호 조합 8자리 이상
const passRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;

// 문자와 숫자, 특수문자로만 구성(?<!@ 사용 불가), 길이는 6 ~ 12 사이
const emailRegExp = /^[a-zA-Z0-9._%+-]{6,12}(?<!@)$/;

// 2 ~ 16자 사이 영어, 숫자, 한글 허용 / 특수문자, 공백 허용 안함.
const nicknameRegExp = /^(?=.*[a-z0-9가-힣])(?!.*[\s!@#$%^&*()_+|<>?:"{},./;'[\]\\=-]).{2,16}$/; 

//아이디에 한글 안들어가게 하기위한 한글 정규식
const koreanRegExp = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/; 

//내가 가입창에 입력한 값
let idBox;
let nickBox;
let passBox;
let emailBox;

window.onload=function() {
	document.getElementById('sbtn').onclick = function() {
				
		// 아이디
		idBox = document.getElementById('signid'); // idBox에 입력된 id값을 넣어줌.
		
		if(idBox.value.trim() == '') {
			alert('아이디를 입력해주세요.');
			return false;
		} else if(!idRegExp.test(idBox.value)) { // idBox에 있는값이 정규식과 맞지 않으면 alert문구 띄우기
			alert('아이디를 영(소)문자 / 영(소)문자와 숫자로 6 ~ 12자 사이로 작성해주세요.');
			return false;
		}
		
		// 닉네임
		nickBox = document.getElementById('signnick'); // idBox에 입력된 id값을 넣어줌.
		
		if(nickBox.value.trim() == '') {
			alert('닉네임을 입력해주세요.');
			return false;
		} else if(!nicknameRegExp.test(nickBox.value)) { // idBox에 있는값이 정규식과 맞지 않으면 alert문구 띄우기
			alert('닉네임을 2 ~ 16자 사이 영어, 숫자, 한글로 입력해주세요.');
			return false;
		}
		
		// 비밀번호
		passBox = document.getElementById('signpw');
		
		if(passBox.value.trim() == '') {
			alert('비밀번호를 입력해주세요.');
			return false;
		} else if(!passRegExp.test(passBox.value)) {
			alert('비밀번호를 영문 숫자 특수기호 조합 8자리 이상 입력해주세요.');
			return false;
		}
		
		// 이메일
		emailBox = document.getElementById('signemail');
		
		if(emailBox.value.trim() == '') {
			alert('이메일을 입력해주세요.');
			return false;
		} else if(!emailRegExp.test(emailBox.value)) {
			alert('이메일 형식을 확인해주세요.');
			return false;
		} else if ($('#signemail_result').text() === '중복된 이메일') {
	            alert('이메일을 확인해주세요');
	            return false;
	    }
		
		document.sfrm.submit();
				
	}
}


$(document).ready(function() {
	
	// 아이디 비동기 처리 및 안내문구
    $('#signid').keyup(function() {
        let signid = $(this).val();
    
        if (signid != '') {
            if (koreanRegExp.test(signid)) {
                $('#signid_result').text('영문/숫자로 입력해주세요').css('color', 'orange');
            } else if (!idRegExp.test(signid)) {
                $('#signid_result').text('영(소)문자 / 영(소)문자와 숫자로 6 ~ 12자 사이로 작성해주세요').css('color', 'orange');
            } else {
                $.ajax({
                    type:'get',
                    url:'/id_check',
                    async: true,
                    data: {signid: signid},
                    success: function(result) { 
                        if (result == 0) {  
                            $('#signid_result').text('사용 가능한 아이디').css('color', 'green');
                        } else if (result == 1) {
                            $('#signid_result').text('중복된 아이디').css('color', 'orange');
                        }
                    },
                    error: function(e) {
                        alert('[에러] : ' + e.status);
                    }
                });
            }
        } else {
            $('#signid_result').text('아이디를 입력해주세요 !').css('color','orange');
        }
    });
	
	
	// 닉네임 비동기 처리 및 안내문구
    $('#signnick').keyup(function() {
        let signnick = $(this).val();
    
        if (signnick != '') {
            if (!nicknameRegExp.test(signnick)) {
                $('#signnick_result').text('2 ~ 16자 사이 영어, 숫자, 한글로 입력해주세요.').css('color', 'orange');
            } else {
                $.ajax({
                    type:'get',
                    url:'/nickname_check',
                    async: true,
                    data: { signnick: signnick },
                    success: function(result) { 
                        if (result == 0) {  
                            $('#signnick_result').text('사용 가능한 닉네임').css('color', 'green');
                        } else if (result == 1) {
                            $('#signnick_result').text('중복된 닉네임').css('color', 'orange');
                        }
                    },
                    error: function(e) {
                        alert('[에러] : ' + e.status);
                    }
                });
            }
        } else {
            $('#signnick_result').text('닉네임을 입력해주세요 !').css('color','orange');
        }
    });
    
	// 비밀번호 안내문구
    $('#signpw').keyup(function() {
    	let password = $(this).val();

    	if (password != '') {
            if (!passRegExp.test(password)) {
                $('#signpw_result').text('영문 숫자 특수기호 조합 8자리 이상 입력해주세요').css('color', 'orange');
            } else if (passRegExp.test(password)) {
            	$('#signpw_result').text('사용 가능한 비밀번호').css('color', 'green');
            } 
    	} else {
        	$('#signpw_result').text('비밀번호를 입력해주세요 !').css('color','orange');
        }
    })

    
    // 이메일 도메인 선택이 변경될 때 실행될 이벤트 핸들러를 추가합니다.
    $('#signemail2').change(function() {
        let selectedDomain = $(this).val(); // 선택된 도메인 값을 가져옵니다.
        $('#signemail1').trigger('keyup'); // 이메일 주소 입력란 변경 이벤트를 트리거합니다.
    });

    // 이메일 주소 입력란 값 변경이 감지될 때 실행될 이벤트 핸들러를 추가합니다.
    $('#signemail1').keyup(function() {
        let femail = $(this).val();
        let semail = $('#signemail2').val();
        let selectedDomain = $('#signemail2').val(); // 선택된 도메인 값을 가져옵니다.
        let email = femail + "@" + selectedDomain;

        if (femail != '' && selectedDomain != null) {
            if (!emailRegExp.test(femail)) {
                $('#signemail_result').text('이메일 형식을 확인해주세요.').css('color', 'orange');
            } else {
                $.ajax({
                    type: 'get',
                    url: '/email_check',
                    async: true,
                    data: { femail: femail,
                    		semail: semail},
                    success: function(result) { 
                        if (result !== email) {
                            // 문자열이 같음
                            $('#signemail_result').text('사용 가능한 이메일').css('color', 'green');
                        } else if (result === email) {
                            // 문자열이 다름
                            $('#signemail_result').text('중복된 이메일').css('color', 'orange');
                        }
                    },
                    error: function(e) {
                        alert('[에러] : ' + e.status);
                    }
                });
            }
        } else {
            $('#signemail_result').text('이메일을 입력해주세요 !').css('color','orange');
        }
    });
    
    $('#sbtn').click(function() { 
		if($('#signid_result').text() != '사용 가능한 아이디' || $('#signemail_result').text() != '사용 가능한 이메일' || $('#signnick_result').text() != '사용 가능한 닉네임') {
			alert('아이디, 이메일, 닉네임 중복확인을 확인하세요.');
			return false;
		}
	})  
});



</script>
<!-- 회원가입 script 끝 -->

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
							<span>Log In </span><span>Sign Up</span>
						</h6>
						<input class="checkbox" type="checkbox" id="reg-log" name="reg-log" /> 
						<label for="reg-log"></label>
						<div class="card-3d-wrap mx-auto">
							<div class="card-3d-wrapper">
								<!-- 로그인 card -->
								<div class="card-front">
									<form action="/login_ok.do" method="post" name="lfrm">
										<div class="center-wrap">
											<div class="section text-center" style="margin-top:100px;">
												<h4 class="mb-4 pb-3">Log In</h4>
												<div class="form-group">
													<input type="text" name="loginid" class="form-style" placeholder="Id" id="loginid" autocomplete="off">
													<i class="input-icon uil uil-user"></i>
													<span>&nbsp;</span>
												</div>
												<div class="form-group mt-2">
													<input type="password" name="loginpw" class="form-style" placeholder="Password" id="loginpw" autocomplete="off">
													<i class="input-icon uil uil-lock-alt"></i>
												</div>
												<button type="submit" id="lbtn" class="btn mt-4">submit</button>
												<p class="mb-0 mt-4 text-center">
													<a href="/findLogin.do" class="link">Forgot your password?</a>
												</p>
												<br>
												<a href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=aa90530c73e117df22ccaa129bd66135&redirect_uri=http://localhost:8080/kakao/callback">
													<img src="assets/images/kakao_login2.png">
												</a>												
											</div>
										</div>
									</form>
								</div>		
								<!-- 회원가입 card -->
								<div class="card-back">
									<form action="/signup.do" method="post" name="sfrm">					
										<div class="center-wrap">
											<div class="section text-center" style="margin-top:100px;">										
												<h4 class="mb-4 pb-3">Sign Up</h4>
												<div class="form-group">
													<input type="text" name="signid" class="form-style" placeholder="Id" id="signid" autocomplete="off"> 
													<i class="input-icon uil uil-user"></i>
													<span id="signid_result">&nbsp;</span>
												</div>
												<div class="form-group mt-2">
													<input type="text" name="signnick" class="form-style" placeholder="Nickname" id="signnick" autocomplete="off"> 
													<i class="input-icon uil uil-user"></i>
													<span id="signnick_result">&nbsp;</span>
												</div>
												<div class="form-group mt-2">
													<input type="password" name="signpw" class="form-style" placeholder="Password" id="signpw" autocomplete="off">
													<i class="input-icon uil uil-lock-alt"></i>
													<span id="signpw_result">&nbsp;</span>
												</div>																															
												<div class="form-group mt-2" style="text-align: center;">
												    <input style="width: 46.85%;" type="text" name="signemail1" class="form-style" placeholder="Email" id="signemail1" autocomplete="off">
												    <i class="input-icon uil uil-at" style="display: inline-block; vertical-align: middle;"></i>
												    <span style="display: inline-block; vertical-align: middle;">@</span>
												    <select style="width: 46.85%; text-align: center;" name="signemail2" class="form-style" id="signemail2">
												        <option selected disabled>이메일 선택</option>
												        <option value="naver.com">naver.com</option>
												        <option value="gmail.com">gmail.com</option>
												        <option value="daum.net">daum.net</option>
												        <!-- 여기에 더 많은 옵션을 추가할 수 있습니다. -->
												    </select>
												    <span id="signemail_result">&nbsp;</span>
												</div>
												<button type="submit" id="sbtn" class="btn mt-4">submit</button>										
											</div>
										</div>
									</form>							
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