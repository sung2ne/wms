<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/contents/top.jsp" %>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>
            BLE출결
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> BLE출결</a></li>
            <li><a href="#">기준정보</a></li>
            <li class="active">BLE출결</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">

            <div class="col-md-12">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">BLE출결 목록</h3>
                    <div class="box-body">
                        <table class="table table-bordered table-hover" id="bleRequestTable">
                            <thead>
                            <tr>
                                <th>연도</th>
								<th>학기</th>
								<th>대학/학부</th>
								<th>부서/학과</th>
								<th>교과목</th>
								<th>교수</th>
								<th>UUID</th>
								<th>출석체크</th>
								<th>사용</th>
								<th>삭제</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
            
            <div class="col-md-12">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">출결 결과</h3>
                    <div class="box-body">
                        <table class="table table-bordered table-hover" id="attendTable">
                            <thead>
                            <tr>
	                            <th>부서/학과</th>
	                            <th>아이디</th>
	                            <th>이름</th>
	                            <th>연락처</th>
	                            <th>이메일</th>
	                            <th>출결관리</th>
								<th>사용</th>
								<th>삭제</th>
                            </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </section>
    <!-- /.content -->
</div>
<!-- /.content-wrapper -->

<%@include file="../layout/contents/footer.jsp" %>
<%@include file="../layout/contents/bottom.jsp" %>
<%@include file="../layout/contents/script.jsp" %>

<script>
    let	bleRequestIdx;
    let sideWork = 'add';

    // 목록
    let bleRequestTable = $('#bleRequestTable').DataTable({
        language: lang_kor,
        paging: true,
        pageLength: 20,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        ajax: {
            url: '<c:url value="/bleRequest/list"/>',
            type: 'GET',
            data: function ( d ) {
            }
        },
        rowId: 'bleRequestIdx',
        columns: [
        	{ data: 'year' },
			{ 
				render : function(data, type, row) {
					if (row['semester'] == '1') {
						return '1학기';
					} else if (row['semester'] == '2') {
						return '2학기';
					} else if (row['semester'] == '3') {
						return '여름학기';
					} else if (row['semester'] == '4') {
						return '겨울학기';
					}
				}
			},
			{ data : 'collegeName' },
			{ data : 'departmentName' },
			{ data : 'subjectName' },
			{ data : 'professorName' },
			{ data : 'uuid'},
			{
	            render: function(data, type, row) {
	                let button = '<button type="button" class="btn btn-primary" data-bleRequest-idx="' + row['bleRequestIdx'] + '" id="btn">출석체크</button>';
	                return button;
	            }
	        }, {
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
        createdRow: function ( row, data, dataIndex, cells ) {
            $(row).attr('data-bleRequest-idx', data.bleRequestIdx);
        },
    });
    
 	// 출결 목록
    $('#bleRequestTable tbody').on('click', 'button', function () {
        sideWork = 'view';
        bleRequestIdx = $(this).closest('tr').attr('id');

        $('#attendTable').DataTable().destroy();
        $('#attendTable').DataTable({
            language: lang_kor,
            paging: true,
            info: true,
            ordering: true,
            processing: true,
            autoWidth: false,
            ajax: {
                url: '<c:url value="/attend/list"/>',
                type: 'GET',
                data: {
                    bleRequestIdx: bleRequestIdx,
                }
            },
            rowId: 'attendIdx',
            columns: [
                { data: 'studentDepartmentName' },
                { data: 'studentId' },
                { data: 'studentName' },
                { data: 'studentPhone' },
                { data: 'studentEmail' },
                {
                    render: function(data, type, row) {
                        let button = '';

                        if (row['attendYNL'] == 'Y') {
                            button += '<button type="button" class="btn btn-primary btn-xs btn-attend">출석</button>';
                            button += '&nbsp;<button type="button" class="btn btn-secondary btn-xs btn-late" data-attend-idx="' + row['attendIdx'] + '" data-attend-ynl="L">지각</button>';
                            button += '&nbsp;<button type="button" class="btn btn-secondary btn-xs btn-absent" data-attend-idx="' + row['attendIdx'] + '" data-attend-ynl="N">결석</button>';
                        } else if (row['attendYNL'] == 'L') {
                            button += '<button type="button" class="btn btn-secondary btn-xs btn-attend" data-attend-idx="' + row['attendIdx'] + '" data-attend-ynl="Y">출석</button>';
                            button += '&nbsp;<button type="button" class="btn btn-warning btn-xs btn-late">지각</button>';
                            button += '&nbsp;<button type="button" class="btn btn-secondary btn-xs btn-absent" data-attend-idx="' + row['attendIdx'] + '" data-attend-ynl="N">결석</button>';
                        } else if (row['attendYNL'] == 'N') {
                            button += '<button type="button" class="btn btn-secondary btn-xs btn-attend" data-attend-idx="' + row['attendIdx'] + '" data-attend-ynl="Y">출석</button>';
                            button += '&nbsp;<button type="button" class="btn btn-secondary btn-xs btn-late" data-attend-idx="' + row['attendIdx'] + '" data-attend-ynl="L">지각</button>';
                            button += '&nbsp;<button type="button" class="btn btn-danger btn-xs btn-absent">결석</button>';
                        }

                        return button;
                    }
                }, {
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
</script>
<%@include file="update.jsp" %>
<%@include file="delete.jsp" %>
<%@include file="attendUpdate.jsp" %>
</body>
</html>
