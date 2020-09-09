const CLOSER_TIME = 1500
const READ_CLOSER_TIME = 3000

export function deleteSubject() {
  $('body').on('click', '#subjects-tbl .delete-subject-item', function(event) {
    event.preventDefault();
    let url = this.getAttribute('href');
    Swal.fire({
      title: I18n.t('js.trainer.subject.d_confirm_title'),
      text: I18n.t('js.trainer.subject.d_confirm_text'),
      showCancelButton: true,
      icon: 'warning',
      confirmButtonText: I18n.t('js.trainer.subject.d_btn_confirm'),
      cancelButtonText: I18n.t('js.trainer.subject.d_btn_cancel')
    }).then((result) => {
      if (result.value) {
        $.ajax({
          url: url,
          type: 'delete',
          success: function(response) {
            if (response.success) {
              customAlert('sc');
              let id = response.subject_id;
              $('#row-' + id).remove();
              reloadPage();
            } else if (response.active_course) {
              customAlert('err', I18n.t('js.trainer.subject.action.cant_delete'));
            } else {
              customAlert('err');
            }
          },
          error: function(error) {
            customAlert('err');
          }
        });
      }
    })
  });
}

export function customAlert(type, action = I18n.t('js.trainer.subject.action.delete')) {
  let prefix = type;
  let vari = 'js.trainer.subject.res.' + action + '.' + prefix;
  Swal.fire({
    title: I18n.t(vari + '_title'),
    text: I18n.t(vari + '_text'),
    icon: I18n.t(vari + '_class'),
    timer: CLOSER_TIME
  });
}

export function reloadPage() {
  let element = $('#paginator .page-item.active')[0];
  let current_page = parseInt(element.firstElementChild.text);
  let number_records = $('#subjects-tbl #subjects-tbody').childElementCount;
  let next_page = element.nextElementSibling
  if (next_page == null) {

  } else {
    $(element).trigger('click')
  }
}

export function viewSubjectDetail() {
  $('body').on('click', '#subjects-tbl .detail-subject-item', function(event){
    event.preventDefault();
    let url = this.getAttribute('href');
    $.ajax({
      url: url,
      type: 'get',
      success: function(response) {
        if(response.err){
          customAlert('err', I18n.t('js.trainer.subject.action.show'));
        }
      },
      error: function(error) {
        customAlert('err', I18n.t('js.trainer.subject.action.show'));
      }
    });
  })
}

export function showEditForm() {
  $('body').on('click', '#subjects-tbl .edit-subject-item', function(event){
    event.preventDefault();
    let url = this.getAttribute('href');
    $.ajax({
      url: url,
      type: 'get',
      success: function(response) {

      },
      error: function(error) {
        customAlert('err', I18n.t('js.trainer.subject.action.show'));
      }
    });
  })
}
