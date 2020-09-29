import {customAlert} from '../trainer/subject';

export function updateTask(){
  $('body').on('click', '#list-tasks .form-task .btn-update-task', function(event) {
    event.preventDefault();
    let f = $(this).parent('.form-task');
    let url = f.attr('action');
    let id = f.data('id');
    Swal.fire({
      title: I18n.t('js.trainee.task.confirm_title'),
      text: I18n.t('js.trainee.task.confirm_text'),
      showCancelButton: true,
      icon: 'warning',
      confirmButtonText: I18n.t('js.trainee.task.btn_confirm'),
      cancelButtonText: I18n.t('js.trainee.task.btn_cancel')
    }).then((result) => {
      if (result.value) {
        $.ajax({
          url: url,
          type: 'patch',
          data: f.serialize(),
          success: function(response) {
            if (response.err){
              customAlert('err', false, I18n.t('js.trainee.task.action.update'));
            }
          },
          error: function(error) {
            customAlert('err', false, I18n.t('js.trainee.task.action.update'));
          }
        });
      }
    })
  });
}

export function finishSubject(){
  $('body').on('click', '.user-subject-card .edit_user_course_subject .btn-finish-subject', function(event) {
    event.preventDefault();
    let f = $(this).parent('.edit_user_course_subject');
    let url = f.attr('action');
    Swal.fire({
      title: I18n.t('js.trainee.finish_subject.confirm_title'),
      text: I18n.t('js.trainee.finish_subject.confirm_text'),
      showCancelButton: true,
      icon: 'warning',
      confirmButtonText: I18n.t('js.trainee.finish_subject.btn_confirm'),
      cancelButtonText: I18n.t('js.trainee.finish_subject.btn_cancel')
    }).then((result) => {
      if (result.value) {
        $.ajax({
          url: url,
          type: 'patch',
          success: function(response) {
            if (response.success){
              $('.edit_user_course_subject').html('<i class="fas fa-check-circle fa-2x text-primary"></i>')
            } else {
              customAlert('err', false, I18n.t('js.trainee.finish_subject.action.finish_subject'));
            }
          },
          error: function(error) {
            customAlert('err', false, I18n.t('js.trainee.finish_subject.action.finish_subject'));
          }
        });
      }
    })
  });
}
