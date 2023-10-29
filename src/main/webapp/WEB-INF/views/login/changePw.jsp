<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	String h_findid = request.getParameter("h_findid");
    %>
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



// 영문 숫자 특수기호 조합 8자리 이상
const passRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;

//내가 가입창에 입력한 값

let passBox;
let passCheckBox;

window.onload=function() {
	document.getElementById('cbtn').onclick = function() {
					
		// 비밀번호
		passBox = document.getElementById('newPw');
		
		if(passBox.value.trim() == '') {
			alert('비밀번호를 입력해주세요.');
			return false;
		} else if(!passRegExp.test(passBox.value)) {
			alert('비밀번호를 영문 숫자 특수기호 조합 8자리 이상 입력해주세요.');
			return false;
		}
		
		passCheckBox = document.getElementById('repeatPw');
		
		// 비밀번호 확인
		if(passCheckBox.value.trim() == '') {
			alert('비밀번호 확인을 입력해주세요.');
			return false;
		} else if(passBox.value.trim() != passCheckBox.value.trim()) {
			alert('비밀번호가 일치하지 않습니다.');
			return false;
		}

	}
}


$(document).ready(function() {
	
	// 비밀번호 안내문구
    $('#newPw').keyup(function() {
    	let password = $(this).val();

    	if (password != '') {
            if (!passRegExp.test(password)) {
                $('#newPw_result').text('영문 숫자 특수기호 조합 8자리 이상 입력해주세요').css('color', 'orange');
            } else if (passRegExp.test(password)) {
            	$('#newPw_result').text('사용 가능한 비밀번호').css('color', 'green');
            } 
    	} else {
        	$('#newPw_result').text('비밀번호를 입력해주세요 !').css('color','orange');
        }
    }) 
    
     // 비밀번호 확인 안내문구
    $('#repeatPw').keyup(function() {
    	let check_password = $(this).val();
    	let password = $('#newPw').val();
    	
    	if(check_password != '') {
    		if(check_password != password) {
        		$('#repeatPw_result').text('비밀번호가 맞지 않습니다.').css('color', 'orange');
        	} else {
        		$('#repeatPw_result').text('비밀번호 확인').css('color', 'green');
        	}
    	} else {
        	$('#repeatPw_result').text('비밀번호 확인을 입력해주세요 !').css('color','orange');
        }
    	 
    })
});



</script>
<!-- 회원가입 script 끝 -->

<!-- 로그인 script -->

<!-- 로그인 script 끝 -->

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
						<input class="checkbox" type="checkbox" id="reg-log" name="reg-log" /> 			
						<div class="card-3d-wrap mx-auto">
							<div class="card-3d-wrapper">
								<!-- 비밀번호 변경 card -->
								<div class="card-front">
									<form action="/changePw_ok.do" method="post" name="lfrm">
									<input type="hidden" name="h_findid" value="<%=h_findid %>" />
										<div class="center-wrap">
											<div class="section text-center" style="margin-top:100px;">
												<h4 class="mb-4 pb-3">Change PASSWORD</h4>
												<div class="form-group">
													<input type="password" name="newPw" class="form-style" placeholder="새로운 비밀번호" id="newPw" autocomplete="off">
													<i class="input-icon uil uil-lock-alt"></i>
													<span id="newPw_result">&nbsp;</span>
												</div>
												<div class="form-group mt-2">
													<input type="password" name="repeatPw" class="form-style" placeholder="비밀번호 확인" id="repeatPw" autocomplete="off">
													<i class="input-icon uil uil-lock-alt"></i>
													<span id="repeatPw_result">&nbsp;</span>
												</div>
												<button type="submit" id="cbtn" class="btn mt-4">비밀번호 변경</button>												
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