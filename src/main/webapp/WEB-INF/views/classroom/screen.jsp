<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%@include file="../layout/contents/top.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>교과목</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> 전자출결</a></li>
			<li><a href="#">기준정보</a></li>
			<li class="active">교수별 교과목</li>
		</ol>
	</section>

	<!-- Main content -->
	<section class="content">
		<div class="row">

			<div class="col-md-8">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">교수별 교과목 목록</h3>
						<div class="box-tools">
							<button type="button" class="btn btn-success" id="btnShowCreate">신규등록</button>
						</div>
					</div>
					<div class="box-body">
						<table class="table table-bordered table-hover" id="classroomTable">
							<thead>
								<tr>
									<th>연도</th>
									<th>학기</th>
									<th>대학/학부</th>
									<th>부서/학과</th>
									<th>교과목</th>
									<th>교수</th>
									<th>분반</th>
									<th>학생추가</th>
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
						<h3 class="box-title">교과목 정보</h3>
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
								<th>대학/학부</th>
								<td><span id="collegeName"></span></td>
							</tr>
							<tr>
								<th>학과/부서</th>
								<td><span id="departmentName"></span></td>
							</tr>
							<tr>
								<th>교과목</th>
								<td><span id="subjectName"></span>
							</tr>
							<tr>
								<th>교수</th>
								<td><span id="professorName"></span>
							</tr>
							<tr>
								<th>분반</th>
								<td><span id="classroom"></span>
							</tr>
						</table>
						<table class="table table-bordered table-hover"
							style="margin-top: 10px;">
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
						<table class="table table-bordered table-hover hidden"
							id="updateDateTimeTable" style="margin-top: 10px;">
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
						<table class="table table-bordered table-hover hidden"
							id="deleteDateTimeTable" style="margin-top: 10px;">
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
							<button type="button" class="btn btn-danger" id="btnDelete"
								data-toggle="modal" data-target="#deleteModal">삭제</button>
						</div>
					</div>
				</div>
				<!--// 보기 -->

				<!-- 등록, 수정 -->
				<div class="box" id="formBox">
					<div class="box-header">
						<h3 class="box-title">
							교수별 교과목 <span id="formText">등록</span>
						</h3>
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
									<th>대학/학부</th>
									<td><select class="form-control" name="collegeIdx">
											<option value="">선택</option>
											<c:forEach var="collegeList" items="${collegeList}">
												<option value="${collegeList.collegeIdx}">${collegeList.collegeName}</option>
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
									<th>교과목</th>
									<td><select class="form-control" name="subjectIdx">
											<option value="">선택</option>
											<c:forEach var="subjectList" items="${subjectList}">
												<option value="${subjectList.subjectIdx}">${subjectList.subjectName}</option>
											</c:forEach>
									</select></td>
								</tr>
								<tr>
									<th>교수</th>
									<td><select class="form-control" name="professorIdx">
											<option value="">선택</option>
											<c:forEach var="userList" items="${userList}">
												<option value="${userList.userIdx}">${userList.userName}</option>
											</c:forEach>
											
									</select> 
								</tr>
								<tr>
									<th>분반</th>
									<td><input type="text" class="form-control"
										name="classroom"></td>
								</tr>
							</table>
							<table class="table table-bordered table-hover hidden"
								id="useDelete" style="margin-top: 10px;">
								<colgroup>
									<col width="120">
									<col>
								</colgroup>
								<tr>
									<th>사용</th>
									<td><select class="form-control" name="useYN">
											<option value="Y">사용</option>
											<option value="N">사용안함</option>
									</select></td>
								</tr>
								<tr>
									<th>삭제</th>
									<td><select class="form-control" name="deleteYN">
											<option value="Y">삭제</option>
											<option value="N">삭제안함</option>
									</select></td>
								</tr>
							</table>
						</form>
					</div>
					<div class="box-footer">
						<button type="button" class="btn btn-primary" id="btnAddConfirm">등록</button>
						<button class="btn btn-primary hidden" id="btnAddConfirmLoading"
							type="button" disabled>
							<span class="spinner-border spinner-border-sm" role="status"
								aria-hidden="true"></span> 처리중
						</button>
						<button type="button" class="btn btn-warning hidden"
							id="btnEditConfirm">수정</button>
						<button class="btn btn-warning hidden" id="btnEditConfirmLoading"
							type="button" disabled>
							<span class="spinner-border spinner-border-sm" role="status"
								aria-hidden="true"></span> 처리중
						</button>
						<div class="pull-right">
							<button type="button" class="btn btn-default" id="btnCancel">취소</button>
						</div>
					</div>
				</div>
				<!--// 등록, 수정 -->
			</div>
			
			<div class="col-md-8">
				<div class="box">
					<div class="box-header">
						<h3 class="box-title">수강 학생</h3>
					</div>
					<div class="box-body">
						<table class="table table-bordered table-hover" id="lectureStudentTable">
							<thead>
								<tr>
									<th>부서/학과</th>
									<th>이름</th>
									<th>아이디</th>
									<th>전화번호</th>
									<th>이메일</th>
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
	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<!-- 학생 모달 -->
<div class="modal fade" id="lectureStudentModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="lectureStudentModal" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 id="exampleModalAlertWarningLabel" class="modal-title">
                    <i class="fa fa-bullhorn text-warning mr-1"></i> 학생 목록
                </h5>
            </div>
            <div class="modal-body">
                <table id="lectureStudentModalTable" class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th><input type="checkbox" name="lectureStudentModalAll" value=""/></th>
                            <th>학과</th>
                            <th>이름</th>
                            <th>아이디</th>
                            <th>전화번호</th>
                            <th>이메일</th>
                            <th>사용</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="btnStudentAddConfirm">추가</button>
                <button class="btn btn-primary" id="btnStudentAddConfirmLoading" type="button" disabled="" style="display:none;"><span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> 처리중</button>
                &nbsp;<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- 학생 모달 -->

<%@include file="../layout/contents/footer.jsp"%>
<%@include file="../layout/contents/bottom.jsp"%>
<%@include file="../layout/contents/script.jsp"%>

<script>
	let classroomIdx;
	let sideWork = 'add';
    let lectureStudentModalCheckboxAll = false;
    let deleteLectureStudentIdx;

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

	// 대학/학부 목록
	function collegeList(collegeIdx, departmentIdx) {
		return new Promise(function(resolve, reject) {
			$.ajax({
				url : '<c:url value="/college/list"/>',
				type : 'GET',
				data : {},
				success : function(res) {
					let options = '<option value="">선택</option>';
					$.each(res.data, function(index, item) {
						options += '<option value="' + item.collegeIdx + '">'
								+ item.collegeName + '</option>';
					});
					$('#form select[name=collegeIdx]').empty().append(options)
							.val(collegeIdx);
					resolve(collegeIdx, departmentIdx);
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

	// 교수 목록
	function userList(userIdx) {
		return new Promise(function(resolve, reject) {
			$.ajax({
				url : '<c:url value="/user/list"/>',
				type : 'GET',
				data : {},
				success : function(res) {
					let options = '<option value="">선택</option>';
					$.each(res.data, function(index, item) {
						options += '<option value="' + item.userIdx + '">'
								+ item.userName + '</option>';
					});
					$('#form select[name=userIdx]').empty().append(options)
							.val(userIdx);
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
		$('#collegeName').text(data.collegeName);
		$('#departmentName').text(data.departmentName);
		$('#subjectName').text(data.subjectName);
		$('#professorName').text(data.professorName);
		$('#classroom').text(data.classroom);
		$('#createDateTime').text(moment(data.createDateTime, 'YYYYMMDDHHmmss').format('YYYY-MM-DD HH:mm'));
		$('#createUserName').text(data.createUserName);

		// 수정한 사람, 수정일시
		if (data.updateUserName) {
			$('#updateDateTimeTable').removeClass('hidden');
			$('#updateDateTime').text(
					moment(data.updateDateTime, 'YYYYMMDDHHmmss').format(
							'YYYY-MM-DD HH:mm'));
			$('#updateUserName').text(data.updateUserName);
		}

		// 삭제한 사람, 삭제일시
		if (data.deleteUserName) {
			$('#deleteDateTimeTable').removeClass('hidden');
			$('#deleteDateTime').text(
					moment(data.deleteDateTime, 'YYYYMMDDHHmmss').format(
							'YYYY-MM-DD HH:mm'));
			$('#deleteUserName').text(data.deleteUserName);
		}

		// 수정
		$('#form select[name=professorIdx]').val(data.professorIdx);
		$('#form input[name=classroom]').val(data.classroom);
		$('#form select[name=useYN]').val(data.useYN);
		$('#form select[name=deleteYN]').val(data.deleteYN);

		yearSemesterList(data.yearSemesterIdx); // 연도 목록 

		collegeList(data.collegeIdx, data.departmentIdx) // 대학/학부 목록
		.then(departmentList(data.collegeIdx, data.departmentIdx)); // 부서/학과 목록

		subjectList(data.subjectIdx); // 교과목 목록

		userList(data.professorIdx); // 교수 목록
	}

	// 대학/학부 변경할 경우
	$('#form select[name=collegeIdx]').on('change', function() {
		let collegeIdx = $(this).val();
		departmentList(collegeIdx, '');
	});
	
	// 목록
	let classroomTable = $('#classroomTable').DataTable({
		language : lang_kor,
		paging : true,
		pageLength : 20,
		info : true,
		ordering : true,
		processing : true,
		autoWidth : false,
		ajax : {
			url : '<c:url value="/classroom/list"/>',
			type : 'GET',
			data : function(d) {
			}
		},
		columns : [ 
			{ data : 'year' }, 
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
			{ data : 'classroom' },
			{
	            render: function(data, type, row) {
	                let button = '<button type="button" class="btn btn-primary" data-classroom-idx="' + row['classroomIdx'] + '" id="btnLectureStudentAdd">학생추가</button>';
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
		columnDefs : [ {
		//'targets': [0],
		//'orderable': false,
		//'searchable': false,
		}, ],
		order : [ [ 0, 'asc' ], [ 1, 'asc' ], [ 2, 'asc' ], ],
		createdRow : function(row, data, dataIndex, cells) {
			$(row).attr('data-classroom-idx', data.classroomIdx);
		},
	});

	// 보기
	$('#classroomTable tbody').on('click', 'tr', function() {
		sideWork = 'view';
		classroomIdx = $(this).data('classroom-idx');

		$.ajax({
			url : '<c:url value="/classroom/view"/>',
			type : 'GET',
			data : {
				'classroomIdx' : classroomIdx
			},
			success : function(res) {
				viewEditData(res.data);
				lectureStudentTable();
			}
		});
	});
    
</script>
<%@include file="create.jsp"%>
<%@include file="update.jsp"%>
<%@include file="delete.jsp"%>
<%@include file="modalStudentScreen.jsp"%>
<%@include file="modalStudentCreate.jsp"%>
<%@include file="lectureStudentScreen.jsp"%>
<%@include file="lectureStudentDelete.jsp"%>
</body>
</html>
