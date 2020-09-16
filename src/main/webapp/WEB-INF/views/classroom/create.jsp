<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
    // 입력항목 검사
    function formCheck() {
        let result = true;
        
        if ( !$.trim($('#form select[name=yearSemesterIdx]').val()) ) {
            toastr.error('연도/학기를 선택해주세요.');
            $('#form select[name=yearSemesterIdx]').focus();
            result = false;
            return false;
        }
        
        if ( !$.trim($('#form select[name=departmentIdx]').val()) ) {
            toastr.error('부서/학과를 선택해주세요.');
            $('#form select[name=departmentIdx]').focus();
            result = false;
            return false;
        }

        if ( !$.trim($('#form select[name=subjectIdx]').val()) ) {
            toastr.error('교과목을 선택해주세요.');
            $('#form select[name=subjectIdx]').focus();
            result = false;
            return false;
        }
        
        if ( !$.trim($('#form select[name=professorIdx]').val()) ) {
            toastr.error('교수를 선택해주세요.');
            $('#form select[name=professorIdx]').focus();
            result = false;
            return false;
        }
        
        if ( !$.trim($('#form input[name=classroom]').val()) ) {
            toastr.error('분반을 입력해주세요.');
            $('#form input[name=classroom]').focus();
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
        $('#btnAddConfirm').removeClass('hidden');  // 등록버튼
        $('#btnEditConfirm').addClass('hidden');    // 수정버튼
    });

    // 등록 처리
    $('#btnAddConfirm').on('click', function(e) {
        e.preventDefault();

        if (!formCheck()) return false;

        let formData = new FormData($('#form')[0]);

        $.ajax({
            url: '<c:url value="/classroom/create"/>',
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
                	classroomIdx = res.data.classroomIdx;
                    sideWork = 'view';
                    viewEditData(res.data);
                    $('#classroomTable').DataTable().ajax.reload( function () {});
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
