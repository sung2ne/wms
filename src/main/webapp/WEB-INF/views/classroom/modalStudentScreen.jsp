<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
// 모달 학생 목록
$('#classroomTable tbody').on('click', 'button', function () {
    //let classroomIdx = $(this).data('classroom-idx');
    //let type = $(this).data('type');
    //let userName = $(this).data('name');
    //let userId = $(this).data('userid');
    
    $('#lectureStudentModal').modal("show");

    $('#lectureStudentModalTable').DataTable().destroy();
    $('#lectureStudentModalTable').DataTable({
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        ajax: {
            url: '<c:url value="/user/list"/>',
            type: 'GET',
            data: {
            		'grade':'S',
            }
        },
        rowId: 'userIdx',
        columns: [
            {
                render: function(data, type, row) {
                    return '<input type="checkbox" name="lectureStudentModalCheckbox" value="' + row['userIdx'] + '" data-userName="' + row['userName'] + '" data-userId="' + row['userId'] + '" />';
                }
            },
            { data: 'departmentName' },
            { data: 'userName' },
            { data: 'userId' },
            { data: 'userPhone' },
            { data: 'email' },
            {
				render : function(data, type, row) {
					if (row['useYN'] == 'Y') {
						return '사용';
					} else {
						return '<span class="text-danger">사용안함</span>';
					}
				}
			}, {
				render : function(data, type, row) {
					if (row['deleteYN'] == 'Y') {
						return '<span class="text-danger">삭제</span>';
					} else {
						return '삭제안함';
					}
				}
			},
        ],
        columnDefs: [
            {
                //'targets': [0],
                //'orderable': false,
                //'searchable': false,
            },
        ],
        order: [
            [ 0, 'asc' ],
            [ 1, 'asc' ],
            [ 2, 'asc' ],
        ],
    });
});

// 체크박스
$('input[name=lectureStudentModalAll]').on('click', function() {
    if (lectureStudentModalCheckboxAll) {
        $('input[name=lectureStudentModalCheckbox]').each(function() {
            $(this).attr('checked', false);
        });
        lectureStudentModalCheckboxAll = false;
    } else {
        $('input[name=lectureStudentModalCheckbox]').each(function() {
            $(this).attr('checked', true);
        });
        lectureStudentModalCheckboxAll = true;
    }
});
</script>
