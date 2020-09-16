<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<script>
// 수강 학생 목록
let lectureStudentTable = function(data) {
    $('#lectureStudentTable').DataTable().destroy();
    $('#lectureStudentTable').DataTable({
        language: lang_kor,
        paging: true,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        ajax: {
            url: '<c:url value="/lectureStudent/list"/>',
            type: 'GET',
            data: {
                classroomIdx: classroomIdx,
            }
        },
        rowId: 'classroomStudentIdx',
        columns: [
            { data: 'departmentName' },
            { data: 'studentName' },
            { data: 'studentId' },
            { data: 'studentPhone' },
            { data: 'studentEmail' },
            {
				render : function(data, type, row) {
					if (row['useYN'] == 'Y') {
						return '사용';
					} else {
						return '<span class="text-danger">사용안함</span>';
					}
				}
			},
            {
                render: function(data, type, row) {
                    let button = '<button type="button" class="btn btn-danger btn-delete-lecture-student" data-classroom-student-idx="' + row['classroomStudentIdx'] + '" data-toggle="modal" data-target="#deleteLectureStudentModal">삭제</button>';
                    return button;
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

    $('#lectureStudentTable tbody').on('click', 'button', function () {
        let classroomStudentIdx = $(this).data('classroom-student-idx');
        deleteLectureStudentIdx = classroomStudentIdx;
    });
   
}

</script>
