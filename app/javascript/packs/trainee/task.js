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
              customAlert('err', I18n.t('js.trainer.subject.action.show'));
            }
          },
          error: function(error) {
            customAlert('err', I18n.t('js.trainer.subject.action.show'));
          }
        });
      }
    })
  });
}
