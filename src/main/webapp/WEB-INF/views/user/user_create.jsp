<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
    // 등록 처리
    $('#btnAddConfirm').on('click', function(e) {
        e.preventDefault();
        
        if ( !$.trim($('#form select[name=grade]').val()) ) {
            toastr.error('구분을 선택해주세요.');
            $('#form select[name=grade]').focus();
            return false;
        }

        if ( !$.trim($('#form select[name=departmentIdx]').val()) ) {
            toastr.error('부서를 선택해주세요.');
            $('#form select[name=departmentIdx]').focus();
            return false;
        }

        if ( !$.trim($('#form input[name=userId]').val()) ) {
            toastr.error('아이디를 입력해주세요.');
            $('#form input[name=userId]').focus();
            return false;
        }

        if ( !$.trim($('#form input[name=mobile]').val()) ) {
            toastr.error('전화번호를 입력해주세요.');
            $('#form input[name=mobile]').focus();
            return false;
        }
        
        if ( !$.trim($('#form input[name=password]').val()) ) {
            toastr.error('비밀번호를 입력해주세요.');
            $('#form input[name=password]').focus();
            result = false;
            return false;
        }

        if ( !$.trim($('#form input[name=passwordConfirm]').val()) ) {
            toastr.error('비밀번호 확인을 입력해주세요.');
            $('#form input[name=passwordConfirm]').focus();
            result = false;
            return false;
        }

        if ( $.trim($('#form input[name=password]').val()) != $.trim($('#form input[name=passwordConfirm]').val()) ) {
            toastr.error('비밀번호와 비밀번호 확인이 다릅니다.');
            $('#form input[name=password]').focus();
            result = false;
            return false;
        }
        
        let formData = new FormData($('#form')[0]);

        $.ajax({
            url: '<c:url value="/user/create"/>',
            type: 'POST',
            data: formData,
            processData : false,
            contentType : false,
            beforeSend: function() {
                $('#btnAddConfirm').addClass('hidden');
                $('#btnAddConfirmLoading').removeClass('hidden');
            },
            success: function (res) {
            	let data = res.data;
            	userIdx = data.userIdx;
                //f_userView(data);
                $('#userTable').DataTable().ajax.reload( function () {});
                toastr.success('등록되었습니다.');
            },
            error: function(request, status, error) {
            	toastr.error('code: ' + request.status + '<br>message: ' + request.responseText + '<br>error: ' + error);
            },
            complete:function(){
                $('#btnAddConfirm').removeClass('hidden');
                $('#btnAddConfirmLoading').addClass('hidden');
            }
        });
    });
    
    // 아이디 중복 검증
    $('#form input[name=userId]').on('keyup', function(e) {
    	e.preventDefault();
    	
    	// 사용자 ID를 trim 처리
    	$('#form input[name=userId]').val( $.trim($('#form input[name=userId]').val()) );
    	
		if ($('#form input[name=userId]').val().length > 4) {
			// 사용자 ID 검증
	    	$.ajax({
	            url: '<c:url value="/user/view"/>',
	            type: 'GET',
	            data: {
	            	'userId': $('#form input[name=userId]').val(),
	            },
	            success: function (res) {
	            	console.log(res)
	            	let data = res.data;
	            	if (data) {
	            		//toastr.error('아이디가 존재합니다.');
	            		$('#form .form-control-user-id').addClass('has-error').removeClass('has-success');
	            		$('#form .form-control-user-id .help-error').removeClass('hide');
	            		$('#form .form-control-user-id .help-success').addClass('hide');
	            		$('#btnAddConfirm').prop('disabled', true);
	            		$('#form input[name=userId]').focus();
	            	} else {
	            		$('#form .form-control-user-id').removeClass('has-error').addClass('has-success');
	            		$('#form .form-control-user-id .help-error').addClass('hide');
	            		$('#form .form-control-user-id .help-success').removeClass('hide');
	            		$('#btnAddConfirm').prop('disabled', false);
	            	}             
	            },
	            error: function(request, status, error) {
	            	let rtn = 'code: ' + request.status + '<br>error: ' + error;
	            	//rtn += '<br>message: ' + request.responseText;
	            	toastr.error(rtn);
	            },
	            complete:function(){
	                $('#btnAddConfirm').removeClass('hidden');
	                $('#btnAddConfirmLoading').addClass('hidden');
	            }
	        });
		}    	
    });
</script>
