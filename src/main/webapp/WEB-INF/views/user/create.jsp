<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
    // 입력항목 검사
    function formCheck() {
        let result = true;

        if ( !$.trim($('#form select[name=collegeIdx]').val()) ) {
            toastr.error('대학/학부를 선택해주세요.');
            $('#form select[name=collegeIdx]').focus();
            result = false;
            return false;
        }

        if ( !$.trim($('#form select[name=departmentIdx]').val()) ) {
            toastr.error('학과/부서를 선택해주세요.');
            $('#form select[name=departmentIdx]').focus();
            result = false;
            return false;
        }

        if ( !$.trim($('#form input[name=userId]').val()) ) {
            toastr.error('아이디를 입력해주세요.');
            $('#form input[name=userId]').focus();
            result = false;
            return false;
        }

        if ( !$.trim($('#form input[name=userPhone]').val()) ) {
            toastr.error('전화번호를 입력해주세요.');
            $('#form input[name=userPhone]').focus();
            result = false;
            return false;
        }

        if ( !$.trim($('#form select[name=grade]').val()) ) {
            toastr.error('구분을 선택해주세요.');
            $('#form select[name=grade]').focus();
            result = false;
            return false;
        }

        return result;
    }

    // 비밀번호 검사
    function passwordCheck() {
        let result = true;

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

        return result;
    }

    // 등록폼
    $('#btnShowCreate').on('click', function() {
        sideWork = 'add';

        $('#form').each(function(){
            this.reset();
        });

        $('#formText').text('등록');
        $('#useDelete').addClass('hidden');
        $('#viewBox').addClass('hidden');
        $('#formBox').removeClass('hidden');
        $('.passwordTr').removeClass('hidden');
        $('#btnAddConfirm').removeClass('hidden');  // 등록버튼
        $('#btnEditConfirm').addClass('hidden');    // 수정버튼
    });

    // 등록 처리
    $('#btnAddConfirm').on('click', function(e) {
        e.preventDefault();

        if (!formCheck()) return false;
        if (!passwordCheck()) return false;

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
                if (res.data) {
                    userIdx = res.data.userIdx;
                    sideWork = 'view';
                    viewEditData(res.data);
                    $('#professorTable').DataTable().ajax.reload( function () {});
                    $('#studentTable').DataTable().ajax.reload( function () {});
                    $('#assistantTable').DataTable().ajax.reload( function () {});
                    toastr.success('등록되었습니다.');
                } else {
                    toastr.error(res.message);
                }
            },
            complete:function(){
                $('#btnAddConfirm').removeClass('hidden');
                $('#btnAddConfirmLoading').addClass('hidden');
            }
        });
    });

    // 취소
    $('#btnCancel').on('click', function() {
        if (sideWork == 'add') {
            $('#form').each(function(){
                this.reset();
            });
        } else {
            $('#useDelete').addClass('hidden');
            $('#viewBox').removeClass('hidden');
            $('#formBox').addClass('hidden');
        }
    });
</script>
