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
            수업 스케줄
        </h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> 전자출결</a></li>
            <li><a href="#">기준정보</a></li>
            <li class="active">수업 스케줄</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">

            <div class="col-md-8">
                <div class="box">
                    <div class="box-header">
                        <h3 class="box-title">수업 스케줄 목록</h3>
                        <div class="box-tools"><button type="button" class="btn btn-success" id="btnShowCreate">신규등록</button></div>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered table-hover" id="scheduleTable">
                            <thead>
                            <tr>
                            	<th>연도</th>
                                <th>학기</th>
                                <th>교과목</th>
                                <th>학과/부서</th>
                                <th>분반</th>
                                <th>주차</th>
                                <th>날짜</th>
                                <th>교시</th>
                                <th>시작 시간</th>
                                <th>종료 시간</th>
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

            <div class="col-md-4">

                <!-- 보기 -->
                <div class="box hidden" id="viewBox">
                    <div class="box-header">
                        <h3 class="box-title">수업 스케줄 정보</h3>
                    </div>
                    <div class="box-body">
                        <table class="table table-bordered table-hover">
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tr>
								<th>연도</th>
								<td><span id="year"></span></td>
							</tr>
                          	<tr>
								<th>학기</th>
								<td><span id="semester"></span></td>
							</tr>
							<tr>
								<th>교과목</th>
								<td><span id="subjectName"></span>
							</tr>
							<tr>
								<th>학과/부서</th>
								<td><span id="departmentName"></span></td>
							</tr>
							<tr>
								<th>분반</th>
								<td><span id="classroom"></span></td>
							</tr>
							<tr>
                                <th>주차</th>
                                <td><span id="week"></span></td>
                            </tr>
                            <tr>
                                <th>날짜</th>
                                <td><span id="scheduleDate"></span></td>
                            </tr>
                            <tr>
                                <th>교시</th>
                                <td><span id="classTime"></span></td>
                            </tr>
                            <tr>
                                <th>시작 시간</th>
                                <td><span id="startTime"></span>
                            </tr>
                            <tr>
                                <th>종료 시간</th>
                                <td><span id="endTime"></span>
                            </tr>
                        </table>
                        <table class="table table-bordered table-hover" style="margin-top: 10px;">
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tr>
                                <th>등록</th>
                                <td><span id="createUserName"></span>
                            </tr>
                            <tr>
                                <th>등록 일시</th>
                                <td><span id="createDateTime"></span>
                            </tr>
                        </table>
                        <table class="table table-bordered table-hover hidden" id="updateDateTimeTable" style="margin-top: 10px;">
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tr>
                                <th>수정</th>
                                <td><span id="updateUserName"></span>
                            </tr>
                            <tr>
                                <th>수정 일시</th>
                                <td><span id="updateDateTime"></span>
                            </tr>
                        </table>
                        <table class="table table-bordered table-hover hidden" id="deleteDateTimeTable" style="margin-top: 10px;">
                            <colgroup>
                                <col width="120">
                                <col>
                            </colgroup>
                            <tr>
                                <th>삭제</th>
                                <td><span id="deleteUserName"></span>
                            </tr>
                            <tr>
                                <th>삭제 일시</th>
                                <td><span id="deleteDateTime"></span>
                            </tr>
                        </table>
                    </div>
                    <div class="box-footer">
                        <button type="button" class="btn btn-warning" id="btnShowEdit">수정</button>
                        <div class="pull-right">
                            <button type="button" class="btn btn-danger" id="btnDelete" data-toggle="modal" data-target="#deleteModal">삭제</button>
                        </div>
                    </div>
                </div>
                <!--// 보기 -->

                <!-- 등록, 수정 -->
                <div class="box" id="formBox">
                    <div class="box-header">
                        <h3 class="box-title">시간 <span id="formText">등록</span></h3>
                    </div>
                    <div class="box-body">
                        <form id="form">
                            <table class="table table-bordered table-hover">
                                <colgroup>
                                    <col width="120">
                                    <col>
                                </colgroup>
                               	<tr>
									<th>연도/학기</th>
									<td><select class="form-control" name="yearSemesterIdx">
											<option value="">선택</option>
											<c:forEach var="yearSemesterList" items="${yearSemesterList}">
												<c:choose>
													<c:when test="${yearSemesterList.semester eq '1' }">
														<option value="${yearSemesterList.yearSemesterIdx}">${yearSemesterList.year}년 1학기</option>
													</c:when>
													<c:when test="${yearSemesterList.semester eq '2' }">
														<option value="${yearSemesterList.yearSemesterIdx}">${yearSemesterList.year}년 2학기</option>
													</c:when>
													<c:when test="${yearSemesterList.semester eq '3' }">
														<option value="${yearSemesterList.yearSemesterIdx}">${yearSemesterList.year}년 여름학기</option>
													</c:when>
													<c:when test="${yearSemesterList.semester eq '4' }">
														<option value="${yearSemesterList.yearSemesterIdx}">${yearSemesterList.year}년 겨울학기</option>
													</c:when>
												</c:choose>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<th>교과목</th>
									<td><select class="form-control" name="subjectIdx">
											<option value="">선택</option>
											<c:forEach var="subjectList" items="${subjectList}">
												<option value="${subjectList.subjectIdx}">${subjectList.subjectName}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<th>학과/부서</th>
									<td><select class="form-control" name="departmentIdx">
											<option value="">선택</option>
											<c:forEach var="departmentList" items="${departmentList}">
												<option value="${departmentList.departmentIdx}">${departmentList.departmentName}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<th>분반</th>
									<td><select class="form-control" name="classroomIdx">
											<option value="">선택</option>
											<c:forEach var="classroomList" items="${classroomList}">
												<option value="${classroomList.classroomIdx}">${classroomList.classroom}반</option>
											</c:forEach>
									</select></td>
								</tr>
                                <tr>
                                    <th>주차</th>
                                    <td><input type="text" class="form-control" name="week"></td>
                                </tr>
                                <tr>
                                    <th>날짜</th>
                                    <td><input type="text" class="form-control" name="scheduleDate"></td>
                                </tr>
                                <tr>
                                <th>교시</th>
									<td><select class="form-control" name="scheduletimeIdx">
											<option value="">선택</option>
											<c:forEach var="scheduletimeList" items="${scheduletimeList}">
												<option value="${scheduletimeList.scheduletimeIdx}">${scheduletimeList.classTime}교시</option>
											</c:forEach>
									</select></td>
								</tr>
                                <tr>
                                <th>시작 시간</th>
									<td><select class="form-control" name="startTime">
											<option value="">선택</option>
											<c:forEach var="scheduletimeList" items="${scheduletimeList}">
												<option value="${scheduletimeList.scheduletimeIdx}">${scheduletimeList.startTime}</option>
											</c:forEach>
									</select></td>
								</tr>
                                <tr>
                                <th>종료 시간</th>
									<td><select class="form-control" name="endTime">
											<option value="">선택</option>
											<c:forEach var="scheduletimeList" items="${scheduletimeList}">
												<option value="${scheduletimeList.scheduletimeIdx}">${scheduletimeList.endTime}</option>
											</c:forEach>
									</select></td>
								</tr>
                            </table>
                            <table class="table table-bordered table-hover hidden" id="useDelete" style="margin-top: 10px;">
                                <colgroup>
                                    <col width="120">
                                    <col>
                                </colgroup>
                                <tr>
                                    <th>사용</th>
                                    <td>
                                        <select class="form-control" name="useYN">
                                            <option value="Y">사용</option>
                                            <option value="N">사용안함</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>삭제</th>
                                    <td>
                                        <select class="form-control" name="deleteYN">
                                            <option value="Y">삭제</option>
                                            <option value="N">삭제안함</option>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                    <div class="box-footer">
                        <button type="button" class="btn btn-primary" id="btnAddConfirm">등록</button>
                        <button class="btn btn-primary hidden" id="btnAddConfirmLoading" type="button" disabled>
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
                        </button>
                        <button type="button" class="btn btn-warning hidden" id="btnEditConfirm">수정</button>
                        <button class="btn btn-warning hidden" id="btnEditConfirmLoading" type="button" disabled>
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중
                        </button>
                        <div class="pull-right">
                            <button type="button" class="btn btn-default" id="btnCancel">취소</button>
                        </div>
                    </div>
                </div>
                <!--// 등록, 수정 -->

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
    let scheduleIdx;
    let sideWork = 'add';
    
	// 연도 목록
	function yearSemesterList(yearSemesterIdx) {
		return new Promise(
			function(resolve, reject) {
				$.ajax({
					url : '<c:url value="/yearSemester/list"/>',
					type : 'GET',
					data : {},
					success : function(res) {
						let options = '<option value="">선택</option>';
						$.each(res.data,function(index, item) {
							if(item.semester == '1'){
								options += '<option value="' + item.yearSemesterIdx + '">'
								+ item.year + '년 1학기 </option>';
							} else if(item.semester == '2'){
								options += '<option value="' + item.yearSemesterIdx + '">'
								+ item.year + '년 2학기 </option>';
							} else if(item.semester == '3'){
								options += '<option value="' + item.yearSemesterIdx + '">'
								+ item.year + '년 여름학기 </option>';
							} else if(item.semester == '4'){
								options += '<option value="' + item.yearSemesterIdx + '">'
								+ item.year + '년 겨울학기 </option>';
							} 
						});
						$('#form select[name=yearSemesterIdx]').empty().append(options)
								.val(yearSemesterIdx);
						resolve(yearSemesterIdx);
					}
				});
			});
	}
	
	// 교과목 목록
	function subjectList(subjectIdx) {
		return new Promise(function(resolve, reject) {
			$.ajax({
				url : '<c:url value="/subject/list"/>',
				type : 'GET',
				data : {},
				success : function(res) {
					let options = '<option value="">선택</option>';
					$.each(res.data, function(index, item) {
						options += '<option value="' + item.subjectIdx + '">'
								+ item.subjectName + '</option>';
					});
					$('#form select[name=subjectIdx]').empty().append(options)
							.val(subjectIdx);
					resolve(subjectIdx);
				}
			});
		});
	}

	// 부서/학과 목록
	function departmentList(collegeIdx, departmentIdx) {
		return new Promise(
			function(resolve, reject) {
				$.ajax({
					url : '<c:url value="/department/list"/>',
					type : 'GET',
					data : { 'collegeIdx' : collegeIdx },
					success : function(res) {
						let options = '<option value="">선택</option>';
						$.each(res.data,function(index, item) {
							options += '<option value="' + item.departmentIdx + '">'
									+ item.departmentName + '</option>';
						});
						$('#form select[name=departmentIdx]').empty().append(options)
								.val(departmentIdx);
						resolve();
					}
				});
			});
	}
	
	// 분반 목록
	function classroomList(classroomIdx) {
		return new Promise(function(resolve, reject) {
			$.ajax({
				url : '<c:url value="/classroom/list"/>',
				type : 'GET',
				data : {},
				success : function(res) {
					let options = '<option value="">선택</option>';
					$.each(res.data, function(index, item) {
						options += '<option value="' + item.classroomIdx + '">'
								+ item.classroom + '</option>';
					});
					$('#form select[name=classroomIdx]').empty().append(options)
							.val(classroomIdx);
					resolve();
				}
			});
		});
	}

	// 교시 목록
	function classTimeList(scheduletimeIdx) {
		return new Promise(function(resolve, reject) {
			$.ajax({
				url : '<c:url value="/scheduletime/list"/>',
				type : 'GET',
				data : {},
				success : function(res) {
					let options = '<option value="">선택</option>';
					$.each(res.data, function(index, item) {
						options += '<option value="' + item.scheduletimeIdx + '">'
								+ item.classTime + '</option>';
					});
					$('#form select[name=scheduletimeIdx]').empty().append(options)
							.val(scheduletimeIdx);
					resolve();
				}
			});
		});
	}
	
	// 시작 시간 목록
	function startTimeList(scheduletimeIdx) {
		return new Promise(function(resolve, reject) {
			$.ajax({
				url : '<c:url value="/scheduletime/list"/>',
				type : 'GET',
				data : {},
				success : function(res) {
					let options = '<option value="">선택</option>';
					$.each(res.data, function(index, item) {
						options += '<option value="' + item.scheduletimeIdx + '">'
								+ item.startTime + '</option>';
					});
					$('#form select[name=startTime]').empty().append(options)
							.val(startTime);
					resolve();
				}
			});
		});
	}
	
	// 종료 시간 목록
	function endTimeList(scheduletimeIdx) {
		return new Promise(function(resolve, reject) {
			$.ajax({
				url : '<c:url value="/scheduletime/list"/>',
				type : 'GET',
				data : {},
				success : function(res) {
					let options = '<option value="">선택</option>';
					$.each(res.data, function(index, item) {
						options += '<option value="' + item.scheduletimeIdx + '">'
								+ item.endTime + '</option>';
					});
					$('#form select[name=endTime]').empty().append(options)
							.val(endTime);
					resolve();
				}
			});
		});
	}

    // 수정항목 정보
    function viewEditData(data) {
    	console.log(data);
        // 보김, 숨김
        $('#useDelete').addClass('hidden');
        $('#viewBox').removeClass('hidden');
        $('#formBox').addClass('hidden');

        // 보기
		$('#year').text(data.year);
		if(data.semester == '1'){
			$('#semester').text('1학기');
		} else if(data.semester == '2'){
			$('#semester').text('2학기');
		} else if(data.semester == '3'){
			$('#semester').text('여름학기');
		} else if(data.semester == '4'){
			$('#semester').text('겨울학기');
		}
		$('#subjectName').text(data.subjectName);
		$('#departmentName').text(data.departmentName);
		$('#classroom').text(data.classroom);
		$('#week').text(data.week);
		$('#scheduleDate').text(data.scheduleDate);
        $('#classTime').text(data.classTime);
        $('#startTime').text(data.startTime);
        $('#endTime').text(data.endTime);
        $('#createDateTime').text( moment(data.createDateTime,'YYYYMMDDHHmmss').format('YYYY-MM-DD HH:mm') );
        $('#createUserName').text(data.createUserName);

        // 수정한 사람, 수정일시
        if (data.updateUserName) {
            $('#updateDateTimeTable').removeClass('hidden');
            $('#updateDateTime').text( moment(data.updateDateTime,'YYYYMMDDHHmmss').format('YYYY-MM-DD HH:mm') );
            $('#updateUserName').text(data.updateUserName);
        }

        // 삭제한 사람, 삭제일시
        if (data.deleteUserName) {
            $('#deleteDateTimeTable').removeClass('hidden');
            $('#deleteDateTime').text( moment(data.deleteDateTime,'YYYYMMDDHHmmss').format('YYYY-MM-DD HH:mm') );
            $('#deleteUserName').text(data.deleteUserName);
        }

        // 수정
        $('#form select[name=yearSemesterIdx]').val(data.yearSemesterIdx);
        $('#form select[name=subjectIdx]').val(data.subjectIdx);
        $('#form select[name=departmentIdx]').val(data.departmentIdx);
        $('#form select[name=classroom]').val(data.classroom);
        $('#form input[name=week]').val(data.week);
        $('#form input[name=scheduleDate]').val(data.scheduleDate);
        $('#form select[name=classTime]').val(data.classTime);
        $('#form select[name=startTime]').val(data.startTime);
        $('#form select[name=endTime]').val(data.endTime);
        $('#form select[name=useYN]').val(data.useYN);
        $('#form select[name=deleteYN]').val(data.deleteYN);
        
		yearSemesterList(data.yearSemesterIdx); // 연도/학기 목록 
		
		departmentList(data.collegeIdx, data.departmentIdx); // 부서/학과 목록
		
		subjectList(data.subjectIdx); // 교과목 목록
		
		classTimeList(data.scheduletimeIdx); // 교시 목록
		
		startTimeList(data.scheduletimeIdx); // 시작 시간 목록
		
		endTimeList(data.scheduletimeIdx); // 종료 시간 목록
		
		classroomList(data.classroomIdx); // 분반 목록
    }

    // 목록
    let scheduleTable = $('#scheduleTable').DataTable({
        language: lang_kor,
        paging: true,
        pageLength: 20,
        info: true,
        ordering: true,
        processing: true,
        autoWidth: false,
        ajax: {
            url: '<c:url value="/schedule/list"/>',
            type: 'GET',
            data: function ( d ) {
            }
        },
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
			{ data: 'subjectName' },
			{ data: 'departmentName' },
			{ data: 'classroom' },
			{ data: 'week' },
			{ data: 'scheduleDate' },
            { data: 'classTime' },
            { data: 'startTime' },
            { data: 'endTime' },
            {
                render: function(data, type, row) {
                    if (row['useYN'] == 'Y') {
                        return '사용';
                    } else {
                        return '<span class="text-danger">사용안함</span>';
                    }
                }
            },
            {
                render: function(data, type, row) {
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
            [ 0, 'asc' ]
        ],
        createdRow: function ( row, data, dataIndex, cells ) {
            $(row).attr('data-schedule-idx', data.scheduleIdx);
        },
    });

    // 보기
    $('#scheduleTable tbody').on('click', 'tr', function () {
        sideWork = 'view';
        scheduleIdx = $(this).data('schedule-idx');

        $.ajax({
            url: '<c:url value="/schedule/view"/>',
            type: 'GET',
            data: {
                'scheduleIdx': scheduleIdx
            },
            success: function (res) {
                viewEditData(res.data);
            }
        });
    });
</script>

<%@include file="create.jsp" %>
<%@include file="update.jsp" %>
<%@include file="delete.jsp" %>

</body>
</html>
